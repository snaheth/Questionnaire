//
//  AskQuestionViewController.m
//  Questionnaire
//
//  Created by Maximilian Litteral on 4/4/15.
//  Copyright (c) 2015 Maximilian Litteral. All rights reserved.
//

#import "AskQuestionViewController.h"

#import <Parse/Parse.h>

#import "SwitchTableViewCell.h"

@interface AskQuestionViewController ()

@end

@implementation AskQuestionViewController
{
    UIView *headerView;
    UITextView *textView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.27 green:0.5 blue:0.56 alpha:1];

    // Header view
    headerView = [[UIView alloc] init];
    
    // Text view
    textView = [[UITextView alloc] init];
    textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    textView.translatesAutoresizingMaskIntoConstraints = false;
    [headerView addSubview:textView];
    
    // Constraints
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    NSDictionary *views = @{
                            @"textView": textView,
                            };
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[textView]|" options:0 metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[textView]-10-|" options:0 metrics:nil views:views]];
    [headerView addConstraints:constraints];
    
    // Bar button items
    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissViewController)];
    self.navigationItem.leftBarButtonItem = cancelBarButtonItem;
    
    UIBarButtonItem *askQuestionBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Ask" style:UIBarButtonItemStylePlain target:self action:@selector(ask)];
    self.navigationItem.rightBarButtonItem = askQuestionBarButtonItem;
    
    // Register cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView registerClass:[SwitchTableViewCell class] forCellReuseIdentifier:@"SwitchCell"];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    }
    else {
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    // Configure the cell...
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell" forIndexPath:indexPath];
        SwitchTableViewCell *switchCell = (SwitchTableViewCell *)cell;
        switchCell.textLabel.text = @"Is a Yes / No question?";
        switchCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 150;
}

#pragma mark - Table view delegate

@end
