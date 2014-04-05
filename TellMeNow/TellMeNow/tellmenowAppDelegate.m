//
//  tellmenowAppDelegate.m
//  TellMeNow
//
//  Created by Raghav on 4/4/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "tellmenowAppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation tellmenowAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [FBLoginView class];
    // Override point for customization after application launch.
    self.socket = [[SocketIO alloc] initWithDelegate:self];
    [self.socket connectToHost:@"tellmenow.herokuapp.com" onPort:80];
    
    return YES;
}

- (void)socketIO:(SocketIO *)socket onError:(NSError *)error
{
    NSLog(@"%@", error);
    self.connErrorAlertView = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"A connection could not be established with the server." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Try Again", nil];
    [self.connErrorAlertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //if (alertView == self.connErrorAlertView && buttonIndex == 0)
        //[self.socket connectToHost:@"tellmenow.herokuapp.com" onPort:80];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
