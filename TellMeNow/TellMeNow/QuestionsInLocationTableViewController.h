//
//  QuestionsInLocationTableViewController.h
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 4/13/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Place;

@interface QuestionsInLocationTableViewController : UITableViewController

@property (strong, nonatomic) Place *place;

@end