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
#import "Comment.h"
#import "QuestionPageTableViewController.h"
#import "QuestionsInLocationTableViewController.h"

@implementation FeedQuestionViewController
{
    bool userLoaded;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    userLoaded = false;
    // Do any additional setup after loading the view.
    self.suggestedQuestions = [[NSMutableArray alloc] initWithCapacity:10];
    self.searchedPlaces = [[NSMutableArray alloc] initWithCapacity:10];
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([self.searchDisplayController.searchResultsTableView indexPathForSelectedRow])
        [self.searchDisplayController.searchResultsTableView deselectRowAtIndexPath:[self.searchDisplayController.searchResultsTableView indexPathForSelectedRow] animated:animated];
    if ([self.suggestedQuestionsTableView indexPathForSelectedRow])
        [self.suggestedQuestionsTableView deselectRowAtIndexPath:[self.suggestedQuestionsTableView indexPathForSelectedRow] animated:animated];
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

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    SocketIO *socket = [(tellmenowAppDelegate *)[[UIApplication sharedApplication] delegate] socket];
    NSMutableDictionary *placeMap = [(tellmenowAppDelegate *)[[UIApplication sharedApplication] delegate] placeMap];
    [socket sendEvent:@"/location/query" withData:[NSDictionary dictionaryWithObjectsAndKeys:searchString, @"query", nil] andAcknowledge:^(id arg) {
        [self.locationManager stopUpdatingLocation];
        NSArray *locations = [arg objectForKey:@"response"];
        [socket sendEvent:@"/places/get" withData:locations andAcknowledge:^(id argsData) {
            NSArray *locations = [argsData objectForKey:@"response"];
            [self.searchedPlaces removeAllObjects];
            for (NSDictionary *dict in locations) {
                Place *place = [Place placeFromDict:dict];
                [placeMap setObject:place forKey:place._id];
                [self.searchedPlaces addObject:place];
            }
            [self.searchDisplayController.searchResultsTableView reloadData];
        }];
    }];
    
    return NO;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchedPlaces count];
        
    } else {
        return [self.suggestedQuestions count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        static NSString *simpleTableIdentifier = @"searchRowCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        return cell;
    } else {
        static NSString *simpleTableIdentifier = @"feedQuestionCell";
        FeedQuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil) {
            cell = [[FeedQuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        Question *display = [self.suggestedQuestions objectAtIndex:indexPath.row];
        cell.questionText.text = display.text;
        cell.questionDate.text = display.timestamp;
        cell.questionLocation.text = [[display getPlace] name];
        return cell;
    }
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
        NSArray *questionIds = [arg objectForKey:@"response"];
        [socket sendEvent:@"/questions/get" withData:questionIds andAcknowledge:^(id argsData) {
            NSArray *questions = [argsData objectForKey:@"response"];
            [self.suggestedQuestions removeAllObjects];
            for (NSDictionary *dict in questions) {
                Question *question = [Question questionFromDict:dict];
                [questionsMap setObject:question forKey:question._id];
                [self.suggestedQuestions addObject:question];
            }
            [socket sendEvent:@"/location/get" withData:[self.suggestedQuestions valueForKey:@"placeId"] andAcknowledge:^(id argsData) {
                NSArray *places = [argsData objectForKey:@"response"];
                for (NSDictionary *dict in places) {
                    Place *place = [Place placeFromDict:dict];
                    [placesMap setObject:place forKey:place._id];
                }
                [self.suggestedQuestionsTableView reloadData];
            }];
        }];
    }];
}

- (void)userDidLoad
{
    if (!userLoaded) {
        userLoaded = true;
        [self.locationManager startUpdatingLocation];
    }
}

#pragma mark - Navigation
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        [self setSelectedPlace:[self.searchedPlaces objectAtIndex:indexPath.row]];
        [self performSegueWithIdentifier:@"FeedToSearch" sender:self];
    } else {
        [self setSelectedQuestion:[self.suggestedQuestions objectAtIndex:indexPath.row]];
        [self performSegueWithIdentifier:@"FeedToQuestion" sender:self];
    }
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SocketIO *socket = [(tellmenowAppDelegate *)[[UIApplication sharedApplication] delegate] socket];
    if ([segue.identifier isEqual: @"FeedToQuestion"]) {
        QuestionPageTableViewController *destinationVC = segue.destinationViewController;
        [destinationVC setQuestion:self.selectedQuestion];
        [self.selectedQuestion getCommentsWithCallback:^void *(NSArray *_) {
            [self.selectedQuestion getAnswersWithCallback:^void *(NSArray *_) {
                [self.selectedQuestion getUserWithCallback:^void *(User *_) {
                    NSMutableArray *commentUserIds = [NSMutableArray array];
                    for (Comment *comment in [self.selectedQuestion getComments])
                        [commentUserIds addObject:comment.userId];
                    [socket sendEvent:@"/users/get" withData:commentUserIds andAcknowledge:^(id argsData) {
                        [destinationVC questionDidLoad];
                    }];
                    return nil;
                }];
                return nil;
            }];
            return nil;
        }];
        
    } else if ([segue.identifier isEqual:@"FeedToSearch"]) {
        QuestionsInLocationTableViewController *destinationVC = segue.destinationViewController;
        //[destinationVC]
    }
}

@end
