//
//  Notification.h
//  TellMeNow
//
//  Created by Raghav on 4/5/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notification : NSObject
-(NSString *) getAnswerNotification;

-(NSString *) getLocationNotification;

- (void) timeStampValue:(NSString *)time questionTextValue:(NSString *)question answererValue:(NSString *)user;

- (void) timeStampValue:(NSString *)time questionTextValue:(NSString *)question locationValue:(NSString *)place;
@end
