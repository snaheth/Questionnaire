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
#import "MLTextFieldTableCell.h"

typedef NS_ENUM(NSInteger, QuestionType) {
    QuestionTypeYesNo = 0,
    QuestionTypeOpen,
    QuestionTypeMutlipleChoice,
};

@interface AskQuestionViewController () <MLTextFieldFullTableViewCellDelegate>

@end

@implementation AskQuestionViewController
{
    UIView *headerView;
    UITextView *textView;
    QuestionType questionType;
    
    NSInteger numberOfMutlipleChoiceAnswers;
    NSMutableArray *multipleChoiceAnswers;
    
    id currentResponder;
}
@synthesize locManager , userLoc;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    locManager = [[CLLocationManager alloc] init];
    locManager.delegate = self;
    [locManager startUpdatingLocation];
    
    self.title = @"Ask Question";
    self.tableView.backgroundColor = [UIColor colorWithRed:0.27 green:0.5 blue:0.56 alpha:1];
    // Default question type
    questionType = QuestionTypeYesNo;
    numberOfMutlipleChoiceAnswers = 0;
    multipleChoiceAnswers = [[NSMutableArray alloc] init];
    
    // Header view
    headerView = [[UIView alloc] init];
    
    // Segment Control
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Yes/No",@"Open",@"Multiple-Choice"]];
    segmentedControl.tintColor = [UIColor whiteColor];
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false;
    [headerView addSubview:segmentedControl];
    
    // Text view
    textView = [[UITextView alloc] init];
    textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    textView.translatesAutoresizingMaskIntoConstraints = false;
    [headerView addSubview:textView];
    
    // Constraints
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    NSDictionary *views = @{
                            @"textView": textView,
                            @"segmentedControl": segmentedControl,
                            };
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[textView]|" options:0 metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[segmentedControl]|" options:0 metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[segmentedControl(44)][textView]-10-|" options:0 metrics:nil views:views]];
    [headerView addConstraints:constraints];
    
    // Bar button items
    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissViewController)];
    self.navigationItem.leftBarButtonItem = cancelBarButtonItem;
    
    UIBarButtonItem *askQuestionBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Ask" style:UIBarButtonItemStylePlain target:self action:@selector(ask)];
    self.navigationItem.rightBarButtonItem = askQuestionBarButtonItem;
    
    // Register cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView registerClass:[MLTextFieldFullTableViewCell class] forCellReuseIdentifier:@"TextFieldCell"];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    userLoc = locations[0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MLTextFieldFullTableViewCellDelegate

- (void)cellDidBeginEditing:(MLTextFieldFullTableViewCell *)cell {
    currentResponder = cell.textField;
}

- (void)cellDidEndEditing:(MLTextFieldFullTableViewCell *)cell {
    currentResponder = nil;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (cell.textField.text) {
        multipleChoiceAnswers[indexPath.row] = cell.textField.text;
    }
    else {
        NSLog(@"NILLLLL");
    }
}

#pragma mark - Actions

- (void)dismissViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)ask {
    if (currentResponder != nil) {
        [currentResponder resignFirstResponder];
    }
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        [self askOnParse:geoPoint];
    }];
    
}

- (void)askOnParse:(PFGeoPoint *)point {
    // Create the question
    PFObject *newQuestion = [PFObject objectWithClassName:@"Question"];
    [newQuestion setObject:textView.text forKey:@"text"];
    [newQuestion setObject:[PFUser currentUser] forKey:@"user"];
    if (point != nil) {
        [newQuestion setObject:point forKey:@"originLocation"];
    }
    
    //The location will come from lines 91-92, which define the variable userLoc. You can convert a CLLocation to a Parse PFGeoPoint to store location in servers. 
    
    
    // Add the options
    if (questionType == QuestionTypeYesNo) {
        [newQuestion setObject:[NSNumber numberWithBool:false] forKey:@"openEnded"];
        
        PFObject *optionOne = [PFObject objectWithClassName:@"Option"];
        [optionOne setObject:@"Yes" forKey:@"text"];
        
        PFObject *optionTwo = [PFObject objectWithClassName:@"Option"];
        [optionTwo setObject:@"No" forKey:@"text"];
        
        NSArray *options = @[optionOne, optionTwo];
        [newQuestion setObject:options forKey:@"options"];
    }
    else if (questionType == QuestionTypeOpen) {
        [newQuestion setObject:[NSNumber numberWithBool:true] forKey:@"openEnded"];
    }
    else if (questionType == QuestionTypeMutlipleChoice) {
        [newQuestion setObject:[NSNumber numberWithBool:false] forKey:@"openEnded"];
        
        NSMutableArray *options = [[NSMutableArray alloc] init];
        for (NSString *option in multipleChoiceAnswers) {
            PFObject *optionObject = [PFObject objectWithClassName:@"Option"];
            [optionObject setObject:option forKey:@"text"];
            
            [options addObject:optionObject];
        }
        
        [newQuestion setObject:options forKey:@"options"];
    }
    
    // ACL
    PFACL *questionACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [questionACL setPublicReadAccess:true];
    [questionACL setPublicWriteAccess:false];
    [newQuestion setACL:questionACL];
    
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

- (void)segmentedControlValueChanged:(UISegmentedControl *)segmentedControl {
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            questionType = QuestionTypeYesNo;
            break;
        case 1:
            questionType = QuestionTypeOpen;
            break;
        case 2:
            questionType = QuestionTypeMutlipleChoice;
            break;
            
        default:
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return numberOfMutlipleChoiceAnswers+1;
    }
    else {
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if (indexPath.row == [tableView numberOfRowsInSection:0]-1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell.textLabel.text = @"Add another option";
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TextFieldCell" forIndexPath:indexPath];
        MLTextFieldFullTableViewCell *textFieldCell = (MLTextFieldFullTableViewCell *)cell;
        textFieldCell.placeholder = @"Enter a mutliple-choice answer";
        textFieldCell.text = multipleChoiceAnswers[indexPath.row];
        textFieldCell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return headerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 150;
    }
    else {
        return 0;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [tableView numberOfRowsInSection:0]-1) {
        return UITableViewCellEditingStyleInsert;
    }
    else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        numberOfMutlipleChoiceAnswers--;
        [multipleChoiceAnswers removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        numberOfMutlipleChoiceAnswers++;
        [multipleChoiceAnswers insertObject:@"" atIndex:numberOfMutlipleChoiceAnswers-1];
        [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:numberOfMutlipleChoiceAnswers-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    if (indexPath.row == [tableView numberOfRowsInSection:0]-1) {
        numberOfMutlipleChoiceAnswers++;
        [multipleChoiceAnswers insertObject:@"" atIndex:numberOfMutlipleChoiceAnswers-1];
        [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:numberOfMutlipleChoiceAnswers-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else {
        MLTextFieldFullTableViewCell *textFieldCell = (MLTextFieldFullTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        [textFieldCell.textField becomeFirstResponder];
    }
}

@end
