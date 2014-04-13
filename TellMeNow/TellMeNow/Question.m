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
#import "Answer.h"
#import "User.h"
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

- (void)getAnswersWithCallback: (void *(^)(NSArray *))callback
{
    NSMutableArray *retIds = [NSMutableArray arrayWithArray:self.answerIds];
    NSMutableDictionary *answerMap = [(tellmenowAppDelegate *)[[UIApplication sharedApplication] delegate] answerMap];
    SocketIO *socket = [(tellmenowAppDelegate *)[[UIApplication sharedApplication] delegate] socket];
    
    for (NSString *answerId in [[answerMap allValues] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(Answer *evaluatedObject, NSDictionary *bindings) {
        return [evaluatedObject.questionId isEqualToString:self._id];
    }]])
        if (![retIds containsObject:answerId])
            [retIds addObject:answerId];
    NSArray *fetchIds = [retIds filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSString *evaluatedObject, NSDictionary *bindings) {
        return ![[answerMap allKeys] containsObject:evaluatedObject];
    }]];
    
    NSArray *(^getRet)(void) = ^NSArray *(void) {
        NSMutableArray *ret = [NSMutableArray array];
        for (NSString *answerId in retIds)
            [ret addObject:[answerMap objectForKey:answerId]];
        return ret;
    };
    
    if ([fetchIds count] == 0) {
        callback(getRet());
    } else {
        [socket sendEvent:@"/answers/get" withData:fetchIds andAcknowledge:^(NSDictionary *argsData) {
            for (NSDictionary *answerDict in [argsData objectForKey:@"response"]) {
                Answer *obj = [Answer answerFromDict:answerDict];
                [answerMap setObject:obj forKey:obj._id];
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
            callback(obj);
        }];
    }
}

- (void)getUserWithCallback: (void *(^)(User *))callback
{
    SocketIO *socket = [(tellmenowAppDelegate *)[[UIApplication sharedApplication] delegate] socket];
    NSMutableDictionary *userMap = [(tellmenowAppDelegate *)[[UIApplication sharedApplication] delegate] userMap];
    
    if ([userMap objectForKey:self.userId]) {
        callback([userMap objectForKey:self.userId]);
    } else {
        [socket sendEvent:@"/users/get" withData:@[self.userId] andAcknowledge:^(NSDictionary *argsData) {
            User *obj = [User userFromDict:[argsData objectForKey:@"response"][0]];
            [userMap setObject:obj forKey:obj._id];
            callback(obj);
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

- (User *)getUser
{
    NSMutableDictionary *userMap = [(tellmenowAppDelegate *)[[UIApplication sharedApplication] delegate] userMap];
    
    if ([userMap objectForKey:self.userId]) {
        return [userMap objectForKey:self.userId];
    } else {
        return nil;
    }
}

- (NSArray *)getComments
{
    NSMutableDictionary *commentMap = [(tellmenowAppDelegate *)[[UIApplication sharedApplication] delegate] commentMap];
    
    NSMutableArray *ret = [NSMutableArray array];
    for (NSString *commentId in self.commentIds)
        if ([commentMap objectForKey:commentId])
            [ret addObject:[commentMap objectForKey:commentId]];
    return ret;
}

- (NSArray *)getAnswers
{
    NSMutableDictionary *answerMap = [(tellmenowAppDelegate *)[[UIApplication sharedApplication] delegate] answerMap];
    
    NSMutableArray *ret = [NSMutableArray array];
    for (NSString *ans in self.answerIds)
        if ([answerMap objectForKey:ans])
            [ret addObject:[answerMap objectForKey:ans]];
    return ret;
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
