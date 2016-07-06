//
//  LoginViewController.m
//  D8
//
//  Created by System Administrator on 6/27/2559 BE.
//  Copyright © 2559 KLover. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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

- (IBAction)onLogin:(id)sender {
    
    NSString *_username = _txtUsername.text;
    NSString *_password = _txtPassword.text;
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // hud.mode = MBProgressHUDModeAnnularDeterminate;
    self.hud.delegate = self;
    self.hud.labelText = @"Loading";
    
    LoginThread *loginThread = [[LoginThread alloc] init];
    [loginThread setCompletionHandler:^(NSString * str) {
        
        //        [ProgressHUD showSuccess:[NSString stringWithFormat:@"Welcome back %@!", user[PF_USER_FULLNAME]]];
        //        [self dismissViewControllerAnimated:YES completion:nil];
        
        NSDictionary *jsonDict= [NSJSONSerialization JSONObjectWithData:str  options:kNilOptions error:nil];
        
        /*
         {"id":"Zye-y9A3mV5mEI4dmMrSXuJ1i82yA5ep_Ii9NRJuMrk","name":"SESSd7da75db715e9ec489582517601f380b"}
         */
        
        
        // http://stackoverflow.com/questions/19206762/equivalent-to-shared-preferences-in-ios
        NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
        
        // const NSInteger currentLevel = ...;
        // [preferences setInteger:currentLevel forKey:currentLevelKey];
        [preferences setObject:[jsonDict objectForKey:@"uid"] forKey:_UID];
        [preferences setObject:[jsonDict objectForKey:@"session_id"] forKey:_SESSION_ID];
        [preferences setObject:[jsonDict objectForKey:@"session_name"] forKey:_SESSION_NAME];
        [preferences setObject:[jsonDict objectForKey:@"user"] forKey:_USER];
        
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
        
        
        NSLog(@"%@", str);
    }];
    [loginThread setErrorHandler:^(NSString * str) {
        NSLog(@"%@", str);
        
        [self.hud hide:YES];
        [self.hud removeFromSuperview];
    }];
    
    [loginThread start:_username :_password];
}
@end
