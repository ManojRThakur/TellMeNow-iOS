//
//  NotifCommentTableViewCell.h
//  TellMeNow
//
//  Created by Raghav on 4/12/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotifCommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *commentQuestion;
@property (weak, nonatomic) IBOutlet UILabel *commentTime;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@end
