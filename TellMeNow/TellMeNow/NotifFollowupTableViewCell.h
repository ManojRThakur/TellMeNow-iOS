//
//  NotifFollowupTableViewCell.h
//  TellMeNow
//
//  Created by Raghav on 4/12/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotifFollowupTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *followupAnswer;
@property (weak, nonatomic) IBOutlet UILabel *followupTime;
@property (weak, nonatomic) IBOutlet UILabel *followupLabel;

@end
