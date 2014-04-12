//
//  Question.h
//  TellMeNow
//
//  Created by Raghav on 4/5/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Place, User;

@interface Question : NSObject

@property (strong, nonatomic) NSString *_id;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *timestamp;
@property (strong, nonatomic) NSString *placeId;
@property (strong, nonatomic) NSMutableArray *commentIds;
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSMutableArray *notificationIds;
@property (strong, nonatomic) NSMutableArray *answerIds;

- (Place *)getPlace;
- (NSArray *)getComments;
- (User *)getUser;
- (NSArray *)getNotifications;
- (NSArray *)getAnswers;

@end