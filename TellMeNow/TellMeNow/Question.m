//
//  Question.m
//  TellMeNow
//
//  Created by Raghav on 4/5/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "Question.h"
#import "tellmenowAppDelegate.h"
#import "Comment.h"
#import "SocketIO.h"

@implementation Question

- (void)getCommentsWithCallback: (void *(^)(NSArray *))callback
{
    NSMutableArray *retIds = [NSMutableArray arrayWithArray:self.commentIds];
    NSMutableDictionary *commentMap = [(tellmenowAppDelegate *)[[UIApplication sharedApplication] delegate] commentMap];
    SocketIO *socket = [(tellmenowAppDelegate *)[[UIApplication sharedApplication] delegate] socket];
    
    for (NSString *commentId in [[commentMap allValues] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(Comment *evaluatedObject, NSDictionary *bindings) {
        return [evaluatedObject.questionId isEqualToString:self._id];
    }]])
        if (![retIds containsObject:commentId])
            [retIds addObject:commentId];
    NSArray *fetchIds = [retIds filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSString *evaluatedObject, NSDictionary *bindings) {
        return ![[commentMap allKeys] containsObject:evaluatedObject];
    }]];
    
    NSArray *(^getRet)(void) = ^NSArray *(void) {
        NSMutableArray *ret = [NSMutableArray array];
        for (NSString *commentId in retIds)
            [ret addObject:[commentMap objectForKey:commentId]];
        return ret;
    };
    
    if ([fetchIds count] == 0) {
        callback(getRet());
    } else {
        [socket sendEvent:@"/comments/get" withData:fetchIds andAcknowledge:^(NSDictionary *argsData) {
            for (NSDictionary *commentDict in [argsData objectForKey:@"response"]) {
                Comment *obj = [Comment alloc];
                [obj set_id:[commentDict objectForKey:@"_id"]];
                [obj setText:[commentDict objectForKey:@"text"]];
                [obj setTimestamp:[commentDict objectForKey:@"timestamp"]];
                [obj setUserId:[commentDict objectForKey:@"userId"]];
                [obj setQuestionId:[commentDict objectForKey:@"questionId"]];
                [commentMap setObject:obj forKey:obj._id];
            }
            callback(getRet());
        }];
    }
}

@end
