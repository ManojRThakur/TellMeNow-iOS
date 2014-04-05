//
//  askQuestionViewController.m
//  TellMeNow
//
//  Created by Raghav on 4/4/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "SelectLocationAQViewController.h"
#import "AddQuestionAQTableViewController.h"
#import "SocketIO.h"
#import "tellmenowAppDelegate.h"
#import "PlaceModel.h"

@interface SelectLocationAQViewController ()

@end

@implementation SelectLocationAQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.suggestedPlaces = [[NSMutableArray alloc] initWithCapacity:10];
    self.searchPlaceResults = [[NSMutableArray alloc] initWithCapacity:10];
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationManager startUpdatingLocation];
    
    //[self.suggestedPlaces addObjectsFromArray:@[@"Facebook", @"Yahoo", @"Google", @"Microsoft", @"Ebay", @"Amazon", @"Dropbox", @"Uber", @"Heroku", @"Twitter", @"Apple", @"Box", @"Youtube", @"Snapchat", @"Cisco", @"LinkedIn", @"Hulu", @"Netflix"]];
    //[self.searchPlaceResults addObjectsFromArray:@[@"Facebook", @"Yahoo", @"Google", @"Microsoft", @"Ebay", @"Amazon", @"Dropbox", @"Uber", @"Heroku", @"Twitter", @"Apple", @"Box", @"Youtube", @"Snapchat", @"Cisco", @"LinkedIn", @"Hulu", @"Netflix"]];
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([self.searchDisplayController.searchResultsTableView indexPathForSelectedRow])
        [self.searchDisplayController.searchResultsTableView deselectRowAtIndexPath:[self.searchDisplayController.searchResultsTableView indexPathForSelectedRow] animated:animated];
    if ([self.suggestedPlacesTableView indexPathForSelectedRow])
        [self.suggestedPlacesTableView deselectRowAtIndexPath:[self.suggestedPlacesTableView indexPathForSelectedRow] animated:animated];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    SocketIO *socket = [(tellmenowAppDelegate *)[[UIApplication sharedApplication] delegate] socket];
    [socket sendEvent:@"/location/query" withData:[NSDictionary dictionaryWithObjectsAndKeys:searchString, @"query", nil] andAcknowledge:^(id arg) {
        [self.locationManager stopUpdatingLocation];
        NSArray *locations = [arg objectForKey:@"response"];
        [self.searchPlaceResults removeAllObjects];
        for (int i = 0; i < locations.count; i++) {
            PlaceModel *place = [[PlaceModel alloc] init];
            [place setName:[locations[i] objectForKey:@"name"]];
            [place set_id:[locations[i] objectForKey:@"_id"]];
            [self.searchPlaceResults addObject:place];
        }
        NSLog(@"%@", self.searchPlaceResults);
        [self.searchDisplayController.searchResultsTableView reloadData];
    }];

    return NO;
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
    [socket sendEvent:@"/location/find" withData:[NSDictionary dictionaryWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:newLocation.coordinate.latitude], @"lat", [NSNumber numberWithDouble:newLocation.coordinate.longitude], @"lng", nil], @"geoLocation", nil] andAcknowledge:^(id arg) {
        [self.locationManager stopUpdatingLocation];
        NSArray *locations = [arg objectForKey:@"response"];
        [self.suggestedPlaces removeAllObjects];
        for (int i = 0; i < locations.count; i++) {
            PlaceModel *place = [[PlaceModel alloc] init];
            [place setName:[locations[i] objectForKey:@"name"]];
            [place set_id:[locations[i] objectForKey:@"_id"]];
            [self.suggestedPlaces addObject:place];
        }
        NSLog(@"%@", self.suggestedPlaces);
        [self.suggestedPlacesTableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchPlaceResults count];
        
    } else {
        return [self.suggestedPlaces count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSString *display = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        display = [[self.searchPlaceResults objectAtIndex:indexPath.row] name];
    } else {
        display = [[self.suggestedPlaces objectAtIndex:indexPath.row] name];
    }
    
    cell.textLabel.text = display;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
        [self setSelectedPlace:[self.searchPlaceResults objectAtIndex:indexPath.row]];
    else
        [self setSelectedPlace:[self.suggestedPlaces objectAtIndex:indexPath.row]];
    [self performSegueWithIdentifier:@"pushAddQuestionSegue" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual: @"pushAddQuestionSegue"]) {
        AddQuestionAQTableViewController *destinationVC = segue.destinationViewController;
        [destinationVC setPlace:self.selectedPlace];
    }
}

@end
