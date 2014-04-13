//
//  NotificationsTableViewController.m
//  TellMeNow
//
//  Created by Raghav on 4/5/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "NotificationsTableViewController.h"
#import "Notification.h"
#import "Question.h"

@interface NotificationsTableViewController ()
@property (strong, nonatomic) NSArray *notifications;
@end

@implementation NotificationsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.notifications = self.user.getNotifications;
/*    NSString *time = @"04/05/14";
    NSString *question = @"Is it cold there?";
    NSString *user = @"gotemb";
    NSString *place = @"Santa Monica";
*/
//    [self.selectedQuestion questionTextValue:(NSString *)question usernameValue:(NSString *)user timeValue:(NSString *)time placeValue:(NSString *)place];
    
    BOOL placeFlag = true, userFlag = true;
    if (placeFlag) {
//        [self.notification timeStampValue:time questionTextValue:question answererValue:user];
//        NSString *answerNotif = self.notification.getAnswerNotification;
//        [self.listOfNotifications addObject:answerNotif];
    }
    
    if (userFlag) {
//        [self.notification timeStampValue:time questionTextValue:question locationValue:place];
//        NSString *locationNotif = self.notification.getLocationNotification;
//        [self.listOfNotifications addObject:locationNotif];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.user.getNotifications count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier;
    NSInteger idx = indexPath.row;
    switch ([[self.notifications objectAtIndex:idx] notificationFor]) {
        case QUESTION_NOTIFICATION:
            simpleTableIdentifier = @"notifQuestionCell";
            break;
        case ANSWER_NOTIFICATION:
            simpleTableIdentifier = @"notifAnswerCell";
            break;
        case COMMENT_NOTIFICATION:
            simpleTableIdentifier = @"notifCommentCell";
            break;
        case FOLLOWUP_NOTIFICATION:
            simpleTableIdentifier = @"notifFollowupCell";
            break;
        default:
            break;
    }
 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
 
    if (cell == nil) {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier: simpleTableIdentifier];
    }
 
    NSString *display = nil;
 
    cell.textLabel.text = display;
 
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"QuestionAnswers" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual: @"QuestionAnswers"]) {
        QuestionAnswerViewController *destinationVC = segue.destinationViewController;
        [destinationVC setQuestion:self.selectedQuestion];
    }
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
