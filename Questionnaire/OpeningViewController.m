//
//  OpeningViewController.m
//  Questionaire
//
//  Created by Snaheth Thumathy on 4/4/15.
//  Copyright (c) 2015 Snaheth Thumathy. All rights reserved.
//

#import "OpeningViewController.h"

#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "RegistrationViewController.h"

@interface OpeningViewController () <UITextFieldDelegate>

@end

@implementation OpeningViewController
{
    UITextField *userNameField;
    UITextField *passwordField;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasicUI];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - TextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Actions

- (void)normalLogin:(UIButton *)loginButton {
    NSLog(@"Logging in the NORMAL way...");
    [PFUser logInWithUsername:userNameField.text password:passwordField.text];
}

- (void)registerWithoutSocialNetwork {
    [self presentViewController:[[RegistrationViewController alloc] init] animated:YES completion:nil];
    NSLog(@"Registering the NORMAL way...");
   
}

- (void)facebookLogin:(UIButton *)facebookButton {
    NSLog(@"Registering the FACEBOOK way...");
    [PFFacebookUtils logInWithPermissions:@[@"public_profile" , @"email", @"user_friends"] block:^(PFUser *user, NSError *err){
        if(err){
            NSLog(@"Error occured!");
        }
        else{
            NSLog(@"You logged in!");
            if (user) {
                [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                    if (!error) {
                        // Store the current user's Facebook ID on the user
                        [[PFUser currentUser] setObject:[result objectForKey:@"id"]
                                                 forKey:@"fbId"];
                        [[PFUser currentUser] setObject:[result objectForKey:@"name"] forKey:@"name"];
                        [[PFUser currentUser] saveInBackground];
                    }
                }];
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (void)twitterLogin:(UIButton *)twitterButton {
    NSLog(@"Registering the TWITTER way...");
    [PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error) {
        NSLog(@"%@", error);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}


- (void)setupBasicUI{
    //Background color.
    self.view.backgroundColor = [UIColor colorWithRed:90/255.0 green:140/255.0 blue:195/255.0 alpha:1.0f];
    
    //App logo.
    UIImage *logoImage = [UIImage imageNamed:@"OpeningPageLogo"];
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - logoImage.size.width/4, 240, logoImage.size.width/2, logoImage.size.height/2)];
    logoView.image = logoImage;
    logoView.hidden = YES;
    [self.view addSubview:logoView];
    
    //App Title.
    NSString *yourString = @"QuestionnAIRE";
    NSRange boldedRange = NSMakeRange(9, 4);
    NSRange normalRange = NSMakeRange(0,9);
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:yourString];
    [attrString beginEditing];
    [attrString addAttribute:NSFontAttributeName
                       value:[UIFont fontWithName:@"Roboto-Bold" size:55.0f/2]
                       range:boldedRange];
    [attrString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Roboto-Regular" size:55.0f/2] range:normalRange];
    [attrString endEditing];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - (317/2),     125.0f, 317, 75)];
    title.attributedText = attrString;
    title.numberOfLines = 1;
    title.textColor = [UIColor whiteColor];
    title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    title.adjustsFontSizeToFitWidth = YES;
    title.clipsToBounds = YES;
    title.textAlignment = NSTextAlignmentCenter;
    title.hidden = YES;
    [self.view addSubview:title];
    
    //Username Field
    userNameField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 175/2.0, 427/2.0f, 175, 53)];
    [userNameField setDelegate:self];
    userNameField.textColor = [UIColor colorWithRed:167/255.0f green:223/255.0f blue:246/255.0f alpha:1.0f];
    userNameField.borderStyle = UITextBorderStyleNone;
    userNameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:167/255.0f green:223/255.0f blue:246/255.0f alpha:1.0f]}];
    userNameField.hidden = YES;
    [self.view addSubview:userNameField];
    CAShapeLayer *line = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(userNameField.frame.origin.x - 15, userNameField.frame.origin.y + userNameField.frame.size.height - 10)];
    [path addLineToPoint:CGPointMake(userNameField.frame.origin.x + userNameField.frame.size.width - 15, userNameField.frame.origin.y + userNameField.frame.size.height - 10)];
    [line setPath:path.CGPath];
    [line setLineWidth:1.0f];
    [line setStrokeColor:[UIColor whiteColor].CGColor];
    [line setFillColor:[UIColor whiteColor].CGColor];
    line.hidden = YES;
    [self.view.layer addSublayer:line];
    
    //Password Field
    passwordField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 175/2.0, 532/2.0f, 175, 53)];
    passwordField.secureTextEntry = YES;
    [passwordField setDelegate:self];
    passwordField.textColor = [UIColor colorWithRed:167/255.0f green:223/255.0f blue:246/255.0f alpha:1.0f];
    passwordField.borderStyle = UITextBorderStyleNone;
    passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:167/255.0f green:223/255.0f blue:246/255.0f alpha:1.0f]}];
    passwordField.hidden = YES;
    [self.view addSubview:passwordField];
    
    CAShapeLayer *line2 = [CAShapeLayer layer];
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(passwordField.frame.origin.x - 15, passwordField.frame.origin.y + passwordField.frame.size.height - 10)];
    [path2 addLineToPoint:CGPointMake(passwordField.frame.origin.x + passwordField.frame.size.width - 15, passwordField.frame.origin.y + passwordField.frame.size.height - 10)];
    [line2 setPath:path2.CGPath];
    [line2 setLineWidth:1.0f];
    [line2 setStrokeColor:[UIColor whiteColor].CGColor];
    [line2 setFillColor:[UIColor whiteColor].CGColor];
    line2.hidden = YES;
    [self.view.layer addSublayer:line2];
    
    
    //Cloud One
    UIImage *cloudOneImg = [UIImage imageNamed:@"CloudOne"];
    UIImageView *cloudOne = [[UIImageView alloc] initWithFrame:CGRectMake(-150, 50.0f, cloudOneImg.size.width/2, cloudOneImg.size.height/2)];
    cloudOne.image = cloudOneImg;
    [self.view addSubview:cloudOne];
    
    //Cloud Two
    UIImage *cloudTwoImg = [UIImage imageNamed:@"CloudTwo"];
    UIImageView *cloudTwo = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width + 150, 50.0f, cloudTwoImg.size.width/2, cloudTwoImg.size.height/2)];
    cloudTwo.image = cloudTwoImg;
    [self.view addSubview:cloudTwo];
    
    //Cloud Animation.
    [UIView setAnimationsEnabled:YES];
    [UIView animateWithDuration:0.00f delay:0.00f options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        cloudOne.frame = CGRectMake(-150, CGRectGetMaxY(logoView.frame) - 60.0f, cloudOneImg.size.width/2, cloudOneImg.size.height/2);
        cloudTwo.frame = CGRectMake(self.view.frame.size.width + 150, CGRectGetMaxY(logoView.frame) - 60.0f, cloudTwoImg.size.width/2, cloudTwoImg.size.height/2);
    }completion:^(BOOL done){
        [UIView animateWithDuration:1.5f delay:0.0f options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            cloudOne.frame = CGRectMake(-20, CGRectGetMaxY(logoView.frame) - 60.0f, cloudOneImg.size.width/2, cloudOneImg.size.height/2);
            cloudTwo.frame = CGRectMake(self.view.frame.size.width - 100, CGRectGetMaxY(logoView.frame) - 60.0f, cloudTwoImg.size.width/2, cloudTwoImg.size.height/2);
        }completion:^(BOOL done){
            //Actually done....
        }];
    }];
    
    //Normal Login
    UIImage *loginImage = [UIImage imageNamed:@"Login"];
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setImage:loginImage forState:UIControlStateNormal];
    [loginButton addTarget:self
                    action:@selector(normalLogin:)
          forControlEvents:UIControlEventTouchUpInside];
    [loginButton setFrame: CGRectMake(self.view.frame.size.width/2 - loginImage.size.width/4, 753/2.0, loginImage.size.width/2, loginImage.size.height/2)];
    loginButton.hidden = YES;
    [self.view addSubview:loginButton];
    
    //Facebook Login
    UIImage *facebookImage = [UIImage imageNamed:@"FacebookLogin"];
    UIButton *facebookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [facebookButton setImage:facebookImage forState:UIControlStateNormal];
    [facebookButton addTarget:self
                       action:@selector(facebookLogin:)
             forControlEvents:UIControlEventTouchUpInside];
    [facebookButton setFrame: CGRectMake(self.view.frame.size.width/2 - facebookImage.size.width/4, 994/2.0, facebookImage.size.width/2, facebookImage.size.height/2)];
    facebookButton.hidden = YES;
    [self.view addSubview:facebookButton];
    
    //Twitter Login
    UIImage *twitterImage = [UIImage imageNamed:@"TwitterLogin"];
    UIButton *twitterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [twitterButton setImage:twitterImage forState:UIControlStateNormal];
    [twitterButton addTarget:self
                      action:@selector(twitterLogin:)
            forControlEvents:UIControlEventTouchUpInside];
    [twitterButton setFrame: CGRectMake(self.view.frame.size.width/2 - twitterImage.size.width/4, 873/2.0, twitterImage.size.width/2, twitterImage.size.height/2)];
    twitterButton.hidden = YES;
    [self.view addSubview:twitterButton];
    
    //Register Button.
    NSString *originalStr = @"New user? Click me or choose:";
    NSRange underlinedRange = NSMakeRange(16, 2);
    NSMutableAttributedString *specificRegisterStr = [[NSMutableAttributedString alloc] initWithString:originalStr];
    [specificRegisterStr beginEditing];
    [specificRegisterStr addAttributes:@{
                                         NSUnderlineColorAttributeName : [UIColor whiteColor],
                                         NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid)
                                         }
                                 range:underlinedRange];
    [specificRegisterStr endEditing];
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.titleLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:30.0f/2];
    registerButton.titleLabel.textColor = [UIColor whiteColor];
    [registerButton setAttributedTitle:specificRegisterStr forState:UIControlStateNormal];
    [registerButton addTarget:self
                       action:@selector(registerWithoutSocialNetwork)
             forControlEvents:UIControlEventTouchUpInside];
    registerButton.titleLabel.numberOfLines = 2;
    [registerButton setFrame: CGRectMake(self.view.frame.size.width/2 - (316/2.0), 320, 316, 40)];
    registerButton.hidden = YES;
    [self.view addSubview:registerButton];
    
    
    
    [UIView animateWithDuration:0.01f animations:^{
        
    }completion:^(BOOL done){
        [UIView animateWithDuration:1.5f animations:^{
            logoView.hidden = NO;
            logoView.frame = CGRectMake(self.view.frame.size.width/2 - logoImage.size.width/4, 60, logoImage.size.width/2, logoImage.size.height/2);
        }completion:^(BOOL done){
            title.hidden = NO;
            userNameField.hidden = NO;
            line.hidden = NO;
            passwordField.hidden = NO;
            line2.hidden = NO;
            registerButton.hidden = NO;
            loginButton.hidden = NO;
            facebookButton.hidden = NO;
            twitterButton.hidden = NO;
        }];
    }];
}

@end
