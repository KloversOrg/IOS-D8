//
//  Configs.m
//  lottery
//
//  Created by somkid simajarn on 8/14/2558 BE.
//  Copyright (c) 2558 bit. All rights reserved.
//

#import "Configs.h"
#import <sys/utsname.h>



//#define IDIOM
//#define IPAD     UIUserInterfaceIdiomPad

@implementation Configs

+ (Configs *)sharedInstance
{
    static Configs *sharedInstance;
    
    @synchronized(self)
    {
        if (!sharedInstance)
            sharedInstance = [[Configs alloc] init];
        
        return sharedInstance;
    }
}

- (id)init {
    self = [super init];
    if (self) {
        // sindex.php
        self.API_URL            = @"http://localhost";
        self.END_POINT          = @"/api";
        
        self.USER_LOGIN         = @"/my-api/user_login.json?_format=json";
        self.USER_REGISTER      = @"/my-api/user_register.json?_format=json";
        self.USER_LOGOUT        = @"/my-api/user_logout.json?_format=json";
        
        self.LIST_ARTICLE       = @"/my-api/list_article.json?_format=json";
        self.ADD_ARTICLE        = @"/my-api/add_article.json?_format=json";
        self.EDIT_ARTICLE       = @"/my-api/edit_article.json?_format=json";
        self.DELETE_ARTICLE     = @"/my-api/delete_article.json?_format=json";
        
        self.DEVICE_PUSH_NOTIFICATION = @"/my-api/device_push_notification.json?_format=json";
    
    }
    return self;
}
@end
