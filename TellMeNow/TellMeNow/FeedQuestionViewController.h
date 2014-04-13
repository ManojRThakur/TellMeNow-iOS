//
//  FeedQuestionViewController.h
//  TellMeNow
//
//  Created by Raghav on 4/12/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class Question, Place;

@interface FeedQuestionViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>

@property (strong, nonatomic) NSMutableArray *suggestedQuestions;
@property (strong, nonatomic) NSMutableArray *searchedPlaces;
@property (strong, nonatomic) Question *selectedQuestion;
@property (strong, nonatomic) Place *selectedPlace;
@property (strong, nonatomic) CLLocationManager *locationManager;

- (void)userDidLoad;

@end
