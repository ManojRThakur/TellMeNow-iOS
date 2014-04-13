//
//  askQuestionViewController.h
//  TellMeNow
//
//  Created by Raghav on 4/4/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Place.h"

@interface SelectLocationAQViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) NSMutableArray *suggestedPlaces;
@property (strong, nonatomic) NSMutableArray *searchPlaceResults;
@property (strong, nonatomic) Place *selectedPlace;
@property (weak, nonatomic) IBOutlet UITableView *suggestedPlacesTableView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end
