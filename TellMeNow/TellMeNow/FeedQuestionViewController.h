//
//  FeedQuestionViewController.h
//  TellMeNow
//
//  Created by Raghav on 4/12/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import <CoreLocation/CoreLocation.h>

@interface FeedQuestionViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>

@property (strong, nonatomic) NSMutableArray *suggestedQuestions;
@property (strong, nonatomic) NSMutableArray *searchedQuestions;
@property (strong, nonatomic) Question *selectedQuestion;
@property (weak, nonatomic) IBOutlet UITableView *suggestedQuestionsTableView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@end
å