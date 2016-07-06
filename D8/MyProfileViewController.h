//
//  MyProfileViewController.h
//  D8
//
//  Created by System Administrator on 6/29/2559 BE.
//  Copyright © 2559 KLover. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJManagedImageV.h"
#import "AppDelegate.h"

@interface MyProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet HJManagedImageV *image_profile;
@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_email;

@end
