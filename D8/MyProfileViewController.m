//
//  MyProfileViewController.m
//  D8
//
//  Created by System Administrator on 6/29/2559 BE.
//  Copyright © 2559 KLover. All rights reserved.
//

#import "MyProfileViewController.h"
#import "AppConstant.h"

@interface MyProfileViewController ()

@end

@implementation MyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
     
     
     
     if ([preferences objectForKey:_UID] == nil && [preferences objectForKey:_SESSION_ID] == nil)
     {
     [self.btnLogout setEnabled:NO];
     [self.btnLogout setTintColor: [UIColor clearColor]];
     }
     else
     {
     //  Get current level
     NSString* vid = [preferences objectForKey:_UID];
     NSString* vname = [preferences objectForKey:_SESSION_ID];
     
     [self.btnLogout setEnabled:YES];
     [self.btnLogout setTintColor:nil];
     }
     
     @property (weak, nonatomic) IBOutlet HJManagedImageV *image_profile;
     @property (weak, nonatomic) IBOutlet UILabel *label_name;
     @property (weak, nonatomic) IBOutlet UILabel *label_email;
     */
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    
    [self.label_name setText:[[preferences objectForKey:_USER] objectForKey:@"name"]];
    [self.label_email setText:[[preferences objectForKey:_USER] objectForKey:@"mail"]];
    
    NSLog(@"%@", [[preferences objectForKey:_USER] objectForKey:@"url_image"]);
    
    [self.image_profile clear];
    [self.image_profile  showLoadingWheel];
    [self.image_profile  setUrl:[NSURL URLWithString:[[preferences objectForKey:_USER] objectForKey:@"url_image"]]];
    [[(AppDelegate*)[[UIApplication sharedApplication] delegate] obj_Manager ] manage:self.image_profile ];
    
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

@end
