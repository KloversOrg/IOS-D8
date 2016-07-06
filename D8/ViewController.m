//
//  ViewController.m
//  D8
//
//  Created by KLover on 6/27/2559 BE.
//  Copyright © 2559 KLover. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "AppConstant.h"

#import "DevicePushNotificationThread.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *uniqueIdentifierDevice = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *nameDevice = [[UIDevice currentDevice] name];
    NSString *modelDevice = [[UIDevice currentDevice] model];
    NSString *systemVersionDevice = [[UIDevice currentDevice] systemVersion];
    
    NSLog(@"%@-%@-%@-%@", uniqueIdentifierDevice, nameDevice, modelDevice, systemVersionDevice);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{

    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    if ([preferences objectForKey:_UID] == nil && [preferences objectForKey:_SESSION_ID] == nil)
    {
        [self.btnLogout setEnabled:NO];
        [self.btnLogout setTintColor: [UIColor clearColor]];
    }else{
        //  Get current level
        NSString* vid = [preferences objectForKey:_UID];
        NSString* vname = [preferences objectForKey:_SESSION_ID];
        
        [self.btnLogout setEnabled:YES];
        [self.btnLogout setTintColor:nil];
    }
}

- (IBAction)onLogout:(id)sender {
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // hud.mode = MBProgressHUDModeAnnularDeterminate;
    self.hud.delegate = self;
    self.hud.labelText = @"Loading";
    
    LogoutThread *logoutThread = [[LogoutThread alloc] init];
    [logoutThread setCompletionHandler:^(NSString * str) {
        
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
        [preferences setObject:nil forKey:_UID];
        [preferences setObject:nil forKey:_SESSION_ID];
        [preferences setObject:nil forKey:_SESSION_NAME];
        [preferences setObject:nil forKey:_USER];

        
        //  Save to disk
        const BOOL didSave = [preferences synchronize];
        
        if (didSave)
        {
            //  Couldn't save (I've never seen this happen in real world testing)
            
            UIStoryboard *storybrd = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            LoginViewController *_loginViewC =[storybrd instantiateViewControllerWithIdentifier:@"LoginViewController"];
            // UIStoryboard *storybrd = [UIStoryboard storyboardWithName:@"Main" bundle:nil];settingsViewController.title = @"Settings";
            
            UINavigationController* _navViewC = [[UINavigationController alloc] initWithRootViewController:_loginViewC];
            
            [self presentViewController:_navViewC animated:YES completion:nil];
            
            [self.hud hide:YES];
            [self.hud removeFromSuperview];
        }
        
        
        NSLog(@"%@", str);
    }];
    [logoutThread setErrorHandler:^(NSString * str) {
        NSLog(@"%@", str);
        
        [self.hud hide:YES];
        [self.hud removeFromSuperview];
    }];
    
    [logoutThread start];
}

- (IBAction)onTest:(id)sender {
    
    
    DevicePushNotificationThread *devicePushNotificationThread = [[DevicePushNotificationThread alloc] init];
    [devicePushNotificationThread setCompletionHandler:^(NSString * str) {
        
        //        [ProgressHUD showSuccess:[NSString stringWithFormat:@"Welcome back %@!", user[PF_USER_FULLNAME]]];
        //        [self dismissViewControllerAnimated:YES completion:nil];
        
        NSDictionary *jsonDict= [NSJSONSerialization JSONObjectWithData:str  options:kNilOptions error:nil];
        
        
        NSLog(@"%@", jsonDict);
    }];
    [devicePushNotificationThread setErrorHandler:^(NSString * str) {
        NSLog(@"%@", str);
        
        [self.hud hide:YES];
        [self.hud removeFromSuperview];
    }];
    
    [devicePushNotificationThread start:@"#3"];
}
@end
