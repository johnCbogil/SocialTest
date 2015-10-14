//
//  LogInViewController.m
//  SocialTest
//
//  Created by John Bogil on 10/13/15.
//  Copyright © 2015 John Bogil. All rights reserved.
//

#import "LogInViewController.h"
#import <Parse/Parse.h>

@interface LogInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitButtonDidPress:(id)sender {
    [PFUser logInWithUsernameInBackground:self.usernameTextField.text password:self.passwordTextField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            NSLog(@"login successful");
                                            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                            UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"BlessViewController"];
                                            [self.navigationController pushViewController:vc animated:YES];
                                        } else {
                                            NSLog(@"login NOT successful");
                                            UIAlertController *signUpAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"login NOT successful" preferredStyle:UIAlertControllerStyleAlert];
                                            UIAlertAction *okAction = [UIAlertAction
                                                                       actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                                                       style:UIAlertActionStyleDefault
                                                                       handler:^(UIAlertAction *action)
                                                                       {
                                                                           NSLog(@"OK action");
                                                                       }];
                                            [signUpAlert addAction:okAction];
                                            [self presentViewController:signUpAlert animated:YES completion:nil];}
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
