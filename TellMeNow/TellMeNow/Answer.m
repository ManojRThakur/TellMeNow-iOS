//
//  Answer.m
//  TellMeNow
//
//  Created by Raghav on 4/5/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "Answer.h"

@interface Answer()

@end

@implementation Answer

-(void) answerTextValue:(NSString *)answer usernameValue:(NSString *)user timeValue:(NSString *)time
{
    self.answerText = answer;
    self.username = user;
    self.timestamp = time;
}


@end
