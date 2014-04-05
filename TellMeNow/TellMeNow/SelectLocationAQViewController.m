//
//  askQuestionViewController.m
//  TellMeNow
//
//  Created by Raghav on 4/4/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "SelectLocationAQViewController.h"
#import "AddQuestionAQTableViewController.h"

@interface SelectLocationAQViewController ()

@end

@implementation SelectLocationAQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.suggestedPlaces = [[NSMutableArray alloc] initWithCapacity:10];
    self.searchPlaceResults = [[NSMutableArray alloc] initWithCapacity:10];
    [self.suggestedPlaces addObjectsFromArray:@[@"Facebook", @"Yahoo", @"Google", @"Microsoft", @"Ebay", @"Amazon", @"Dropbox", @"Uber", @"Heroku", @"Twitter", @"Apple", @"Box", @"Youtube", @"Snapchat", @"Cisco", @"LinkedIn", @"Hulu", @"Netflix"]];
    [self.searchPlaceResults addObjectsFromArray:@[@"Facebook", @"Yahoo", @"Google", @"Microsoft", @"Ebay", @"Amazon", @"Dropbox", @"Uber", @"Heroku", @"Twitter", @"Apple", @"Box", @"Youtube", @"Snapchat", @"Cisco", @"LinkedIn", @"Hulu", @"Netflix"]];
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
    [self getResultArray];
    return YES;
}

-(void) getResultArray
{
    // Reload Here...
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
        display = [self.searchPlaceResults objectAtIndex:indexPath.row];
    } else {
        display = [self.suggestedPlaces objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = display;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setSelectedLocation:[[[tableView cellForRowAtIndexPath:indexPath] textLabel] text]];
    [self performSegueWithIdentifier:@"pushAddQuestionSegue" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual: @"pushAddQuestionSegue"]) {
        AddQuestionAQTableViewController *destinationVC = segue.destinationViewController;
        [destinationVC setLocation:self.selectedLocation];
    }
}

@end
