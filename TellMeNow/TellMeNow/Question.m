//
//  Question.m
//  TellMeNow
//
//  Created by Raghav on 4/5/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "Question.h"

@implementation Question

-(void) questionTextValue:(NSString *)question usernameValue:(NSString *)user timeValue:(NSString *)time placeValue:(NSString *)place
{
    self.questionText = question;
    self.username = user;
    self.timestamp = time;
    self.place = place;
}

@end
