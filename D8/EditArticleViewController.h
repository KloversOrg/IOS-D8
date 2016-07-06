//
//  EditArticleViewController.h
//  D8
//
//  Created by System Administrator on 6/28/2559 BE.
//  Copyright © 2559 KLover. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "EditArticleThread.h"

#import "HJManagedImageV.h"
#import "AppDelegate.h"

@interface EditArticleViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate>

@property (nonatomic, strong) MBProgressHUD *hud;

@property (weak, nonatomic) IBOutlet UITextField *txtTitle;
@property (weak, nonatomic) IBOutlet UITextView *txtDetail;

@property (weak, nonatomic) IBOutlet HJManagedImageV *btnImage;

- (IBAction)onSelectImage:(id)sender;
- (IBAction)onSave:(id)sender;

@property (strong, nonatomic) NSString *_nid, *_title, *_body, *_url;

@end
