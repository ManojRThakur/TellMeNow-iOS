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
#import "User.h"

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
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self.view addSubview:activityIndicator];
        SocketIO *socket = [(tellmenowAppDelegate *)[[UIApplication sharedApplication] delegate] socket];
        [socket sendEvent:@"/login" withData:[NSDictionary dictionaryWithObjectsAndKeys:[[[FBSession activeSession] accessTokenData] accessToken], @"token", nil] andAcknowledge:^(NSDictionary *arg) {
            if ([arg objectForKey:@"error"] != [NSNull null]) {
                //[activityIndicator removeFromSuperview];
                NSLog(@"%@", arg);
            } else {
                [socket sendEvent:@"/users/get" withData:@[[[arg objectForKey:@"response"] objectForKey:@"_id"]] andAcknowledge:^(NSDictionary *arg) {
                    //[activityIndicator removeFromSuperview];
                    if ([arg objectForKey:@"error"] != [NSNull null]) {
                        NSLog(@"%@", arg);
                    } else {
                        User *me = [User userFromDict:[arg objectForKey:@"response"][0]];
                        [(tellmenowAppDelegate *)[[UIApplication sharedApplication] delegate] setMe:me];
                        [[(tellmenowAppDelegate *)[[UIApplication sharedApplication] delegate] userMap] setObject:me forKey:me._id];
                    }
                }];
            }
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
