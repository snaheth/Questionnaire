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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if ([PFUser currentUser] == nil) {
        OpeningViewController *open = [[OpeningViewController alloc] init];
        [self presentViewController:open animated:YES completion:nil];
        
        
        
        //[PFUser logInWithUsername:@"MaxHasADHD" password:@"testing"];
        /*
        UIImage *logo = [[UIImage imageNamed:@"975-balloon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *logoImageView = [[UIImageView alloc] initWithImage:logo];
        logoImageView.tintColor = [UIColor blueColor];
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        signUpViewController.fields = PFSignUpFieldsDefault;
        signUpViewController.signUpView.logo = logoImageView;
        signUpViewController.signUpView.emailAsUsername = true;
        [self presentViewController:signUpViewController animated:true completion:nil];
         */
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
