//
//  Notification.h
//  TellMeNow
//
//  Created by Raghav on 4/5/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question, Comment, FollowUp, Answer, User;

typedef enum notificationForTypes
{
    QUESTION_NOTIFICATION,
    ANSWER_NOTIFICATION,
    COMMENT_NOTIFICATION,
    FOLLOWUP_NOTIFICATION
} NotificationFor;

@interface Notification : NSObject

@property (strong, nonatomic) NSString *_id;
@property (nonatomic) NotificationFor notificationFor;
@property (strong, nonatomic) NSString *questionId; //Required
@property (strong, nonatomic) NSString *userId; //Required
@property (strong, nonatomic) NSString *commentId; //Required
@property (strong, nonatomic) NSString *followUpId; //Required
@property (strong, nonatomic) NSString *answerId; //Required

- (void)getQuestionWithCallback: (void *(^)(Question *))callback;
- (void)getUserWithCallback: (void *(^)(User *))callback;
- (void)getCommentWithCallback: (void *(^)(Comment *))callback;
- (void)getFollowUpWithCallback: (void *(^)(FollowUp *))callback;
- (void)getAnswerWithCallback: (void *(^)(Answer *))callback;

@end
