//
//  ViewController.h
//  D8
//
//  Created by KLover on 6/27/2559 BE.
//  Copyright © 2559 KLover. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "LogoutThread.h"
#import "MBProgressHUD.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) MBProgressHUD *hud;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnLogout;

- (IBAction)onLogout:(id)sender;
- (IBAction)onTest:(id)sender;



@end

