//
//  Comment.m
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 4/12/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "Comment.h"

@implementation Comment

+ (Comment *)commentFromDict: (NSDictionary *)args
{
    Comment *obj = [Comment alloc];
    [obj set_id:[args objectForKey:@"_id"]];
    [obj setText:[args objectForKey:@"text"]];
    [obj setTimestamp:[args objectForKey:@"timestamp"]];
    [obj setUserId:[args objectForKey:@"userId"]];
    [obj setQuestionId:[args objectForKey:@"questionId"]];
    return obj;
}

@end
