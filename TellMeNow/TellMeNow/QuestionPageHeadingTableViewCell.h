//
//  QuestionPageHeadingTableViewCell.h
//  TellMeNow
//
//  Created by Raghav on 4/12/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionPageHeadingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *questionTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionDate;
@property (weak, nonatomic) IBOutlet UILabel *questionUsername;

@end
