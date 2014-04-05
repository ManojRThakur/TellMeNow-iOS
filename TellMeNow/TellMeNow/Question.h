//
//  Question.h
//  TellMeNow
//
//  Created by Raghav on 4/5/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject
@property (strong, nonatomic) NSString *questionText;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *timestamp;
@property (strong, nonatomic) NSString *place;

-(void) questionTextValue:(NSString *)question usernameValue:(NSString *)user timeValue:(NSString *)time placeValue:(NSString *)place;

@end
