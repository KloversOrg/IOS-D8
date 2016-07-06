//
//  RegisterViewController.h
//  D8
//
//  Created by System Administrator on 6/27/2559 BE.
//  Copyright © 2559 KLover. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface RegisterViewController : UIViewController

@property (nonatomic, strong) MBProgressHUD *hud;

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

- (IBAction)onRegister:(id)sender;

@end
