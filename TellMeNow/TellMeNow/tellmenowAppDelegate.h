//
//  tellmenowAppDelegate.h
//  TellMeNow
//
//  Created by Raghav on 4/4/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocketIO.h"

@class User;
 
@interface tellmenowAppDelegate : UIResponder <UIApplicationDelegate, SocketIODelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SocketIO *socket;
@property (strong, nonatomic) UIAlertView *connErrorAlertView;
@property (strong, nonatomic) User *me;

@property (strong, nonatomic) NSMutableDictionary *questionMap;
@property (strong, nonatomic) NSMutableDictionary *notificationMap;
@property (strong, nonatomic) NSMutableDictionary *placeMap;
@property (strong, nonatomic) NSMutableDictionary *answerMap;
@property (strong, nonatomic) NSMutableDictionary *userMap;
@property (strong, nonatomic) NSMutableDictionary *commentMap;
@property (strong, nonatomic) NSMutableDictionary *followUpMap;

@end
