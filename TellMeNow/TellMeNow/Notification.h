//
//  Notification.h
//  TellMeNow
//
//  Created by Raghav on 4/5/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Place, Question, Comment, FollowUp, Answer, User;

typedef enum notificationForTypes
{
    QUESTION_NOTIFICATION,
    ANSWER_NOTIFICATION,
    COMMENT_NOTIFICATION
} NotificationFor;

@interface Notification : NSObject

@property (strong, nonatomic) NSString *_id;
@property (nonatomic) NotificationFor notificationFor;
@property (strong, nonatomic) NSString *questionId;
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *commentId;
@property (strong, nonatomic) NSString *followUpId;
@property (strong, nonatomic) NSString *answerId;

- (Question *)getQuestion;
- (User *)getUser;
- (Comment *)getComment;
- (FollowUp *)getFollowUp;
- (Answer *)getAnswer;

@end
