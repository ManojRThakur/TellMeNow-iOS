//
//  TellMeNowAPI.h
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 5/4/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "SocketIO.h"

@interface TellMeNowAPI : NSObject <SocketIODelegate, UIAlertViewDelegate>

- (void)loginWithAccessToken:(NSString *)accessToken andCallback:(void *(^)(NSString *))callback;

- (void)usersForIds:(NSArray *)userIds andCallback:(void *(^)(NSArray *))callback;

- (void)questionsForIds:(NSArray *)questionIds andCallback:(void *(^)(NSArray *))callback;

- (void)answersForIds:(NSArray *)answerIds andCallback:(void *(^)(NSArray *))callback;

- (void)questionsNearby:(CLLocation *)location andCallback:(void *(^)(NSArray *))callback;

@property (strong, nonatomic) SocketIO *socket;
@property (strong, nonatomic) UIAlertView *connErrorAlertView;

@end
