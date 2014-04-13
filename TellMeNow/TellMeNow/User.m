//
//  User.m
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 4/12/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "User.h"

@implementation User

+ (User *)userFromDict:(NSDictionary *)args
{
    User *user = [User alloc];
    [user set_id:[args objectForKey:@"_id"]];
    [user setName:[args objectForKey:@"name"]];
    [user setReputation:[args objectForKey:@"reputation"]];
    [user setNotificationsSet:[args objectForKey:@"notificationsSet"]];
    [user setNotificationIds:[NSMutableArray arrayWithArray:[args objectForKey:@"notificationIds"]]];
    return user;
}

@end
