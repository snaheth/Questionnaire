//
//  LocalSkyViewController.m
//  Questionnaire
//
//  Created by Maximilian Litteral on 4/4/15.
//  Copyright (c) 2015 Maximilian Litteral. All rights reserved.
//

#import "LocalSkyViewController.h"

#import <Parse/Parse.h>

#import "QuestionViewController.h"
#import "AskQuestionViewController.h"

#import "QuestionTableViewCell.h"

@interface LocalSkyViewController () <CLLocationManagerDelegate>

@end

@implementation LocalSkyViewController
{
    NSArray *questions;
    CLLocationManager *locationManager;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Local";
    self.tableView.estimatedRowHeight = 61;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.27 green:0.5 blue:0.56 alpha:1];
    
    // Bar button item
    UIBarButtonItem *newQuestionBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addQuestion)];
    self.navigationItem.rightBarButtonItem = newQuestionBarButtonItem;
    
    // Register cells
    [self.tableView registerClass:[QuestionTableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    // Request location
    if ([CLLocationManager authorizationStatus] == 0) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        [locationManager requestWhenInUseAuthorization];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse |
        status == kCLAuthorizationStatusAuthorizedAlways) {
        [self reloadData];
    }
}

#pragma mark - Actions

- (void)addQuestion {
    AskQuestionViewController *askQuestion = [[AskQuestionViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:askQuestion];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)reloadData {
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        PFQuery *query = [PFQuery queryWithClassName:@"Question"];
        [query whereKey:@"originLocation" nearGeoPoint:geoPoint withinKilometers:2];
        
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
    }];
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
