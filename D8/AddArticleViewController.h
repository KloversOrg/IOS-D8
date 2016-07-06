//
//  AddArticleViewController.h
//  D8
//
//  Created by System Administrator on 6/28/2559 BE.
//  Copyright © 2559 KLover. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"


@interface AddArticleViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate>

@property (nonatomic, strong) MBProgressHUD *hud;

@property (weak, nonatomic) IBOutlet UITextField *txtTitle;
@property (weak, nonatomic) IBOutlet UITextView *txtDetail;

@property (weak, nonatomic) IBOutlet UIButton *btnImage;


- (IBAction)onSelectImage:(id)sender;
- (IBAction)onSave:(id)sender;
@end
