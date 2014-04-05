//
//  NotificationsTableViewController.m
//  TellMeNow
//
//  Created by Raghav on 4/5/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

#import "NotificationsTableViewController.h"
#import "Notification.h"
#import "QuestionAnswerViewController.h"

@interface NotificationsTableViewController ()
@property (strong, nonatomic) Notification *notification;
@property (strong, nonatomic) NSMutableArray *listOfNotifications;
@end

@implementation NotificationsTableViewController

-(NSMutableArray *)listOfNotifications
{
    if (!_listOfNotifications) _listOfNotifications = [[NSMutableArray alloc] init];
    return _listOfNotifications;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *time = @"04/05/14";
    NSString *question = @"Is it cold there?";
    NSString *user = @"gotemb";
    NSString *place = @"Santa Monica";
    if (place) {
        [self.notification timeStampValue:time questionTextValue:question answererValue:user];
        NSString *answerNotif = self.notification.getAnswerNotification;
        [self.listOfNotifications addObject:answerNotif];
    }
    
    if (user) {
        [self.notification timeStampValue:time questionTextValue:question locationValue:place];
        NSString *locationNotif = self.notification.getLocationNotification;
        [self.listOfNotifications addObject:locationNotif];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listOfNotifications count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
 
    if (cell == nil) {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier: simpleTableIdentifier];
    }
 
    NSString *display = nil;
    display = [self.listOfNotifications objectAtIndex:indexPath.row];
 
    cell.textLabel.text = display;
 
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setSelectedQuestion:[[[tableView cellForRowAtIndexPath:indexPath] textLabel] text]];
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
