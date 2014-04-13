//
//  QuestionPageTableViewController.h
//  TellMeNow
//
//  Created by Raghav on 4/12/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "Answer.h"

@interface QuestionPageTableViewController : UITableViewController

@property (strong, nonatomic) Question *question;
@property (strong, nonatomic) NSArray *comments;
@property (strong, nonatomic) NSArray *answers;
@property (strong, nonatomic) Answer *selectedAnswer;
@end
