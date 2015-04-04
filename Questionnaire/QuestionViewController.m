//
//  QuestionViewController.m
//  Questionnaire
//
//  Created by Maximilian Litteral on 4/4/15.
//  Copyright (c) 2015 Maximilian Litteral. All rights reserved.
//

#import "QuestionViewController.h"

@interface QuestionViewController ()

@end

@implementation QuestionViewController
{
    NSArray *options;
    UIView *headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Question";
    self.tableView.backgroundColor = [UIColor colorWithRed:0.27 green:0.5 blue:0.56 alpha:1];
    
    
    
    // Fetch
    options = [self.question objectForKey:@"options"];
    for (PFObject *object in options) {
        [object fetchIfNeeded];
    }
    
    // Header view
    headerView = [[UIView alloc] init];
    
    UILabel *questionLabel = [[UILabel alloc] init];
    questionLabel.numberOfLines = 0;
    [self.question fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        questionLabel.text = [object objectForKey:@"text"];
    }];
    questionLabel.textAlignment = NSTextAlignmentCenter;
    questionLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    questionLabel.translatesAutoresizingMaskIntoConstraints = false;
    [headerView addSubview:questionLabel];
    
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    NSDictionary *views = @{
                            @"questionLabel": questionLabel,
                            };
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[questionLabel]|" options:0 metrics:nil views:views]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:questionLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:headerView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [headerView addConstraints:constraints];
    
    // Register cells
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
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
    return [options count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    PFObject *option = options[indexPath.row];
    cell.textLabel.text = [option objectForKey:@"text"];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PFObject *option = options[indexPath.row];
    NSNumber *votes = [option objectForKey:@"votes"];
    [option setObject:[NSNumber numberWithInteger:votes.integerValue+1] forKey:@"votes"];
    [option save];
}

@end
