//
//  tellmenowViewController.m
//  TellMeNow
//
//  Created by Raghav on 4/4/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.loginView setReadPermissions:@[@"basic_info", @"user_checkins"]];
    [self.loginView setDelegate:self];
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    [self dismissViewControllerAnimated:true completion:^(){}];
    
}

@end