//
//  AppDelegate.m
//  Questionnaire
//
//  Created by Maximilian Litteral on 4/4/15.
//  Copyright (c) 2015 Maximilian Litteral. All rights reserved.
//

#import "AppDelegate.h"

#import <Parse/Parse.h>
#import "OpeningViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Initialize Parse.
    [Parse setApplicationId:@"1KdLz3fYkj1JnT2L8bDhVDyGjEbRY9sv14cjrhqp"
                  clientKey:@"l3fBVwV2wQYQsdGPnx2xQKcoOPwvhbJspEGmVdaa"];
    [PFTwitterUtils initializeWithConsumerKey:@"fdTrgHc7bdcusuUPWIg7QuPDC" consumerSecret:@"iTKAD2ZZmZ3bIs0KJD8jo5g41OSPwKEVmiKKKJ8SynCLNMHvjJ"];
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0.12 green:0.69 blue:0.69 alpha:1];
    tabBarController.tabBar.tintColor = [UIColor whiteColor];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
