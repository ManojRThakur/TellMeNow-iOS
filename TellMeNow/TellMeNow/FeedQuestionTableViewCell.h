//
//  FeedQuestionTableViewCell.h
//  TellMeNow
//
//  Created by Raghav on 4/12/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"

@interface FeedQuestionTableViewCell : UITableViewCell

@property (strong, nonatomic) Question *question;
@end