//
//  OppAppDelegate.m
//  Opportunita
//
//  Created by furukawa on 2013/07/04.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "OppAppDelegate.h"

@class OppTimelineView;

@implementation OppAppDelegate
BOOL login;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound| UIRemoteNotificationTypeAlert)];
    
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if(userInfo){
        NSLog(@"%@",userInfo);
        NSLog(@"app launch with push");
    }

    return YES;
}

- (void)application:(UIApplication*)app didFailToRegisterForRemoteNotificationsWithError:(NSError*)err{
	NSLog(@"Errorinregistration.Error:%@",err);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSString *Token = [[[[devToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""]
                        stringByReplacingOccurrencesOfString:@">" withString:@""]
                       stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSLog(@"deletoken=%@",Token);
    
    NSUserDefaults *deff=[NSUserDefaults standardUserDefaults];
    [deff setObject:Token forKey:@"device_token"];
    [deff synchronize];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"%@",userInfo);
    if (UIApplicationStateInactive == application.applicationState)
    {
        //ユーザが通知情報をタップしたことによってフォアグラウンドになった
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        NSLog(@"Push User tap fore ground");
    }
    if (UIApplicationStateActive == application.applicationState)
    {
        //フォアグラウンドでバリバリ動いてる最中にpushが飛んできた
        NSLog(@"Push foreground");
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end