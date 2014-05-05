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

- (void)loginWithAccessToken:(NSString *)accessToken andCallback:(void *(^)(NSString *))callback
{
    [self.socket sendEvent:@"/login" withData:[NSDictionary dictionaryWithObjectsAndKeys:[[[FBSession activeSession] accessTokenData] accessToken], @"token", nil] andAcknowledge:^(NSDictionary *arg) {
        if ([arg objectForKey:@"error"] != [NSNull null]) {
            callback(nil);
            NSLog(@"%@", arg);
        } else {
            callback([[arg objectForKey:@"response"] objectForKey:@"_id"]);
        }
    }];
}

- (void)usersForIds:(NSArray *)userIds andCallback:(void *(^)(NSArray *))callback
{
    [self.socket sendEvent:@"/users/get" withData:userIds andAcknowledge:^(NSDictionary *arg) {
        if ([arg objectForKey:@"error"] != [NSNull null]) {
            callback(nil);
            NSLog(@"%@", arg);
        } else {
            callback([arg objectForKey:@"response"]);
        }
    }];
}

- (void)questionsForIds:(NSArray *)questionIds andCallback:(void *(^)(NSArray *))callback
{
    [self.socket sendEvent:@"/questions/get" withData:questionIds andAcknowledge:^(NSDictionary *arg) {
        if ([arg objectForKey:@"error"] != [NSNull null]) {
            callback(nil);
            NSLog(@"%@", arg);
        } else {
            callback([arg objectForKey:@"response"]);
        }
    }];
}

- (void)answersForIds:(NSArray *)answerIds andCallback:(void *(^)(NSArray *))callback
{
    [self.socket sendEvent:@"/answers/get" withData:answerIds andAcknowledge:^(NSDictionary *arg) {
        if ([arg objectForKey:@"error"] != [NSNull null]) {
            callback(nil);
            NSLog(@"%@", arg);
        } else {
            callback([arg objectForKey:@"response"]);
        }
    }];
}

- (void)questionsNearby:(CLLocation *)location andCallback:(void *(^)(NSArray *))callback
{
    [self.socket sendEvent:@"/questions/nearby" withData:[NSDictionary dictionaryWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:location.coordinate.latitude], @"lat", [NSNumber numberWithDouble:location.coordinate.longitude], @"lng", nil], @"geoLocation", nil] andAcknowledge:^(NSDictionary *arg) {
        if ([arg objectForKey:@"error"] != [NSNull null]) {
            callback(nil);
            NSLog(@"%@", arg);
        } else {
            callback([arg objectForKey:@"response"]);
        }
    }];
}

@end
