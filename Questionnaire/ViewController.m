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


#import "OpeningViewController.h"
#import "FriendQuestionsViewController.h"
#import "QuestionsViewController.h"
#import "LocalSkyViewController.h"
#import "SkyView.h"

@interface ViewController () <SkyFallProtocol>

@end

@implementation ViewController


- (void) viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Choose a sky";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:nil];

    //Login
    if ([PFUser currentUser] == nil) {
        OpeningViewController *open = [[OpeningViewController alloc] init];
        [self presentViewController:open animated:YES completion:nil];
    }
    else {
        
    }
    
    SkyView *globalSky = [[SkyView alloc] init];
    globalSky.backgroundColor = [UIColor colorWithRed:0.23 green:0.25 blue:0.37 alpha:1];
    globalSky.imageView.image = [UIImage imageNamed:@"GlobalSky"];
    globalSky.titleLabel.text = @"Global Sky";
    globalSky.delegate = self;
    globalSky.tag = 0;
    globalSky.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:globalSky];
    
    
    SkyView *localSky = [[SkyView alloc] init];
    localSky.backgroundColor = [UIColor colorWithRed:0.29 green:0.35 blue:0.58 alpha:1];
    localSky.imageView.image = [UIImage imageNamed:@"LocalSky"];
    localSky.titleLabel.text = @"Local Sky";
    localSky.delegate = self;
    localSky.tag = 1;
    localSky.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:localSky];
    
    
    SkyView *friendlySky = [[SkyView alloc] init];
    friendlySky.backgroundColor = [UIColor colorWithRed:0.51 green:0.49 blue:0.65 alpha:1];
    friendlySky.imageView.image = [UIImage imageNamed:@"FriendlySky"];
    friendlySky.titleLabel.text = @"Friendly Sky";
    friendlySky.delegate = self;
    friendlySky.tag = 2;
    friendlySky.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:friendlySky];
    
    
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    NSDictionary *views = @{
                            @"globalSky": globalSky,
                            @"localSky": localSky,
                            @"friendlySky": friendlySky,
                            };
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[globalSky]|" options:0 metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[localSky]|" options:0 metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[friendlySky]|" options:0 metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[globalSky][localSky(==globalSky)][friendlySky(==localSky)]-49-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:constraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SkyFallProtocol

- (void)skyViewTapped:(SkyView *)skyView {
    if (skyView.tag == 0) {
        QuestionsViewController *questionsViewController = [[QuestionsViewController alloc] init];
        [self.navigationController pushViewController:questionsViewController animated:YES];
    }
    else if (skyView.tag == 1) {
        LocalSkyViewController *localSkyViewController = [[LocalSkyViewController alloc] init];
        [self.navigationController pushViewController:localSkyViewController animated:true];
    }
    else if (skyView.tag == 2) {
        FriendQuestionsViewController *friendlySky = [[FriendQuestionsViewController alloc] init];
        [self.navigationController pushViewController:friendlySky animated:YES];
    }
}

@end
