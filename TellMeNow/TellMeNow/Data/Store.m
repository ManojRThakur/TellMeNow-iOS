//
//  Store.m
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 5/4/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "Store.h"

@implementation Store

+ (void)initialize {
    [NSPersistentStoreCoordinator registerStoreClass:self forStoreType:[self type]];
}

+ (NSString *)type {
    return NSStringFromClass(self);
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
        NSArray *moIds = nil;
        if ([fetchRequest.predicate isKindOfClass:[NSComparisonPredicate class]]) {
            NSComparisonPredicate *cPredicate = (NSComparisonPredicate *)fetchRequest.predicate;
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
            NSMutableArray *bsonIds = [NSMutableArray array];
            for (NSManagedObjectID *moId in moIds) {
                [bsonIds addObject:[self referenceObjectForObjectID:moId]];
            }
            // Here
        }
    }
    return nil; // NIL
}

@end
