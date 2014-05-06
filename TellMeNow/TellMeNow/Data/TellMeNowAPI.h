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

+ (TellMeNowAPI *)sharedAPI;

- (NSString *)loginWithAccessToken:(NSString *)accessToken;

- (NSArray *)usersForIds:(NSArray *)userIds;

- (NSArray *)questionsForIds:(NSArray *)questionIds;

- (NSArray *)answersForIds:(NSArray *)answerIds;

- (NSArray *)questionsNearby:(CLLocation *)location;

@property (strong, nonatomic) SocketIO *socket;
@property (strong, nonatomic) UIAlertView *connErrorAlertView;

@end
