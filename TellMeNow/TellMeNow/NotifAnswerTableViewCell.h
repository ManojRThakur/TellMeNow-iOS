//
//  NotifAnswerTableViewCell.h
//  TellMeNow
//
//  Created by Raghav on 4/12/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotifAnswerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerQuestion;
@property (weak, nonatomic) IBOutlet UILabel *answerTime;

@end
