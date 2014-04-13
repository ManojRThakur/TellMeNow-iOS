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
@property (weak, nonatomic) IBOutlet UILabel *questionDate;
@property (weak, nonatomic) IBOutlet UILabel *questionLocation;

@property (weak, nonatomic) IBOutlet UILabel *questionText;
@end
