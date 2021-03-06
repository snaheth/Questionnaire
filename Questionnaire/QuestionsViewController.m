//
//  QuestionsViewController.m
//  Questionnaire
//
//  Created by Maximilian Litteral on 4/4/15.
//  Copyright (c) 2015 Maximilian Litteral. All rights reserved.
//

#import "QuestionsViewController.h"

#import <Parse/Parse.h>

#import "QuestionViewController.h"
#import "AskQuestionViewController.h"

#import "QuestionTableViewCell.h"

@interface QuestionsViewController ()

@end

@implementation QuestionsViewController
{
    NSArray *questions;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Global";
    self.tableView.estimatedRowHeight = 61;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.27 green:0.5 blue:0.56 alpha:1];
    
    // Bar button item
    UIBarButtonItem *newQuestionBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addQuestion)];
    self.navigationItem.rightBarButtonItem = newQuestionBarButtonItem;
    
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

- (void)addQuestion {
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

@end
