//
//  Store.m
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 5/4/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "Store.h"
#import "TellMeNowAPI.h"

@implementation Store

+ (void)initialize {
    [NSPersistentStoreCoordinator registerStoreClass:self forStoreType:[self type]];
}

+ (NSString *)type {
    return NSStringFromClass(self);
}

- (id)init
{
    if (self = [super init]) {
        cache = [NSMutableDictionary dictionary];
    }
    return self;
}

- (id)initWithPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)root configurationName:(NSString *)name URL:(NSURL *)url options:(NSDictionary *)options
{
    if (self = [super initWithPersistentStoreCoordinator:root configurationName:name URL:url options:options]) {
        cache = [NSMutableDictionary dictionary];
    }
    return self;
}

- (BOOL)loadMetadata:(NSError *__autoreleasing *)error
{
    NSDictionary *metadata = @{NSStoreUUIDKey: [[NSProcessInfo processInfo] globallyUniqueString],
                               NSStoreTypeKey: [[self class] type]};
    [self setMetadata:metadata];
    return YES;
}

- (id)executeRequest:(NSPersistentStoreRequest *)request withContext:(NSManagedObjectContext *)context error:(NSError *__autoreleasing *)error
{
    if ([request requestType] == NSFetchRequestType) {
        return [self fetchObjects:(NSFetchRequest *)request withContext:context];
    }
    return nil; // NIL
}

- (id)fetchObjects:(NSFetchRequest *)fetchRequest withContext:(NSManagedObjectContext *)context
{
    if ([fetchRequest.entityName isEqualToString:@"User"]) {
        if ([fetchRequest.predicate isKindOfClass:[NSComparisonPredicate class]]) {
            NSComparisonPredicate *cPredicate = (NSComparisonPredicate *)fetchRequest.predicate;
            NSArray *moIds = nil;
            if (cPredicate.predicateOperatorType == NSInPredicateOperatorType
                && cPredicate.leftExpression.expressionType == NSKeyPathExpressionType
                && [cPredicate.leftExpression.keyPath isEqualToString:@"id"]
                && cPredicate.rightExpression.expressionType == NSConstantValueExpressionType
                && [cPredicate.rightExpression.constantValue isKindOfClass:[NSArray class]]) {
                moIds = cPredicate.rightExpression.constantValue;
            } else if (cPredicate.predicateOperatorType == NSEqualToPredicateOperatorType
                       && cPredicate.leftExpression.expressionType == NSKeyPathExpressionType
                       && [cPredicate.leftExpression.keyPath isEqualToString:@"id"]
                       && cPredicate.rightExpression.expressionType == NSConstantValueExpressionType
                       && [cPredicate.rightExpression.constantValue isKindOfClass:[NSManagedObjectID class]]) {
                moIds = @[cPredicate.rightExpression.constantValue];
            }
            else {
                NSLog(@"Could not understand predicate.");
                return nil;
            }
            NSMutableArray *mObjects = [NSMutableArray array];
            for (NSManagedObjectID *moId in moIds) {
                [mObjects addObject:[context objectWithID:moId]];
            }
            return mObjects;
        }
    }
    NSLog(@"Could not understand predicate.");
    return nil;
}

- (NSIncrementalStoreNode *)newValuesForObjectWithID:(NSManagedObjectID *)objectID withContext:(NSManagedObjectContext *)context error:(NSError *__autoreleasing *)error
{
    NSDictionary *cached = [cache objectForKey:objectID];
    if (cached == nil) {
        cached = [[TellMeNowAPI sharedAPI] usersForIds:@[[self referenceObjectForObjectID:objectID]]][0];
        [cache setObject:cached forKey:objectID];
    }
    NSDictionary *attributes;
    if ([[[objectID entity] name] isEqualToString:@"User"]) {
        attributes = @{@"name": [cached objectForKey:@"name"],
                       @"notificationsAllowed": [cached objectForKey:@"notificationsSet"],
                       @"reputation": [cached objectForKey:@"reputation"]};
    }
    return [[NSIncrementalStoreNode alloc] initWithObjectID:objectID withValues:attributes version:1];
}

- (NSManagedObjectID *)objectIdForEntity:(NSEntityDescription *)entity andBsonId:(NSString *)bsonId
{
    static NSMutableDictionary *idCache = nil;
    if (idCache == nil) {
        idCache = [NSMutableDictionary dictionary];
    }
    NSManagedObjectID *moId = nil;
    moId = [idCache objectForKey:bsonId];
    if (moId == nil) {
        moId = [self newObjectIDForEntity:entity referenceObject:bsonId];
        [idCache setObject:moId forKey:bsonId];
    }
    return moId;
}

- (id)newValueForRelationship:(NSRelationshipDescription *)relationship forObjectWithID:(NSManagedObjectID *)objectID withContext:(NSManagedObjectContext *)context error:(NSError *__autoreleasing *)error
{
    if ([cache objectForKey:objectID] == nil) {
        return nil;
    }
    NSArray *bsonIds = nil;
    if ([[[relationship entity] name] isEqualToString:@"User"]) {
        if ([relationship.name isEqualToString:@"answers"]) {
            bsonIds = [[cache objectForKey:objectID] objectForKey:@"answers"];
        } else if ([relationship.name isEqualToString:@"comments"]) {
            bsonIds = [[cache objectForKey:objectID] objectForKey:@"comments"];
        } else if ([relationship.name isEqualToString:@"followUps"]) {
            bsonIds = [[cache objectForKey:objectID] objectForKey:@"followUps"];
        } else if ([relationship.name isEqualToString:@"notifications"]) {
            bsonIds = [[cache objectForKey:objectID] objectForKey:@"notifications"];
        } else if ([relationship.name isEqualToString:@"questions"]) {
            bsonIds = [[cache objectForKey:objectID] objectForKey:@"questions"];
        }
    }
    if (bsonIds == nil) {
        bsonIds = [NSArray array];
    }
    NSMutableArray *moIds = [NSMutableArray array];
    for (NSString *bsonId in bsonIds) {
        [moIds addObject:[self objectIdForEntity:[relationship destinationEntity] andBsonId:bsonId]];
    }
    return moIds;
}

@end
