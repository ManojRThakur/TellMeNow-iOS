//
//  tellmenowAppDelegate.h
//  TellMeNow
//
//  Created by Raghav on 4/4/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "SocketIO.h"
 
@interface tellmenowAppDelegate : UIResponder <UIApplicationDelegate, SocketIODelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FBSession *session;

@end
