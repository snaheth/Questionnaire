//
//  AskQuestionViewController.h
//  Questionnaire
//
//  Created by Maximilian Litteral on 4/4/15.
//  Copyright (c) 2015 Maximilian Litteral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface AskQuestionViewController : UITableViewController<CLLocationManagerDelegate>
@property CLLocationManager *locManager;
@property CLLocation *userLoc;
@end
