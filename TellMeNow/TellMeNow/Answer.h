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
@property (strong, nonatomic) NSString *questionId; //Required
@property (strong, nonatomic) NSString *userId; //Required
@property (strong, nonatomic) NSMutableArray *notificationIds;
@property (strong, nonatomic) NSMutableArray *followUpIds; //Required

- (void)getQuestionWithCallback: (void *(^)(Question *))callback;
- (void)getUserWithCallback: (void *(^)(User *))callback;
- (void)getNotificationsWithCallback: (void *(^)(NSArray *))callback;
- (void)getFollowUpsWithCallback: (void *(^)(NSArray *))callback;

+ (Answer *)answerFromDict: (NSDictionary *)args;

@end
