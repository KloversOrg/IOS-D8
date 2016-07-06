//
//  Configs.h
//  Configs
//
//  Created by somkid simajarn on 9/10/2558 BE.
//  Copyright (c) 2558 bit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import <CoreLocation/CoreLocation.h>



@interface Configs : NSObject

+ (Configs *)sharedInstance;

@property(nonatomic) NSString* API_URL, *END_POINT;

@property(nonatomic)NSString* USER_LOGIN;
@property(nonatomic)NSString* USER_REGISTER;
@property(nonatomic)NSString* USER_LOGOUT;

@property(nonatomic)NSString* LIST_ARTICLE;
@property(nonatomic)NSString* ADD_ARTICLE;
@property(nonatomic)NSString* EDIT_ARTICLE;
@property(nonatomic)NSString* DELETE_ARTICLE;


@property(nonatomic)NSString* DEVICE_PUSH_NOTIFICATION; 

@end
