//
//  AskQuestionViewController.m
//  Questionnaire
//
//  Created by Maximilian Litteral on 4/4/15.
//  Copyright (c) 2015 Maximilian Litteral. All rights reserved.
//

#import "AskQuestionViewController.h"

#import <Parse/Parse.h>

@interface AskQuestionViewController ()

@end

@implementation AskQuestionViewController
{
    UITextView *textView;
}

-(BOOL)prefersStatusBarHidden{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    textView = [[UITextView alloc] init];
    textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    
    // Bar button items
    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissViewController)];
    self.navigationItem.leftBarButtonItem = cancelBarButtonItem;
    
    UIBarButtonItem *askQuestionBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Ask" style:UIBarButtonItemStylePlain target:self action:@selector(ask)];
    self.navigationItem.rightBarButtonItem = askQuestionBarButtonItem;
    
    // Register cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)dismissViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)ask {
    PFObject *newQuestion = [PFObject objectWithClassName:@"Question"];
    [newQuestion setObject:textView.text forKey:@"text"];
    [newQuestion setObject:[PFUser currentUser] forKey:@"user"];
    
    PFObject *optionOne = [PFObject objectWithClassName:@"Option"];
    [optionOne setObject:@"QuestionnAIR" forKey:@"text"];
    
    PFObject *optionTwo = [PFObject objectWithClassName:@"Option"];
    [optionTwo setObject:@"The one above me" forKey:@"text"];
    
    PFObject *optionThree = [PFObject objectWithClassName:@"Option"];
    [optionThree setObject:@"Option 1!" forKey:@"text"];
    
    // ACL
    PFACL *questionACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [questionACL setPublicReadAccess:true];
    [questionACL setPublicWriteAccess:false];
    [newQuestion setACL:questionACL];
    
    NSArray *options = @[optionOne, optionTwo, optionThree];
    [newQuestion setObject:options forKey:@"options"];
    
    // Save
    
    [newQuestion saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"Succeeded: %@", succeeded ? @"YES" : @"NO");
        if (error) {
            NSLog(@"ERROR: %@", error);
        }
        else {
            [self dismissViewController];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return textView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}

#pragma mark - Table view delegate

@end
