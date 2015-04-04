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

@interface ViewController ()

@end

@implementation ViewController
{
    NSArray *questions;
}

-(void)addQuestionButton{
    [self addQuestion];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithCGImage:[UIImage imageNamed:@"AddButton"].CGImage scale:4.5f orientation:UIImageOrientationUp] style:UIBarButtonItemStylePlain target:self action:@selector(addQuestion)];
    rightButton.tintColor = [UIColor colorWithRed:218/255.0f green:218/255.0f blue:218/255.0f alpha:1.0f];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    UIView *titleView = [[UIView alloc] init];
    
    UILabel *questionsLabel = [[UILabel alloc] init];
    questionsLabel.text = @"Questions";
    questionsLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:18];
    questionsLabel.translatesAutoresizingMaskIntoConstraints = false;
    [titleView addSubview:questionsLabel];
    
    
    [titleView addConstraint:[NSLayoutConstraint constraintWithItem:questionsLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:titleView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [titleView addConstraint:[NSLayoutConstraint constraintWithItem:questionsLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:titleView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [titleView addConstraint:[NSLayoutConstraint constraintWithItem:questionsLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.0]];
    
    self.navigationItem.titleView = titleView;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:0.27 green:0.5 blue:0.56 alpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.12 green:0.69 blue:0.69 alpha:1];
    
    if ([PFUser currentUser] == nil) {
        OpeningViewController *open = [[OpeningViewController alloc] init];
        [self presentViewController:open animated:YES completion:nil];
    }
    else {
        
    }
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    PFObject *questionObject = questions[indexPath.row];
    cell.textLabel.text = [questionObject objectForKey:@"text"];
    
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
