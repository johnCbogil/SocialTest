//
//  PingFriendViewController.m
//  SocialTest
//
//  Created by John Bogil on 10/14/15.
//  Copyright © 2015 John Bogil. All rights reserved.
//

#import "PingFriendViewController.h"
#import <Parse/Parse.h>

@interface PingFriendViewController ()
@property (weak, nonatomic) IBOutlet UILabel *pingFriendLabel;
@property (weak, nonatomic) IBOutlet UITextField *enterFriendTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@end

@implementation PingFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PFInstallation *installation = [PFInstallation currentInstallation];

    // Associate the device with a user
    if (installation[@"user"]) {
    }
    else {
        //save it like this
        installation[@"user"] = [PFUser currentUser];
        [installation saveInBackground];    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sendPushNotification
{
    // Create a user query with the entered text
    PFQuery *userQuery = [PFUser query];
    [userQuery whereKey:@"username" equalTo:self.enterFriendTextField.text];
    
    NSLog(@"cnt=%ld", (long)userQuery.countObjects);

    // Find devices associated with these users
    PFQuery *pushQuery = [PFInstallation query];
    [pushQuery whereKey:@"user" matchesQuery:userQuery];
    
    // Send push notification to query
    PFPush *push = [[PFPush alloc] init];
    [push setQuery:pushQuery]; // Set our Installation query
    [push setMessage:[NSString stringWithFormat:@"%@ just blessed you 🙏", [PFUser currentUser].username]];
    [push sendPushInBackground];
}
- (IBAction)sendButtonDidPress:(id)sender {
    [self sendPushNotification];
}
- (IBAction)logoutButtonDidPress:(id)sender {
    [PFUser logOut];
//    PFUser *currentUser = [PFUser currentUser]; // this will now be nil
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];

    
    [self presentViewController:viewController animated:YES completion:nil];
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