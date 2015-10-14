//
//  SignUpViewController.m
//  SocialTest
//
//  Created by John Bogil on 10/13/15.
//  Copyright © 2015 John Bogil. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *createUsernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *createPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitButtonDidPress:(id)sender {
    //    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    //    testObject[@"foo"] = @"bar";
    //    [testObject saveInBackground];
    
    PFUser *user = [PFUser user];
    user.username = self.createUsernameTextField.text;
    user.password = self.createPasswordTextField.text;
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {   // Hooray! Let them use the app now.
        }
        else {
            NSString *errorString = [error userInfo][@"error"];
            UIAlertController *signUpAlert = [UIAlertController alertControllerWithTitle:@"Error" message:errorString preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"OK action");
                                       }];
            [signUpAlert addAction:okAction];
            [self presentViewController:signUpAlert animated:YES completion:nil];
        }
    }];
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
