//
//  QuestionAnswerViewController.m
//  TellMeNow
//
//  Created by Raghav on 4/5/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "QuestionAnswerViewController.h"
#import "Answer.h"
#import "AnswerTableViewCell.h"
#import "Question.h"
#import "QuestionTableViewCell.h"

@implementation QuestionAnswerViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.answers = [[NSMutableArray alloc] initWithCapacity:10];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1)
        return [self.answers count];
    else
        return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath indexAtPosition:0] == 0) {
        QuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionText"];
        [cell.questionTextView setText:self.question.text];
        [cell.timestampLabel setText:self.question.timestamp];
        //[cell.usernameLabel setText:self.question.username];
        return cell;
    }
    else if ([indexPath indexAtPosition:0] == 1) {
        AnswerTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerCell"];
        Answer *answer = [self.answers objectAtIndex:indexPath.row];
        cell.answerTextView.text = answer.text;
        //cell.usernameLabel.text = answer.username;
        cell.timestampLabel.text = answer.timestamp;
        return (UITableViewCell *)cell;
    }
    else
        return nil;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
