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
            NSArray *moIdsToFetch = [moIds filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                return [cache objectForKey:evaluatedObject] == nil;
            }]];
            NSMutableArray *bsonIds = [NSMutableArray array];
            for (NSManagedObjectID *moId in moIdsToFetch) {
                [bsonIds addObject:[self referenceObjectForObjectID:moId]];
            }
            NSArray *dicts = [[TellMeNowAPI sharedAPI] usersForIds:bsonIds];
            for (int i = 0; i < dicts.count; i++) {
                [cache setObject:dicts[i] forKey:moIdsToFetch[i]];
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
    NSDictionary *attributes;
    if ([[[objectID entity] name] isEqualToString:@"User"]) {
        attributes = @{@"name": [cached objectForKey:@"name"],
                       @"notificationsAllowed": [cached objectForKey:@"notificationsSet"],
                       @"reputation": [cached objectForKey:@"reputation"]};
    }
    return [[NSIncrementalStoreNode alloc] initWithObjectID:objectID withValues:attributes version:1];
}

- (id)newValueForRelationship:(NSRelationshipDescription *)relationship forObjectWithID:(NSManagedObjectID *)objectID withContext:(NSManagedObjectContext *)context error:(NSError *__autoreleasing *)error
{
    if ([[[relationship entity] name] isEqualToString:@"User"]) {
        if ([relationship.name isEqualToString:@"answers"]) {
            // ...
        } else if ([relationship.name isEqualToString:@"comments"]) {
            // ...
        } else if ([relationship.name isEqualToString:@"followUps"]) {
            // ...
        } else if ([relationship.name isEqualToString:@"notifications"]) {
            // ...
        } else if ([relationship.name isEqualToString:@"questions"]) {
            // ...
        }
    }
    return nil; // NIL
}

@end
