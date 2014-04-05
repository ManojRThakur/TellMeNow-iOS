//
//  askQuestionViewController.m
//  TellMeNow
//
//  Created by Raghav on 4/4/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "askQuestionViewController.h"

@interface askQuestionViewController ()

@end

@implementation askQuestionViewController

NSArray *suggested;
NSArray *results;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    suggested = [NSArray arrayWithObjects:@"Facebook", @"Yahoo", @"Google", @"Microsoft", @"Ebay", @"Amazon", @"Dropbox", @"Uber", @"Heroku", @"Twitter", @"Apple", @"Box", @"Youtube", @"Snapchat", @"Cisco", @"LinkedIn", @"Hulu", @"Netflix", nil];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self getResultArray];
    return YES;
}

-(void) getResultArray
{
    results = [NSArray arrayWithObjects:@"Facebook", @"Yahoo", @"Google", @"Microsoft", @"Box", @"Youtube", @"Snapchat", @"Cisco", @"LinkedIn", @"Hulu", @"Netflix", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [results count];
        
    } else {
        return [suggested count];
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
        display = [results objectAtIndex:indexPath.row];
    } else {
        display = [suggested objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = display;
    
    return cell;
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
