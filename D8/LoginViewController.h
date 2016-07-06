//
//  LoginViewController.h
//  D8
//
//  Created by System Administrator on 6/27/2559 BE.
//  Copyright © 2559 KLover. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginThread.h"
#import "MBProgressHUD.h"

#import "AppConstant.h"

@interface LoginViewController : UIViewController

@property (nonatomic, strong) MBProgressHUD *hud;

@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
- (IBAction)onLogin:(id)sender;

@end
