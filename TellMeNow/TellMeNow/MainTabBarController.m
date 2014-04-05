//
//  mainTabBarController.m
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 4/4/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "MainTabBarController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "LoginViewController.h"
#import "SocketIO.h"
#import "tellmenowAppDelegate.h"

@implementation MainTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    if (![[FBSession activeSession] accessTokenData]) {
        [self performSegueWithIdentifier:@"showLoginViewSegue" sender:self];
    } else {
        SocketIO *socket = [(tellmenowAppDelegate *)[[UIApplication sharedApplication] delegate] socket];
        [socket sendEvent:@"/user/login" withData:[NSDictionary dictionaryWithObjectsAndKeys:[[[FBSession activeSession] accessTokenData] accessToken], @"token", nil] andAcknowledge:^(id arg) {
            if ([arg objectForKey:@"error"])
                NSLog(@"%@", arg);
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
