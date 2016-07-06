//
//  EditArticleViewController.m
//  D8
//
//  Created by System Administrator on 6/28/2559 BE.
//  Copyright © 2559 KLover. All rights reserved.
//

#import "EditArticleViewController.h"
#import "LoginViewController.h"
#import "AppConstant.h"

@interface EditArticleViewController ()

@end

@implementation EditArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%@", self._nid);
    NSLog(@"%@", self._title);
    NSLog(@"%@", self._body);
    NSLog(@"%@", self._url);
    NSLog(@"");
    
    [self.txtTitle setText:self._title];
    
    if (self._body != [NSNull null]){
        [self.txtDetail setText:self._body];
    }else{
        [self.txtDetail setText:@""];
    }

    [self.btnImage clear];
    [self.btnImage showLoadingWheel];
    [self.btnImage setUrl:self._url];
    
    UITapGestureRecognizer *tapped =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSelectImage:)];
//    headerTableView.tag = section;
    // [headerTableView addGestureRecognizer:sectionHeaderTapped];
    [self.btnImage setUserInteractionEnabled:YES];
    [self.btnImage addGestureRecognizer:tapped];
    [[(AppDelegate*)[[UIApplication sharedApplication] delegate] obj_Manager ] manage:self.btnImage];
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

- (IBAction)onSelectImage:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    
    //    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //        UIPopoverController *popoverController=[[UIPopoverController alloc] initWithContentViewController:picker];
    //        popoverController.delegate=self;
    //        [popoverController presentPopoverFromRect:headerView.photoImageView.bounds inView:headerView.photoImageView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    //    }else{
    [self presentViewController:picker animated:NO completion:NULL];
    //    }
}

- (IBAction)onSave:(id)sender {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    if ([preferences objectForKey:_UID] == nil && [preferences objectForKey:_SESSION_ID] == nil)
    {
        UIStoryboard *storybrd = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *_viewC =[storybrd instantiateViewControllerWithIdentifier:@"LoginViewController"];
        
        UINavigationController* _navViewC = [[UINavigationController alloc] initWithRootViewController:_viewC];
        
        [self presentViewController:_navViewC animated:YES completion:nil];
    }else{
        
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        // hud.mode = MBProgressHUDModeAnnularDeterminate;
        self.hud.delegate = self;
        self.hud.labelText = @"Loading";
        
        
        NSString *_title = [self.txtTitle text];
        NSString *_detail = [self.txtDetail text];
        
        // UIImage *img = [self.btnImage imageForState:UIControlStateNormal];
        
        UIImage *img = [self.btnImage image];
        
        EditArticleThread *addArticleThread = [[EditArticleThread alloc] init];
        [addArticleThread setCompletionHandler:^(NSString * str) {
            
            //        [ProgressHUD showSuccess:[NSString stringWithFormat:@"Welcome back %@!", user[PF_USER_FULLNAME]]];
            //        [self dismissViewControllerAnimated:YES completion:nil];
            
            NSDictionary *jsonDict= [NSJSONSerialization JSONObjectWithData:str  options:kNilOptions error:nil];
            
            [self.hud hide:YES];
            [self.hud removeFromSuperview];
            
            // [self dismissViewControllerAnimated:YES completion:nil];
            // [self.navigationController pushViewController:editArticleViewController animated:YES];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            NSLog(@"%@", str);
        }];
        [addArticleThread setErrorHandler:^(NSString * str) {
            NSLog(@"%@", str);
            
            [self.hud hide:YES];
            [self.hud removeFromSuperview];
            
        }];
        
        // [addArticleThread start:[[[user valueForKey:@"uid"] objectAtIndex:0] valueForKey:@"value"] : self._nid :_title :_detail :img];
        
        [addArticleThread start:[preferences objectForKey:_UID] : self._nid :_title :_detail :img];
        
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // [self.btnImage setImage:info[UIImagePickerControllerEditedImage] forState:UIControlStateNormal];
    
    [self.btnImage clear];
    [self.btnImage showLoadingWheel];
    [self.btnImage setImage:info[UIImagePickerControllerEditedImage]];
    [[(AppDelegate*)[[UIApplication sharedApplication] delegate] obj_Manager ] manage:self.btnImage];
    
    [picker dismissViewControllerAnimated:NO completion:nil];
}

@end
