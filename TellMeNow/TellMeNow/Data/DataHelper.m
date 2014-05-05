//
//  DataHelper.m
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 5/4/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "DataHelper.h"

NSManagedObjectContext *moContext = nil;

@implementation DataHelper

+ (NSManagedObjectContext *)getManagedObjectContext
{
    if (moContext == nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSManagedObjectModel *moModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:[NSURL URLWithString:[bundle pathForResource:@"Model" ofType:@"momd"]]];
        NSPersistentStoreCoordinator *psCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:moModel];
        [psCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:nil];
        moContext = [[NSManagedObjectContext alloc] init];
        [moContext setPersistentStoreCoordinator:psCoordinator];
    }
    return moContext;
}

@end
