//
//  PlaceModel.h
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 4/5/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Place : NSObject

@property (strong, nonatomic) NSString *_id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableArray *questionIds;

- (NSArray *)getQuestions;

@end
