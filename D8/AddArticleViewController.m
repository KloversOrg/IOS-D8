//
//  AddArticleViewController.m
//  D8
//
//  Created by System Administrator on 6/28/2559 BE.
//  Copyright © 2559 KLover. All rights reserved.
//

#import "AddArticleViewController.h"
#import "LoginViewController.h"

#import "AddArticleThread.h"

@interface AddArticleViewController ()

@end

@implementation AddArticleViewController

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
        
        UIImage *img = [self.btnImage imageForState:UIControlStateNormal];
        
        
        AddArticleThread *addArticleThread = [[AddArticleThread alloc] init];
        [addArticleThread setCompletionHandler:^(NSString * str) {
            
            //        [ProgressHUD showSuccess:[NSString stringWithFormat:@"Welcome back %@!", user[PF_USER_FULLNAME]]];
            //        [self dismissViewControllerAnimated:YES completion:nil];
            
            NSDictionary *jsonDict= [NSJSONSerialization JSONObjectWithData:str  options:kNilOptions error:nil];
         
            
            /*
            
            
            //            // http://stackoverflow.com/questions/19206762/equivalent-to-shared-preferences-in-ios
            //            NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
            //
            //            // const NSInteger currentLevel = ...;
            //            // [preferences setInteger:currentLevel forKey:currentLevelKey];
            //            [preferences setObject:[jsonDict objectForKey:@"id"] forKey:@"id"];
            //            [preferences setObject:[jsonDict objectForKey:@"name"] forKey:@"name"];
            //
            //            //  Save to disk
            //            const BOOL didSave = [preferences synchronize];
            //
            //            if (didSave)
            //            {
            //                //  Couldn't save (I've never seen this happen in real world testing)
            //
            //                UIStoryboard *storybrd = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            //
            //                ViewController *_viewC =[storybrd instantiateViewControllerWithIdentifier:@"ViewController"];
            //                // UIStoryboard *storybrd = [UIStoryboard storyboardWithName:@"Main" bundle:nil];settingsViewController.title = @"Settings";
            //
            //                UINavigationController* _navViewC = [[UINavigationController alloc] initWithRootViewController:_viewC];
            //
            //                [self presentViewController:_navViewC animated:YES completion:nil];
            //
            //                [self.hud hide:YES];
            //                [self.hud removeFromSuperview];
            //            }
            
            if ([jsonDict objectForKey:@"result"]) {
                NSLog(@"");
                
                if ([[jsonDict objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                    _data =  [jsonDict objectForKey:@"data"];
                    
                    [self._table reloadData];
                }
            }else{
                NSLog(@"%@", str);
            }
            
            [self._table setHidden:NO];
            
            [self.spinner stopAnimating];
            [self.spinner removeFromSuperview];
         
            */
            
            [self.hud hide:YES];
            [self.hud removeFromSuperview];
            
            // [self dismissViewControllerAnimated:YES completion:nil];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            NSLog(@"%@", str);
        }];
        [addArticleThread setErrorHandler:^(NSString * str) {
            NSLog(@"%@", str);
            
            [self.hud hide:YES];
            [self.hud removeFromSuperview];
            
        }];
        
        [addArticleThread start:[preferences objectForKey:_UID] :_title :_detail :img];
     

        
       //  NSLog(@"%@-%@", _title, _detail);
    
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self.btnImage setImage:info[UIImagePickerControllerEditedImage] forState:UIControlStateNormal];
    
    [picker dismissViewControllerAnimated:NO completion:nil];
}
@end
