//
//  AppDelegate.m
//  D8
//
//  Created by KLover on 6/27/2559 BE.
//  Copyright © 2559 KLover. All rights reserved.
//

#import "AppDelegate.h"

#import <UIKit/UIKit.h>
//#import <Parse/Parse.h>
//#import <ParseUI/ParseUI.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Cache
    NSString *documentdictionary;
    NSArray *Path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentdictionary = [Path objectAtIndex:0];
    documentdictionary = [documentdictionary stringByAppendingPathComponent:@"D8_cache/"];
    self.obj_Manager = [[HJObjManager alloc] initWithLoadingBufferSize:6 memCacheSize:20];
    
    HJMOFileCache *fileCache = [[HJMOFileCache alloc] initWithRootPath:documentdictionary];
    self.obj_Manager.fileCache=fileCache;
    
    fileCache.fileCountLimit=100;
    fileCache.fileAgeLimit=60*60*24*7;
    [fileCache trimCacheUsingBackgroundThread];
    // Cache

    return YES;
}

#pragma mark Push Notifications
/*
 'field_model_device'      => $json_array['model_device'],
 'field_name_device'       => $json_array['name_device'],
 'field_parse_id'          => $json_array['parse_id'],
 'field_system_version_device' => $json_array['system_version_device'],
 'field_uuid_device'       => $json_array['uuid_device'],
 */

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"%@", deviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
