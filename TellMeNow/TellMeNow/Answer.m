//
//  Answer.m
//  TellMeNow
//
//  Created by Raghav on 4/5/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "Answer.h"

@implementation Answer

+ (Answer *)answerFromDict: (NSDictionary *)args
{
    Answer *answer = [Answer alloc];
    [answer set_id:[args objectForKey:@"_id"]];
    [answer setText:[args objectForKey:@"text"]];
    [answer setTimestamp:[args objectForKey:@"timestamp"]];
    [answer setFollowUpIds:[NSMutableArray arrayWithArray:[args objectForKey:@"followups"]]];
    [answer setUserId:[args objectForKey:@"user"]];
    [answer setQuestionId:[args objectForKey:@"question"]];
    return answer;
}

@end
