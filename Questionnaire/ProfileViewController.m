//
//  ProfileViewController.m
//  Questionnaire


#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "QuestionTableViewCell.h"

@interface ProfileViewController ()
@property UILabel *scoreLabel;
@end

@implementation ProfileViewController
{
    NSArray *myQuestions;
    UIView *headerView;
    UIImageView *profPicView;
    UILabel *nameLabel;
}
@synthesize scoreLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:84/255.0f green:131/255.0f blue:143/255.0f alpha:1.0f];

    headerView = [[UIView alloc] init];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:70/255.0f green:128/255.0f blue:143/255.0f alpha:1.0f];
    
    headerView.backgroundColor = self.tableView.backgroundColor;
    
    scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 146, 250, 60)];
    [[PFUser currentUser] fetch];
    NSNumber *scoreVal = [PFUser currentUser][@"score"];
    NSInteger aVal = [scoreVal integerValue];
    NSLog(@"OUR INITIAL SCORE IS: %d" , aVal);
    NSString *scoreStr = @"+";
    scoreStr = [NSString stringWithFormat:@"%@%@" , scoreStr, scoreVal];
    scoreLabel.text = scoreStr;
    scoreLabel.font = [UIFont fontWithName:@"Lato-Bold" size:15.0f];
    scoreLabel.numberOfLines = 1;
    scoreLabel.textColor = [UIColor colorWithRed:185/255.0f green:235/255.0f blue:236/255.0f alpha:1.0f];
    scoreLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    scoreLabel.textAlignment = NSTextAlignmentLeft;
    scoreLabel.translatesAutoresizingMaskIntoConstraints = false;
    [headerView addSubview:scoreLabel];
    
    
    nameLabel = [[UILabel alloc] init];
    nameLabel.numberOfLines = 1;
    nameLabel.text = @"Snaheth Thumathy";
    nameLabel.font = [UIFont fontWithName:@"Lato-Bold" size:15.0f];
    nameLabel.textColor = [UIColor colorWithRed:185/255.0f green:235/255.0f blue:236/255.0f alpha:1.0f];
    nameLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.translatesAutoresizingMaskIntoConstraints = false;
    [headerView addSubview:nameLabel];
    
    
    profPicView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Person"]];
    profPicView.layer.cornerRadius = 35.0f;
    profPicView.layer.borderWidth = 5.0f;
    profPicView.layer.borderColor = [UIColor colorWithRed:185/255.0f green:235/255.0f blue:236/255.0f alpha:1.0f].CGColor;
    profPicView.layer.masksToBounds = YES;
    profPicView.clipsToBounds = YES;
    profPicView.translatesAutoresizingMaskIntoConstraints = NO;
    [headerView addSubview:profPicView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = [[PFUser currentUser][@"status"] uppercaseString];
    NSLog(@"STATUS: %@" , titleLabel.text);
    titleLabel.font = [UIFont fontWithName:@"Lato-Bold" size:15.0f];
    titleLabel.numberOfLines = 1;
    titleLabel.textColor = [UIColor colorWithRed:185/255.0f green:235/255.0f blue:236/255.0f alpha:1.0f];
    titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [headerView addSubview:titleLabel];
    
    
    
    UIView *blockView = [[UIView alloc] init];
    blockView.backgroundColor = [UIColor colorWithRed:153/255.0f green:205/255.0f blue:219/255.0f alpha:1.0f];
    blockView.translatesAutoresizingMaskIntoConstraints = false;
    [headerView addSubview:blockView];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = [@"Your Questions" uppercaseString];
    label.font = [UIFont fontWithName:@"Lato-Bold" size:15.0f];
    label.numberOfLines = 1;
    label.textColor = [UIColor colorWithRed:70/255.0f green:106/255.0f blue:115/255.0f alpha:1.0f];
    label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    label.translatesAutoresizingMaskIntoConstraints = false;
    [blockView addSubview:label];
    
    [blockView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[label]|" options:0 metrics:nil views:@{@"label": label}]];
    [blockView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label]|" options:0 metrics:nil views:@{@"label": label}]];
    
    // Constraints
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    NSDictionary *views = @{
                            @"nameLabel": nameLabel,
                            @"titleLabel": titleLabel,
                            @"scoreLabel": scoreLabel,
                            @"blockView": blockView,
                            @"profPicView" : profPicView
                            };
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[profPicView(70)]|" options:0 metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[profPicView]-[nameLabel]|" options:0 metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[profPicView]-[titleLabel]|" options:0 metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[profPicView]-[scoreLabel]|" options:0 metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[blockView]|" options:0 metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[nameLabel(24)][titleLabel(24)][scoreLabel(24)]-[blockView(44)]|" options:0 metrics:nil views:views]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:profPicView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:headerView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-22.0f]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[profPicView(70)]" options:0 metrics:nil views:views]];
    [headerView addConstraints:constraints];
    //Add the questions.
    myQuestions = @[];
    if([[FBSession activeSession] isOpen]){
        NSLog(@"You're good with active FBSession!");
    }
    else{
        [FBSession openActiveSessionWithPublishPermissions:[NSArray arrayWithObject:@"publish_actions"]
                                           defaultAudience:FBSessionDefaultAudienceOnlyMe
                                              allowLoginUI:YES
                                         completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                                             if (!error && status == FBSessionStateOpen) {
                                                 NSLog(@"No error. Status is state open.");
                                             }else{
                                                 NSLog(@"error");
                                             }
                                         }];
    }
    
    FBRequest *myReq = [FBRequest requestForMe];
    [myReq startWithCompletionHandler:^(FBRequestConnection *connect, id result, NSError *err){
        if(!err){
            }
        else{
            NSLog(@"An error occured with getting facebook friend data!");
        }
    }];
    self.navigationItem.title = @"Profile";
    
    [self.tableView registerClass:[QuestionTableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Question"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *arr, NSError *err){
        if(!err){
            myQuestions = arr;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        else{
            NSLog(@"Error getting questions.");
        }
    }];
    
    [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *FBuser, NSError *error) {
        if (error) {
            NSLog(@"Error getting profile pic.");
        }
        else {
            NSString *userName = [FBuser name];
            nameLabel.text = [userName uppercaseString];
            nameLabel.font = [UIFont fontWithName:@"Roboto-Bold" size:15.0f];
        
            //WithFrame:CGRectMake(self.view.frame.size.width - 90, 10, 70, 70)
            NSString *userImageURL = [NSString stringWithFormat:@"https:graph.facebook.com/%@/picture?type=large", [FBuser objectID]];
            NSURL *url = [NSURL URLWithString: userImageURL];
            NSData *profPicData = [NSData dataWithContentsOfURL:url];
            UIImage *profPic = [UIImage imageWithData:profPicData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                profPicView.image = profPic;
                //profPicView.frame = CGRectMake(self.view.frame.size.width - 90, 10, 70, 70);
            });
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [myQuestions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    PFObject *question = myQuestions[indexPath.row];
    cell.questionPreviewLabel.text = [question objectForKey:@"text"];
    cell.userTitleLabel.text = @"Knowledge King";
    cell.commentsLabel.text = @"Comments (0)";
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 132;
}

@end
