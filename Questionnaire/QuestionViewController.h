//
//  QuestionViewController.h
//  Questionnaire
//
//  Created by Maximilian Litteral on 4/4/15.
//  Copyright (c) 2015 Maximilian Litteral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface QuestionViewController : UITableViewController

@property (nonatomic, strong) PFObject *question;

@end
