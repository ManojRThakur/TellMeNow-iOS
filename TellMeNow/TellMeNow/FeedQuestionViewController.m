//
//  FeedQuestionViewController.m
//  TellMeNow
//
//  Created by Raghav on 4/12/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "FeedQuestionViewController.h"
#import "FeedQuestionTableViewCell.h"

@interface FeedQuestionViewController ()

@end

@implementation FeedQuestionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.suggestedQuestions = [NSMutableArray arrayWithArray:@[@"Facebook", @"Yahoo", @"Google", @"Microsoft", @"Ebay", @"Amazon", @"Dropbox", @"Uber", @"Heroku", @"Twitter", @"Apple", @"Box", @"Youtube", @"Snapchat", @"Cisco", @"LinkedIn", @"Hulu", @"Netflix"]];
    self.searchedQuestions = [NSMutableArray arrayWithArray:@[@"Facebook", @"Yahoo", @"Google", @"Microsoft", @"Ebay", @"Amazon", @"Dropbox", @"Uber", @"Heroku", @"Twitter", @"Apple", @"Box", @"Youtube", @"Snapchat", @"Cisco", @"LinkedIn", @"Hulu", @"Netflix"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchedQuestions count];
        
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
        display = [self.searchedQuestions objectAtIndex:indexPath.row];
    } else {
        display = [self.suggestedQuestions objectAtIndex:indexPath.row];
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
