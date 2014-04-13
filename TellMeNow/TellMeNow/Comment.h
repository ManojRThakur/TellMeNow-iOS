//
//  Comment.h
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 4/12/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User, Question;

@interface Comment : NSObject

@property (strong, nonatomic) NSString *_id;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *userId; //Required
@property (nonatomic, strong) NSString *questionId; //Required
@property (nonatomic, strong) NSMutableArray *notificationIds;

- (void)getUserWithCallback: (void *(^)(User *))callback;
- (void)getNotificationsWithCallback: (void *(^)(NSArray *))callback;
- (void)getQuestionWithCallback: (void *(^)(Question *))callback;

+ (Comment *)commentFromDict: (NSDictionary *)args;

@end
