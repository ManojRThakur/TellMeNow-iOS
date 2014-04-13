//
//  NotifQuestionsTableViewCell.h
//  TellMeNow
//
//  Created by Raghav on 4/12/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotifQuestionsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionLocation;
@property (weak, nonatomic) IBOutlet UILabel *questionTime;

@end
