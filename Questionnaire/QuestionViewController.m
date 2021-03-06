//
//  QuestionViewController.m
//  Questionnaire
//
//  Created by Maximilian Litteral on 4/4/15.
//  Copyright (c) 2015 Maximilian Litteral. All rights reserved.
//

#import "QuestionViewController.h"

#import "MLTextFieldTableCell.h"

@interface QuestionViewController () <MLTextFieldFullTableViewCellDelegate>
@property NSInteger importantIndex;
@end

@implementation QuestionViewController
{
    NSArray *options;
    UIView *headerView;
    BOOL isOpenEnded;
}
@synthesize importantIndex;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.27 green:0.5 blue:0.56 alpha:1];
    
    
    //Fetch
    options = [self.question objectForKey:@"options"];
    for (PFObject *object in options) {
        [object fetchIfNeeded];
    }
    
    importantIndex = [self getHighestOption];
    
    // Header view
    headerView = [[UIView alloc] init];
    
    UILabel *questionLabel = [[UILabel alloc] init];
    questionLabel.numberOfLines = 0;
    [self.question fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        questionLabel.text = [object objectForKey:@"text"];
        isOpenEnded = [[object objectForKey:@"openEnded"] boolValue];
    }];
    questionLabel.textAlignment = NSTextAlignmentCenter;
    questionLabel.textColor = [UIColor whiteColor];
    
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
    [self.tableView registerClass:[MLTextFieldFullTableViewCell class] forCellReuseIdentifier:@"TextFieldCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MLTextFieldFullTableViewCellDelegate

- (void)cellDidBeginEditing:(MLTextFieldFullTableViewCell *)cell {
    
}

- (void)cellDidEndEditing:(MLTextFieldFullTableViewCell *)cell {
    PFObject *reply = [PFObject objectWithClassName:@"Reply"];
    [reply setObject:cell.textField.text forKey:@"text"];
    [reply setObject:self.question forKey:@"question"];
    [reply saveInBackground];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (isOpenEnded) {
        return 1;
    }
    return [options count];
}

-(NSInteger)getHighestOption{
    NSInteger highestCount = 0;
    int index = 0;
    for(int i =0; i < [options count]; i++){
        PFObject *obj = [options objectAtIndex:i];
        NSNumber *num = obj[@"count"];
        NSInteger numInt = [num integerValue];
        if(numInt > highestCount){
            highestCount = [obj[@"count"] integerValue];
            index = i;
        }
    }
    NSLog(@"%d" , index);
    return index;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (isOpenEnded) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TextFieldCell" forIndexPath:indexPath];
        MLTextFieldFullTableViewCell *textFieldCell = (MLTextFieldFullTableViewCell *)cell;
        textFieldCell.placeholder = @"Enter a reply...";
        textFieldCell.delegate = self;
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        PFObject *option = options[indexPath.row];
        cell.textLabel.text = [option objectForKey:@"text"];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:0.12 green:0.69 blue:0.69 alpha:1];
        if([indexPath row] == importantIndex){
            cell.backgroundColor = [UIColor colorWithRed:58/255.0f green:65/255.0f blue:95/255.0f alpha:1.0f];
        }
        //if(cell has most votes...it is a bright color to show trending....)
    }
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
    NSNumber *scoreValue = [PFUser currentUser][@"score"];
    NSInteger scoreIntValue = [scoreValue integerValue];
    [[PFUser currentUser] setObject: [NSNumber numberWithInteger:scoreIntValue + 1] forKey:@"score"];
    [[PFUser currentUser] saveInBackground];
    NSLog(@"OUR CHANGED SCORE IS: %d" , scoreIntValue + 1);
    [option setObject:[NSNumber numberWithInteger:votes.integerValue+1] forKey:@"votes"];
    [option save];
}

@end
