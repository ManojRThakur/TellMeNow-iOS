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

@interface QuestionAnswerViewController ()
@property (strong, nonatomic) Answer *answer;
@property (strong, nonatomic) NSMutableArray *listOfAnswers;
@property (weak, nonatomic) IBOutlet UITextView *questionTextLabel;
@property (weak, nonatomic) IBOutlet UITextView *questionUsername;
@property (weak, nonatomic) IBOutlet UITextView *questionDate;

@end

@implementation QuestionAnswerViewController

-(Answer *)answer
{
    if(!_answer) _answer = [[Answer alloc] init];
    return _answer;
}

-(NSMutableArray *)listOfAnswers
{
    if (!_listOfAnswers) _listOfAnswers = [[NSMutableArray alloc] init];
    return _listOfAnswers;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *answer = @"No";
    NSString *user = @"gotemb";
    NSString *time = @"04/05/14";
    [self.answer answerTextValue:answer usernameValue:user timeValue:time];
    
    [self.listOfAnswers addObject:answer];
    
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
        return [self.listOfAnswers count];
    else
        return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath indexAtPosition:0] == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionText"];
        self.questionTextLabel.text = self.question.questionText;
        self.questionDate.text = self.question.timestamp;
        self.questionUsername.text = self.question.username;
    }
    
    if ([indexPath indexAtPosition:0] == 1) {
       AnswerTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerCell"];
       Answer *answer = [self.listOfAnswers objectAtIndex:indexPath.row];
        cell.answerTextView.text = answer.answerText;
        cell.usernameLabel.text = answer.username;
        cell.timestampLabel.text = answer.timestamp;
    }
    
    return (UITableViewCell *)cell;
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
