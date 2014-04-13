//
//  QuestionPageTableViewController.m
//  TellMeNow
//
//  Created by Raghav on 4/12/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "QuestionPageTableViewController.h"
#import "QuestionPageHeadingTableViewCell.h"
#import "QuestionPageCommentTableViewCell.h"
#import "QuestionPageAnswersTableViewCell.h"
#import "AnswerPageTableViewController.h"
#import "AddAnswerTableViewController.h"


@interface QuestionPageTableViewController ()

@end

@implementation QuestionPageTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//FIX THIS!!    [self.question getCommentsWithCallback:self.comments];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3 + [self.answers count] + [self.comments count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier;
    UITableViewCell *cell = nil;
    
    NSInteger idx = indexPath.row;
    if (idx == 0) {
        simpleTableIdentifier = @"questionTextLabel";
        cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[QuestionPageHeadingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        
        //HELP SETTING LABELS!!!
    }
    else if (idx >= 1 && idx <= [self.comments count]) {
        simpleTableIdentifier = @"questionComment";
        cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[QuestionPageCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }

    } else if (idx == [self.comments count] + 1) {
        simpleTableIdentifier = @"addCommentButton";
        cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
    } else if (idx > [self.comments count] + 1 && idx < [self.comments count] + [self.answers count] + 1) {
        simpleTableIdentifier = @"answerText";
        cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[QuestionPageAnswersTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
    } else {
        simpleTableIdentifier = @"addAnswer";
        cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
    }
    
   

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > [self.comments count] + 1 && indexPath.row < [self.comments count] + [self.answers count] + 1) {
        [self setSelectedAnswer:[self.answers objectAtIndex:indexPath.row]];
        [self performSegueWithIdentifier:@"answerPage" sender:self];
    }
    if (indexPath.row == [self.comments count] + [self.answers count] + 2) {
        [self performSegueWithIdentifier:@"addAnswer" sender:self];
    }
}
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual: @"answerPage"]) {
        AnswerPageTableViewController *destinationVC = segue.destinationViewController;
        [destinationVC setAnswer:self.selectedAnswer];
    }
    
    if ([segue.identifier isEqual: @"addAnswer"]) {
        AddAnswerTableViewController *destinationVC = segue.destinationViewController;
        [destinationVC setQuestion:self.question];
    }
    
}

@end
