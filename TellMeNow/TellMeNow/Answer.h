//
//  Answer.h
//  TellMeNow
//
//  Created by Raghav on 4/5/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum thumbsTypes
{
    THUMBS_NONE,
    THUMBS_UP,
    THUMBS_DOWN
} Thumbs;

@class Question, User;

@interface Answer : NSObject
@property (strong, nonatomic) NSString *_id;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *timestamp;
@property (strong, nonatomic) NSNumber *reputation;
@property (nonatomic) Thumbs thumbs;
@property (strong, nonatomic) NSString *questionId;
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSMutableArray *notificationIds;
@property (strong, nonatomic) NSMutableArray *followUpIds;

- (Question *)getQuestion;
- (User *)getUser;
- (NSArray *)getNotifications;
- (NSArray *)getFollowUps;

@end
