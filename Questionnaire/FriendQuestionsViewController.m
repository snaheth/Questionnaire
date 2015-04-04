//
//  FriendQuestionsViewController.m
//  Questionnaire
//
//  Created by Maximilian Litteral on 4/4/15.
//  Copyright (c) 2015 Maximilian Litteral. All rights reserved.
//

#import "FriendQuestionsViewController.h"

@interface FriendQuestionsViewController ()

@end

@implementation FriendQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Title View
    UIView *titleView = [[UIView alloc] init];
    
    UILabel *questionsLabel = [[UILabel alloc] init];
    questionsLabel.text = @"Friend Questions";
    questionsLabel.textColor = [UIColor whiteColor];
    questionsLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:18];
    questionsLabel.translatesAutoresizingMaskIntoConstraints = false;
    [titleView addSubview:questionsLabel];
    
    [titleView addConstraint:[NSLayoutConstraint constraintWithItem:questionsLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:titleView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [titleView addConstraint:[NSLayoutConstraint constraintWithItem:questionsLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:titleView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [titleView addConstraint:[NSLayoutConstraint constraintWithItem:questionsLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.0]];
    
    self.navigationItem.titleView = titleView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
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
