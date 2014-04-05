//
//  tellmenowViewController.m
//  TellMeNow
//
//  Created by Raghav on 4/4/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "loginViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface loginViewController ()

@end

@implementation loginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    FBLoginView *loginView = [[FBLoginView alloc] initWithReadPermissions:@[@"basic_info", @"user_checkins"]];
    // Align the button in the center horizontally
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), (self.view.center.y - (loginView.frame.size.height / 2)));
    [self.view addSubview:loginView];
}


@end
