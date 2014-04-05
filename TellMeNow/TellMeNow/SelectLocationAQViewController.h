//
//  askQuestionViewController.h
//  TellMeNow
//
//  Created by Raghav on 4/4/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectLocationAQViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *suggestedPlaces;
@property (strong, nonatomic) NSMutableArray *searchPlaceResults;
@property (strong, nonatomic) NSString *selectedLocation;

@end
