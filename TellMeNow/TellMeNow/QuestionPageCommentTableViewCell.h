//
//  QuestionPageCommentTableViewCell.h
//  TellMeNow
//
//  Created by Raghav on 4/12/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionPageCommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *commentUsername;
@property (weak, nonatomic) IBOutlet UILabel *commentText;

@end
