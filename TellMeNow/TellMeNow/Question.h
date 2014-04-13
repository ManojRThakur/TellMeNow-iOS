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
@property (strong, nonatomic) NSString *placeId; //Required
@property (strong, nonatomic) NSMutableArray *commentIds; //Required
@property (strong, nonatomic) NSString *userId; //Required
@property (strong, nonatomic) NSMutableArray *notificationIds;
@property (strong, nonatomic) NSMutableArray *answerIds; //Required

- (void)getPlaceWithCallback: (void *(^)(Place *))callback;
- (void)getCommentsWithCallback: (void *(^)(NSArray *))callback;
- (void)getUserWithCallback: (void *(^)(User *))callback;
- (void)getNotificationsWithCallback: (void *(^)(NSArray *))callback;
- (void)getAnswersWithCallback: (void *(^)(NSArray *))callback;

- (Place *)getPlace;

+ (Question *)questionFromDict: (NSDictionary *)args;

@end
