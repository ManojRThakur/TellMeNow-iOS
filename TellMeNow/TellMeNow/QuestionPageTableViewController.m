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
#import "User.h"

@implementation QuestionPageTableViewController {
    bool questionLoaded;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    questionLoaded = false;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return questionLoaded ? 2 : 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"";
    } else {
        return @"Answers";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!questionLoaded) {
        return 0;
    }
    if (section == 0) {
        return 2 + [[self.question getComments] count];
    } else {
        return 1 + [[self.question getAnswers] count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0)
            return 92;
        else if (indexPath.row == [[self.question getComments] count] + 1)
            return 29;
        else
            return 59;
    } else {
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier;
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        simpleTableIdentifier = @"questionTextLabel";
        cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[QuestionPageHeadingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        
        [[(QuestionPageHeadingTableViewCell *)cell questionTextLabel] setText:self.question.text];
        [[(QuestionPageHeadingTableViewCell *)cell questionUsername] setText:[[self.question getUser] name]];
        [[(QuestionPageHeadingTableViewCell *)cell questionDate] setText:self.question.timestamp];
    }
    else if (indexPath.section == 0 && indexPath.row <= [[self.question getComments] count]) {
        simpleTableIdentifier = @"questionComment";
        cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[QuestionPageCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        
        [[(QuestionPageCommentTableViewCell *)cell commentText] setText:[[self.question getComments][indexPath.row - 1] text]];
        [[(QuestionPageCommentTableViewCell *)cell commentUsername] setText:[[[self.question getComments][indexPath.row - 1] getUser] name]];

    } else if (indexPath.section == 0) {
        simpleTableIdentifier = @"addCommentButton";
        cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
    } else if (indexPath.row < [[self.question getAnswers] count]) {
        simpleTableIdentifier = @"answerText";
        cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[QuestionPageAnswersTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        
        [[(QuestionPageAnswersTableViewCell *)cell answerText] setText:[[self.question getAnswers][indexPath.row] text]];
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
    if (indexPath.section == 1 && indexPath.row < [[self.question getAnswers] count]) {
        [self setSelectedAnswer:[[self.question getAnswers] objectAtIndex:indexPath.row]];
        [self performSegueWithIdentifier:@"answerPage" sender:self];
    }
    if (indexPath.section == 1 && indexPath.row == [[self.question getAnswers] count]) {
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

- (void)questionDidLoad
{
    if (!questionLoaded) {
        questionLoaded = true;
        [self.tableView beginUpdates];
        [self.tableView insertSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView insertSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    }
}

@end
