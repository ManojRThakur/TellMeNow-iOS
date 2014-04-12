//
//  FollowUp.h
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 4/12/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User, Answer;

@interface FollowUp : NSObject

@property (strong, nonatomic) NSString *_id;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSMutableArray *notificationIds;
@property (nonatomic, strong) NSString *userId; //Required
@property (nonatomic, strong) NSString *answerId; //Required

- (NSArray *)getNotifications;
- (User *)getUser;
- (Answer *)getAnswer;

@end
