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
@property (strong, nonatomic) NSMutableArray *notificationIds; //Required
@property (strong, nonatomic) NSMutableArray *answerIds;
@property (strong, nonatomic) NSMutableArray *questionIds;

- (void)getCommentsWithCallback: (void *(^)(NSArray *))callback;
- (void)getFollowUpsWithCallback: (void *(^)(NSArray *))callback;
- (void)getNotificationsWithCallback: (void *(^)(NSArray *))callback;
- (void)getAnswersWithCallback: (void *(^)(NSArray *))callback;
- (void)getQuestionsWithCallback: (void *(^)(NSArray *))callback;

+ (User *)userFromDict: (NSDictionary *)args;

@end
