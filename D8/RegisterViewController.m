//
//  RegisterViewController.m
//  D8
//
//  Created by System Administrator on 6/27/2559 BE.
//  Copyright © 2559 KLover. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterThread.h"

#import "LoginViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)onRegister:(id)sender {
    
    /*
     
     @property (weak, nonatomic) IBOutlet UITextField *txtEmail;
     @property (weak, nonatomic) IBOutlet UITextField *txtUsername;
     @property (weak, nonatomic) IBOutlet UITextField *txtPassword;
     */
    
    NSString *_username = _txtUsername.text;
    NSString *_email = _txtEmail.text;
    NSString *_password = _txtPassword.text;
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // hud.mode = MBProgressHUDModeAnnularDeterminate;
    self.hud.delegate = self;
    self.hud.labelText = @"Loading";
    
    RegisterThread *registerThread = [[RegisterThread alloc] init];
    [registerThread setCompletionHandler:^(NSString * str) {
        
        //        [ProgressHUD showSuccess:[NSString stringWithFormat:@"Welcome back %@!", user[PF_USER_FULLNAME]]];
        //        [self dismissViewControllerAnimated:YES completion:nil];
        
        NSDictionary *jsonDict= [NSJSONSerialization JSONObjectWithData:str  options:kNilOptions error:nil];
        
        
//        [self dismissViewControllerAnimated:YES completion:nil];
        
        UIStoryboard *storybrd = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        LoginViewController *_viewC =[storybrd instantiateViewControllerWithIdentifier:@"LoginViewController"];
                // UIStoryboard *storybrd = [UIStoryboard storyboardWithName:@"Main" bundle:nil];settingsViewController.title = @"Settings";
        
        UINavigationController* _navViewC = [[UINavigationController alloc] initWithRootViewController:_viewC];
        
        [self presentViewController:_navViewC animated:YES completion:nil];
        
        
     /*
        
        // http://stackoverflow.com/questions/19206762/equivalent-to-shared-preferences-in-ios
        NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
        
        // const NSInteger currentLevel = ...;
        // [preferences setInteger:currentLevel forKey:currentLevelKey];
        [preferences setObject:[jsonDict objectForKey:@"uid"] forKey:@"uid"];
        [preferences setObject:[jsonDict objectForKey:@"session_id"] forKey:@"session_id"];
        
        //  Save to disk
        const BOOL didSave = [preferences synchronize];
        
        if (didSave)
        {
            //  Couldn't save (I've never seen this happen in real world testing)
            
            //            UIStoryboard *storybrd = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            //
            //            ViewController *_viewC =[storybrd instantiateViewControllerWithIdentifier:@"ViewController"];
            //            // UIStoryboard *storybrd = [UIStoryboard storyboardWithName:@"Main" bundle:nil];settingsViewController.title = @"Settings";
            //
            //            UINavigationController* _navViewC = [[UINavigationController alloc] initWithRootViewController:_viewC];
            //
            //            [self presentViewController:_navViewC animated:YES completion:nil];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
            [self.hud hide:YES];
            [self.hud removeFromSuperview];
        }
      
      */
        
        [self.hud hide:YES];
        [self.hud removeFromSuperview];
        
        
        NSLog(@"%@", str);
    }];
    [registerThread setErrorHandler:^(NSString * str) {
        NSLog(@"%@", str);
        
        [self.hud hide:YES];
        [self.hud removeFromSuperview];
    }];
    
    // [loginThread start:_username :_password];
    [registerThread start:_username :_password :_email];
    
}
@end
