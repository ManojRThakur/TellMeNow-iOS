//
//  QuestionAnswerViewController.h
//  TellMeNow
//
//  Created by Raghav on 4/5/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"

@interface QuestionAnswerViewController : UITableViewController
@property (strong, nonatomic) Question *question;
@end
