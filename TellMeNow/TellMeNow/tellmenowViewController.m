//
//  tellmenowViewController.m
//  TellMeNow
//
//  Created by Raghav on 4/4/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "tellmenowViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface tellmenowViewController ()

@end

@implementation tellmenowViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    FBLoginView *loginView = [[FBLoginView alloc] initWithReadPermissions:@[@"basic_info", @"email", @"user_locations", @"friends_locations"]];
    // Align the button in the center horizontally
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), (self.view.center.y - (loginView.frame.size.height / 2)));
    [self.view addSubview:loginView];
}


@end
