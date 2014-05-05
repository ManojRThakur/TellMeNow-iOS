//
//  DataHelper.h
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 5/4/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataHelper : NSObject

+ (NSManagedObjectContext *)getManagedObjectContext;

@end
