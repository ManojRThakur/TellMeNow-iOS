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
        NSFetchRequest *fetchRequest = (NSFetchRequest *)request;
        NSEntityDescription *entity = [fetchRequest entity];
        //fetchRequest.predicate.
    }
    return nil;
}

@end
