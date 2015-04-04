//
//  ViewController.m
//  Questionnaire
//
//  Created by Maximilian Litteral on 4/4/15.
//  Copyright (c) 2015 Maximilian Litteral. All rights reserved.
//

#import "ViewController.h"

#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

#import "QuestionViewController.h"
#import "AskQuestionViewController.h"
#import "OpeningViewController.h"
#import "QuestionTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSArray *questions;
}

-(void)addQuestionRight{
    [self addQuestion];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.estimatedRowHeight = 58;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Title View
    UIView *titleView = [[UIView alloc] init];
    
    UILabel *questionsLabel = [[UILabel alloc] init];
    questionsLabel.text = @"Questions";
    questionsLabel.textColor = [UIColor whiteColor];
    questionsLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:18];
    questionsLabel.translatesAutoresizingMaskIntoConstraints = false;
    [titleView addSubview:questionsLabel];
    
    [titleView addConstraint:[NSLayoutConstraint constraintWithItem:questionsLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:titleView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [titleView addConstraint:[NSLayoutConstraint constraintWithItem:questionsLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:titleView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [titleView addConstraint:[NSLayoutConstraint constraintWithItem:questionsLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.0]];
    
    self.navigationItem.titleView = titleView;
    
    // Login
    if ([PFUser currentUser] == nil) {
        OpeningViewController *open = [[OpeningViewController alloc] init];
        [self presentViewController:open animated:YES completion:nil];
    }
    else {
        
    }
    
    // Register cells
    [self.tableView registerClass:[QuestionTableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Question"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error == nil) {
            questions = objects;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        else {
            NSLog(@"Error: %@", error);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)addQuestion {
    AskQuestionViewController *askQuestion = [[AskQuestionViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:askQuestion];
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [questions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    PFObject *questionObject = questions[indexPath.row];
    cell.questionPreviewLabel.text = [questionObject objectForKey:@"text"];
    cell.userTitleLabel.text = @"Knowledge King";
    cell.commentsLabel.text = @"Comments (0)";
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PFObject *questionObject = questions[indexPath.row];
    QuestionViewController *questionViewController = [[QuestionViewController alloc] initWithStyle:UITableViewStyleGrouped];
    questionViewController.question = questionObject;
    [self.navigationController pushViewController:questionViewController animated:YES];
}

#pragma mark - Status bar

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
