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
@property NSArray *parseQuestions;
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
                        _parseQuestions = arr;
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
    
    // Register cells
    [self.tableView registerClass:[QuestionTableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_parseQuestions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    PFObject *obj = [_parseQuestions objectAtIndex:indexPath.row];
    [obj fetchIfNeeded];
    PFUser *user = obj[@"user"];
    [user fetchIfNeeded];
    
    cell.questionPreviewLabel = obj[@"text"];
    cell.userTitleLabel = user[@"status"];
    cell.commentsLabel = user[@"score"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end
