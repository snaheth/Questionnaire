//
//  ProfileViewController.m
//  Questionnaire


#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:84/255.0f green:131/255.0f blue:143/255.0f alpha:1.0f];
    
    UITableView *tbv = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width,  self.view.frame.size.height/2) style:UITableViewStylePlain];
    tbv.backgroundColor = [UIColor colorWithRed:70/255.0f green:128/255.0f blue:143/255.0f alpha:1.0f];
    tbv.delegate = self;
    tbv.dataSource = self;
    [self.view addSubview:tbv];
    
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(110, 80, 250, 60)];
    name.numberOfLines = 1;
    name.font = [UIFont fontWithName:@"Lato-Bold" size:15.0f];
    name.textColor = [UIColor colorWithRed:185/255.0f green:235/255.0f blue:236/255.0f alpha:1.0f];
    name.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    name.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:name];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(110, 113, 250, 60)];
    title.text = [@"Dragonslayer" uppercaseString];
    title.font = [UIFont fontWithName:@"Lato-Bold" size:15.0f];
    title.numberOfLines = 1;
    title.textColor = [UIColor colorWithRed:185/255.0f green:235/255.0f blue:236/255.0f alpha:1.0f];
    title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    title.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:title];
    
    UILabel *score = [[UILabel alloc] initWithFrame:CGRectMake(110, 146, 250, 60)];
    score.text = [@"+50" uppercaseString];
    score.font = [UIFont fontWithName:@"Lato-Bold" size:15.0f];
    score.numberOfLines = 1;
    score.textColor = [UIColor colorWithRed:185/255.0f green:235/255.0f blue:236/255.0f alpha:1.0f];
    score.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    score.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:score];
    
    UIView *blockView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2 - 85.0f/2, self.view.frame.size.width, 85.0f/2)];
    blockView.backgroundColor = [UIColor colorWithRed:153/255.0f green:205/255.0f blue:219/255.0f alpha:1.0f];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(blockView.frame.size.width/2 - 100, blockView.frame.size.height/2 - 85/4.0, 200, 85.0f/2)];
    label.text = [@"Your Questions" uppercaseString];
    label.font = [UIFont fontWithName:@"Lato-Bold" size:15.0f];
    label.numberOfLines = 1;
    label.textColor = [UIColor colorWithRed:70/255.0f green:106/255.0f blue:115/255.0f alpha:1.0f];
    label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    label.textAlignment = NSTextAlignmentCenter;
    [blockView addSubview:label];
    [self.view addSubview:blockView];
    
    
    [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *FBuser, NSError *error) {
        if (error) {
            NSLog(@"Error getting profile pic.");
        }
        else {
            NSString *userName = [FBuser name];
            name.text = [userName uppercaseString];
            name.font = [UIFont fontWithName:@"Roboto-Bold" size:15.0f];
            
            UIImageView *profPicView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 113, 70, 70)];
            NSString *userImageURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [FBuser objectID]];
            NSURL *url = [NSURL URLWithString: userImageURL];
            NSData *profPicData = [NSData dataWithContentsOfURL:url];
            UIImage *profPic = [UIImage imageWithData:profPicData];
            profPicView.image = profPic;
            profPicView.layer.cornerRadius = 35.0f;
            profPicView.layer.borderWidth = 5.0f;
            profPicView.layer.borderColor = [UIColor colorWithRed:185/255.0f green:235/255.0f blue:236/255.0f alpha:1.0f].CGColor;
            profPicView.layer.masksToBounds = YES;
            profPicView.clipsToBounds = YES;
            [self.view addSubview:profPicView];
        }
    }];
    
    self.navigationItem.title = @"Profile";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
