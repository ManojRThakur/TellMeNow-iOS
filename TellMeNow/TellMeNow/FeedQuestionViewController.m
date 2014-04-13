//
//  FeedQuestionViewController.m
//  TellMeNow
//
//  Created by Raghav on 4/12/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "FeedQuestionViewController.h"
#import "FeedQuestionTableViewCell.h"
#import "SocketIO.h"
#import "tellmenowAppDelegate.h"
#import "Place.h"

@implementation FeedQuestionViewController
{
    bool userLoaded;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.suggestedQuestions = [[NSMutableArray alloc] initWithCapacity:10];
    self.searchedPlaces = [[NSMutableArray alloc] initWithCapacity:10];
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    userLoaded = false;
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([self.searchDisplayController.searchResultsTableView indexPathForSelectedRow])
        [self.searchDisplayController.searchResultsTableView deselectRowAtIndexPath:[self.searchDisplayController.searchResultsTableView indexPathForSelectedRow] animated:animated];
    //if ([self.suggestedQuestionsTableView indexPathForSelectedRow])
    //    [self.suggestedQuestionsTableView deselectRowAtIndexPath:[self.suggestedPlacesTableView indexPathForSelectedRow] animated:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (userLoaded)
        [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchedPlaces count];
        
    } else {
        return [self.suggestedQuestions count];
    }
}


- (FeedQuestionTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"feedQuestionCell";
    
    FeedQuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[FeedQuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSString *display = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        display = [self.searchedPlaces objectAtIndex:indexPath.row];
    } else {
        display = [self.suggestedQuestions objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = display;
    return cell;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to get your location." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    SocketIO *socket = [(tellmenowAppDelegate *)[[UIApplication sharedApplication] delegate] socket];
    NSMutableDictionary *questionsMap = [(tellmenowAppDelegate *)[[UIApplication sharedApplication] delegate] questionMap];
    NSMutableDictionary *placesMap = [(tellmenowAppDelegate *)[[UIApplication sharedApplication] delegate] placeMap];
    [socket sendEvent:@"/questions/nearby" withData:[NSDictionary dictionaryWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:newLocation.coordinate.latitude], @"lat", [NSNumber numberWithDouble:newLocation.coordinate.longitude], @"lng", nil], @"geoLocation", nil] andAcknowledge:^(id arg) {
        [self.locationManager stopUpdatingLocation];
        NSArray *questions = [arg objectForKey:@"response"];
        [self.suggestedQuestions removeAllObjects];
        for (NSDictionary *dict in questions) {
            Question *question = [Question questionFromDict:dict];
            [questionsMap setObject:question forKey:question._id];
            [self.suggestedQuestions addObject:question];
        }
        [socket sendEvent:@"/places/get" withData:[self.suggestedQuestions valueForKey:@"placeId"] andAcknowledge:^(id argsData) {
            NSArray *places = [argsData objectForKey:@"response"];
            for (NSDictionary *dict in places) {
                Place *place = [Place placeFromDict:dict];
                [placesMap setObject:place forKey:place._id];
            }
            //[self.suggestedQuestionsTableView reloadData];
        }];
    }];
}

- (void)userDidLoad
{
    userLoaded = true;
    [self.locationManager startUpdatingLocation];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
