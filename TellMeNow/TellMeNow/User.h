//
//  User.h
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 4/12/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic) NSString *_id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *reputation;
@property (strong, nonatomic) NSNumber *notificationsSet;
@property (strong, nonatomic) NSMutableArray *commentIds;
@property (strong, nonatomic) NSMutableArray *followUpIds;
@property (strong, nonatomic) NSMutableArray *notificationIds;
@property (strong, nonatomic) NSMutableArray *answerIds;
@property (strong, nonatomic) NSMutableArray *questionIds;

- (NSArray *)getComments;
- (NSArray *)getFollowUps;
- (NSArray *)getNotifications;
- (NSArray *)getAnswers;
- (NSArray *)getQuestions;

@end
