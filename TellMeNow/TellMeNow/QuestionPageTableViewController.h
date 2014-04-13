//
//  QuestionPageTableViewController.h
//  TellMeNow
//
//  Created by Raghav on 4/12/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"

@interface QuestionPageTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *questionTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionUsername;
@property (weak, nonatomic) IBOutlet UILabel *questionDate;

@end
