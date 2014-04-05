//
//  AddQuestionAQTableViewController.h
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 4/5/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddQuestionAQTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITableViewCell *locationTableViewCell;
@property (strong, nonatomic) NSString *location;
@end
