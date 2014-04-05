//
//  Notification.m
//  TellMeNow
//
//  Created by Raghav on 4/5/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "Notification.h"
@interface Notification()
@property (strong, nonatomic) NSString *questionText;
@property (strong, nonatomic) NSString *timestamp;
@property (strong, nonatomic) NSString *answerer;
@property (strong, nonatomic) NSString *location;
@end

@implementation Notification

- (void) timeStampValue:(NSString *)time questionTextValue:(NSString *)question answererValue:(NSString *)user
{
    self.timestamp = time;
    self.questionText = question;
    self.answerer = user;
}

- (void) timeStampValue:(NSString *)time questionTextValue:(NSString *)question locationValue:(NSString *)place
{
    self.timestamp = time;
    self.questionText = question;
    self.location = place;
}

- (NSString *) getAnswerNotification {
    NSString *output;
    [output stringByAppendingString:self.answerer];
    [output stringByAppendingString:@" answered the question "];
    [output stringByAppendingString:self.questionText];
    [output stringByAppendingString:self.timestamp];
    return output;
}

- (NSString *) getLocationNotification {
    NSString *output;
    [output stringByAppendingString:self.questionText];
    [output stringByAppendingString:@" was asked for "];
    [output stringByAppendingString:self.location];
    [output stringByAppendingString:self.timestamp];
    return output;
}
@end
