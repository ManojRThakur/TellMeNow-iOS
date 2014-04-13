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
#import "Place.h"
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
                Comment *obj = [Comment commentFromDict:commentDict];
                [commentMap setObject:obj forKey:obj._id];
            }
            callback(getRet());
        }];
    }
}

- (void)getPlaceWithCallback: (void *(^)(Place *))callback
{
    SocketIO *socket = [(tellmenowAppDelegate *)[[UIApplication sharedApplication] delegate] socket];
    NSMutableDictionary *placeMap = [(tellmenowAppDelegate *)[[UIApplication sharedApplication] delegate] placeMap];
    
    if ([placeMap objectForKey:self.placeId]) {
        callback([placeMap objectForKey:self.placeId]);
    } else {
        [socket sendEvent:@"/location/get" withData:@[self.placeId] andAcknowledge:^(NSDictionary *argsData) {
            Place *obj = [Place placeFromDict:[argsData objectForKey:@"response"][0]];
            [placeMap setObject:obj forKey:obj._id];
        }];
    }
}

- (Place *)getPlace
{
    NSMutableDictionary *placeMap = [(tellmenowAppDelegate *)[[UIApplication sharedApplication] delegate] placeMap];
    
    if ([placeMap objectForKey:self.placeId]) {
        return [placeMap objectForKey:self.placeId];
    } else {
        return nil;
    }
}


+ (Question *)questionFromDict: (NSDictionary *)args
{
    Question *question = [Question alloc];
    [question set_id:[args objectForKey:@"_id"]];
    [question setText:[args objectForKey:@"text"]];
    [question setTimestamp:[args objectForKey:@"timestamp"]];
    [question setPlaceId:[args objectForKey:@"place"]];
    [question setCommentIds:[NSMutableArray arrayWithArray:[args objectForKey:@"comments"]]];
    [question setUserId:[args objectForKey:@"user"]];
    [question setAnswerIds:[NSMutableArray arrayWithArray:[args objectForKey:@"answers"]]];
    return question;
}

@end
