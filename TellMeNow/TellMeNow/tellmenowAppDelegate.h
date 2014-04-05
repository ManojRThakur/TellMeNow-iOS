//
//  tellmenowAppDelegate.h
//  TellMeNow
//
//  Created by Raghav on 4/4/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocketIO.h"
 
@interface tellmenowAppDelegate : UIResponder <UIApplicationDelegate, SocketIODelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SocketIO *socket;
@property (strong, nonatomic) UIAlertView *connErrorAlertView;

@end
