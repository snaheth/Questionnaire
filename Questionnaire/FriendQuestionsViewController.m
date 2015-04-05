//
//  FriendQuestionsViewController.m
//  Questionnaire
//
//  Created by Maximilian Litteral on 4/4/15.
//  Copyright (c) 2015 Maximilian Litteral. All rights reserved.
//

#import "FriendQuestionsViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <Parse/Parse.h>
#import "QuestionTableViewCell.h"

@interface FriendQuestionsViewController ()
@property NSMutableArray *friends;
@property NSMutableArray *questions;
@end

@implementation FriendQuestionsViewController
@synthesize friends, questions;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.navigationItem.title = @"Friend Questions";
    self.tableView.backgroundColor = [UIColor colorWithRed:0.27 green:0.5 blue:0.56 alpha:1];
    friends = [[NSMutableArray alloc] init];
    questions = [[NSMutableArray alloc] init];
    
    
    if([[FBSession activeSession] isOpen]){
        NSLog(@"You're good with active FBSession!");
    }
    else{
        [FBSession openActiveSessionWithPublishPermissions:[NSArray arrayWithObject:@"publish_actions"]
                                           defaultAudience:FBSessionDefaultAudienceOnlyMe
                                              allowLoginUI:YES
                                         completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                                             if (!error && status == FBSessionStateOpen) {
                                                 NSLog(@"No error. Status is state open.");
                                             }else{
                                                 NSLog(@"error");
                                             }
                                         }];
    }
    
    FBRequest *friendsReq = [FBRequest requestForMyFriends];
    [friendsReq startWithCompletionHandler:^(FBRequestConnection *connect, id result, NSError *err){
        if(!err){
            NSArray *friendObjects = [result objectForKey:@"data"];
            NSMutableArray *friendIds = [NSMutableArray arrayWithCapacity:friendObjects.count];
            for (NSDictionary *friendObject in friendObjects) {
                [friendIds addObject:[friendObject objectForKey:@"id"]];
            }
            PFQuery *friendQuery = [PFUser query];
            [friendQuery whereKey:@"fbId" containedIn:friendIds];
            NSArray *friendUsers = [friendQuery findObjects];
            PFQuery *obj = [PFQuery queryWithClassName:@"Question"];
            for(PFUser *friendUser in friendUsers){
                [obj whereKey:@"user" equalTo:friendUser];
                [obj findObjectsInBackgroundWithBlock:^(NSArray *arr, NSError *err){
                    if(!err){
                        for(PFObject *question in arr){
                            [questions addObject: question[@"text"]];
                            [friends addObject: friendUser[@"name"]];
                            [self.tableView reloadData];
                        }
                    }
                    else{
                        NSLog(@"Error getting questions.");
                    }
                }];
            }
        }
        else{
            NSLog(@"An error occured with getting facebook friend data!");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [questions count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [questions count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QuestionTableViewCell *tvc = [[QuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    
    //Take data from questions and friends array and display in the cell.....
    
    
    tvc.textLabel.textColor = [UIColor whiteColor];
    UIView *bgView = [[UIView alloc] initWithFrame:tvc.frame];
    bgView.backgroundColor = [UIColor colorWithWhite:0.50f alpha:1.0f];
    tvc.selectedBackgroundView = bgView;
    tvc.backgroundColor = [UIColor colorWithRed:0.12 green:0.69 blue:0.69 alpha:1];
    return tvc;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
