//
//  TellMeNowAPI.m
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 5/4/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "TellMeNowAPI.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation TellMeNowAPI

+ (TellMeNowAPI *)sharedAPI
{
    static TellMeNowAPI *sharedAPI = nil;
    if (sharedAPI == nil) {
        sharedAPI = [[TellMeNowAPI alloc] init];
    }
    return sharedAPI;
}

- (void)socketIO:(SocketIO *)socket onError:(NSError *)error
{
    NSLog(@"Error: %@", error);
    self.connErrorAlertView = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"A connection could not be established with the server." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Try Again", nil];
    [self.connErrorAlertView show];
}

- (void)socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error
{
    NSLog(@"Disconnected: %@", error);
    self.connErrorAlertView = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"The connection has been disconnected." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Try Again", nil];
    [self.connErrorAlertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.connErrorAlertView && buttonIndex == 0)
        [self.socket connectToHost:@"131.179.210.165" onPort:3001];
}

- (NSString *)loginWithAccessToken:(NSString *)accessToken
{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    NSMutableString *ret = [NSMutableString string];
    [self.socket sendEvent:@"/login" withData:[NSDictionary dictionaryWithObjectsAndKeys:[[[FBSession activeSession] accessTokenData] accessToken], @"token", nil] andAcknowledge:^(NSDictionary *arg) {
        if ([arg objectForKey:@"error"] != [NSNull null]) {
            NSLog(@"%@", arg);
        } else {
            [ret appendString:[[arg objectForKey:@"response"] objectForKey:@"_id"]];
        }
        dispatch_semaphore_signal(sema);
    }];
    while (dispatch_semaphore_wait(sema, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    }
    if ([ret isEqualToString:@""]) {
        return nil;
    } else {
        return ret;
    }
}

- (NSArray *)usersForIds:(NSArray *)userIds
{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    NSMutableArray *ret = [NSMutableArray array];
    [self.socket sendEvent:@"/users/get" withData:userIds andAcknowledge:^(NSDictionary *arg) {
        if ([arg objectForKey:@"error"] != [NSNull null]) {
            NSLog(@"%@", arg);
        } else {
            [ret addObjectsFromArray:[arg objectForKey:@"response"]];
        }
    }];
    while (dispatch_semaphore_wait(sema, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    }
    if ([ret count] == 0) {
        return nil;
    } else {
        return ret;
    }
}

- (NSArray *)questionsForIds:(NSArray *)questionIds
{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    NSMutableArray *ret = [NSMutableArray array];
    [self.socket sendEvent:@"/questions/get" withData:questionIds andAcknowledge:^(NSDictionary *arg) {
        if ([arg objectForKey:@"error"] != [NSNull null]) {
            NSLog(@"%@", arg);
        } else {
            [ret addObjectsFromArray:[arg objectForKey:@"response"]];
        }
    }];
    while (dispatch_semaphore_wait(sema, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    }
    if ([ret count] == 0) {
        return nil;
    } else {
        return ret;
    }
}

- (NSArray *)answersForIds:(NSArray *)answerIds
{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    NSMutableArray *ret = [NSMutableArray array];
    [self.socket sendEvent:@"/answers/get" withData:answerIds andAcknowledge:^(NSDictionary *arg) {
        if ([arg objectForKey:@"error"] != [NSNull null]) {
            NSLog(@"%@", arg);
        } else {
            [ret addObjectsFromArray:[arg objectForKey:@"response"]];
        }
    }];
    while (dispatch_semaphore_wait(sema, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    }
    if ([ret count] == 0) {
        return nil;
    } else {
        return ret;
    }
}

- (NSArray *)questionsNearby:(CLLocation *)location
{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    NSMutableArray *ret = [NSMutableArray array];
    [self.socket sendEvent:@"/questions/nearby" withData:[NSDictionary dictionaryWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:location.coordinate.latitude], @"lat", [NSNumber numberWithDouble:location.coordinate.longitude], @"lng", nil], @"geoLocation", nil] andAcknowledge:^(NSDictionary *arg) {
        if ([arg objectForKey:@"error"] != [NSNull null]) {
            NSLog(@"%@", arg);
        } else {
            [ret addObjectsFromArray:[arg objectForKey:@"response"]];
        }
    }];
    while (dispatch_semaphore_wait(sema, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    }
    if ([ret count] == 0) {
        return nil;
    } else {
        return ret;
    }
}

@end
