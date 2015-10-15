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

@end

@implementation PingFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    
//    PFQuery *pushQuery = [PFInstallation query];
//    [pushQuery whereKey:@"deviceType" equalTo:@"ios"];
//    
//    // Send push notification to query
//    [PFPush sendPushMessageToQueryInBackground:pushQuery
//                                   withMessage:@"Hello World!"];

    
    PFUser *user = [PFUser currentUser];
    [[PFUser currentUser] setObject:self.enterFriendTextField.text forKey:@"usernameToPing"];
    
    PFInstallation *myinstallation = [PFInstallation currentInstallation];
    [myinstallation setObject:user forKey:@"Owner"];
    
    [myinstallation setObject:user forKey:@"User"];
    [myinstallation saveInBackground];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sendPushNotification
{
    // get the PFUser object for friend
    PFQuery *userQuery=[PFUser query];
    [userQuery whereKey:@"username" equalTo:self.enterFriendTextField.text];
    //here ClientFBId is facebook id of receiver to whom Push Notification is sent
    
    // send push notification to the user
    PFQuery *pushQuery = [PFInstallation query];
    [pushQuery whereKey:@"Owner" matchesQuery:userQuery];
    PFPush *push = [PFPush new];
    [push setQuery: pushQuery];
    NSString *message=[NSString stringWithFormat:@"%@ just blessed you 🙏", [PFUser currentUser].username];
    
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          message, @"alert",
                          @"Increment", @"badge",
                          @"cheering.caf", @"sound",
                          nil];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [PFPush sendPushDataToQuery:pushQuery withData:data error:nil];
    });
    
}
- (IBAction)sendButtonDidPress:(id)sender {
    [self sendPushNotification];
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