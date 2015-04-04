//
//  RegistrationViewController.m
//  Questionaire
//
//  Created by Snaheth Thumathy on 4/4/15.
//  Copyright (c) 2015 Snaheth Thumathy. All rights reserved.
//

#import "RegistrationViewController.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Background color.
    self.view.backgroundColor = [UIColor colorWithRed:90/255.0 green:140/255.0 blue:195/255.0 alpha:1.0f];
    
    //App logo.
    UIImage *logoImage = [UIImage imageNamed:@"OpeningPageLogo"];
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - logoImage.size.width/4, 40, logoImage.size.width/2, logoImage.size.height/2)];
    logoView.image = logoImage;
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
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - (300/2),     100.0f, 300, 100)];
    title.attributedText = attrString;
    title.numberOfLines = 1;
    title.textColor = [UIColor whiteColor];
    title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    title.adjustsFontSizeToFitWidth = YES;
    title.clipsToBounds = YES;
    title.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:title];
    
    [self setUpFields];
}

-(void)setUpFields{
    //Username Field
    UITextField *userNameField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 175/2.0, 427/2.0f, 175, 53)];
    [userNameField setDelegate:self];
    userNameField.textColor = [UIColor colorWithRed:167/255.0f green:223/255.0f blue:246/255.0f alpha:1.0f];
    userNameField.borderStyle = UITextBorderStyleNone;
    userNameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:167/255.0f green:223/255.0f blue:246/255.0f alpha:1.0f]}];
    [self.view addSubview:userNameField];
    CAShapeLayer *line = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(userNameField.frame.origin.x - 15, userNameField.frame.origin.y + userNameField.frame.size.height - 10)];
    [path addLineToPoint:CGPointMake(userNameField.frame.origin.x + userNameField.frame.size.width - 15, userNameField.frame.origin.y + userNameField.frame.size.height - 10)];
    [line setPath:path.CGPath];
    [line setLineWidth:1.0f];
    [line setStrokeColor:[UIColor whiteColor].CGColor];
    [line setFillColor:[UIColor whiteColor].CGColor];
    [self.view.layer addSublayer:line];
    
    //Password Field
    UITextField *passwordField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 175/2.0, 532/2.0f, 175, 53)];
    passwordField.secureTextEntry = YES;
    [passwordField setDelegate:self];
    passwordField.textColor = [UIColor colorWithRed:167/255.0f green:223/255.0f blue:246/255.0f alpha:1.0f];
    passwordField.borderStyle = UITextBorderStyleNone;
    passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:167/255.0f green:223/255.0f blue:246/255.0f alpha:1.0f]}];
    [self.view addSubview:passwordField];
    CAShapeLayer *line2 = [CAShapeLayer layer];
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(passwordField.frame.origin.x - 15, passwordField.frame.origin.y + passwordField.frame.size.height - 10)];
    [path2 addLineToPoint:CGPointMake(passwordField.frame.origin.x + passwordField.frame.size.width - 15, passwordField.frame.origin.y + passwordField.frame.size.height - 10)];
    [line2 setPath:path2.CGPath];
    [line2 setLineWidth:1.0f];
    [line2 setStrokeColor:[UIColor whiteColor].CGColor];
    [line2 setFillColor:[UIColor whiteColor].CGColor];
    [self.view.layer addSublayer:line2];

    //Retype Password
    UITextField *passwordFieldAgain = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 175/2.0, 634/2.0f, 175, 53)];
    passwordFieldAgain.secureTextEntry = YES;
    [passwordFieldAgain setDelegate:self];
    passwordFieldAgain.textColor = [UIColor colorWithRed:167/255.0f green:223/255.0f blue:246/255.0f alpha:1.0f];
    passwordFieldAgain.borderStyle = UITextBorderStyleNone;
    passwordFieldAgain.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Retype Password" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:167/255.0f green:223/255.0f blue:246/255.0f alpha:1.0f]}];
    [self.view addSubview:passwordFieldAgain];
    CAShapeLayer *line3 = [CAShapeLayer layer];
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:CGPointMake(passwordFieldAgain.frame.origin.x - 15, passwordFieldAgain.frame.origin.y + passwordFieldAgain.frame.size.height - 10)];
    [path3 addLineToPoint:CGPointMake(passwordFieldAgain.frame.origin.x + passwordFieldAgain.frame.size.width - 15, passwordFieldAgain.frame.origin.y + passwordFieldAgain.frame.size.height - 10)];
    [line3 setPath:path3.CGPath];
    [line3 setLineWidth:1.0f];
    [line3 setStrokeColor:[UIColor whiteColor].CGColor];
    [line3 setFillColor:[UIColor whiteColor].CGColor];
    [self.view.layer addSublayer:line3];
    
    //Email Field
    UITextField *emailField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 175/2.0, 734/2.0f, 175, 53)];
    [emailField setDelegate:self];
    emailField.textColor = [UIColor colorWithRed:167/255.0f green:223/255.0f blue:246/255.0f alpha:1.0f];
    emailField.borderStyle = UITextBorderStyleNone;
    emailField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:167/255.0f green:223/255.0f blue:246/255.0f alpha:1.0f]}];
    [self.view addSubview:emailField];
    CAShapeLayer *line4 = [CAShapeLayer layer];
    UIBezierPath *path4 = [UIBezierPath bezierPath];
    [path4 moveToPoint:CGPointMake(emailField.frame.origin.x - 15, emailField.frame.origin.y + emailField.frame.size.height - 10)];
    [path4 addLineToPoint:CGPointMake(emailField.frame.origin.x + emailField.frame.size.width - 15, emailField.frame.origin.y + emailField.frame.size.height - 10)];
    [line4 setPath:path4.CGPath];
    [line4 setLineWidth:1.0f];
    [line4 setStrokeColor:[UIColor whiteColor].CGColor];
    [line4 setFillColor:[UIColor whiteColor].CGColor];
    [self.view.layer addSublayer:line4];
    
    UIImage *loginImage = [UIImage imageNamed:@"Register"];
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setImage:loginImage forState:UIControlStateNormal];
    [loginButton addTarget:self
                    action:@selector(registerNewPFUser)
          forControlEvents:UIControlEventTouchUpInside];
    [loginButton setFrame: CGRectMake(self.view.frame.size.width/2 - loginImage.size.width/4, 897/2.0, loginImage.size.width/2, loginImage.size.height/2)];
    [self.view addSubview:loginButton];
}

-(void)registerNewPFUser{
    NSLog(@"Register PF User here...");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
