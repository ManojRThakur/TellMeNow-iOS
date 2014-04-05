//
//  Answer.h
//  TellMeNow
//
//  Created by Raghav on 4/5/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Answer : NSObject
@property (strong, nonatomic) NSString *answerText;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *timestamp;

-(void) answerTextValue:(NSString *)answer usernameValue:(NSString *)user timeValue:(NSString *)time;

@end
