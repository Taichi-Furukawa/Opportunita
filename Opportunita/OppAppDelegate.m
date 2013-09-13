//
//  OppAppDelegate.m
//  Opportunita
//
//  Created by furukawa on 2013/07/04.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "OppAppDelegate.h"
#import "OppTimelineView.h"

@implementation OppAppDelegate
BOOL login;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    NSUserDefaults *user_def = [NSUserDefaults standardUserDefaults];
    login=[user_def boolForKey:@"LoginState"];
    if (login==NO) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound| UIRemoteNotificationTypeAlert)];
    }else{
        NSLog(@"%@",[user_def stringForKey:@"My_usser_ID"]);
    }
    
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if(userInfo){//push
        NSLog(@"%@",userInfo);
    }

    return YES;
}

- (void)application:(UIApplication*)app didFailToRegisterForRemoteNotificationsWithError:(NSError*)err{
	NSLog(@"Errorinregistration.Error:%@",err);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSString *Token = [[[[devToken description] stringByReplacingOccurrencesOfString:@"<"withString:@""]
                        stringByReplacingOccurrencesOfString:@">" withString:@""]
                       stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSLog(@"deletoken=%@",Token);
    
    OppConnection *loginConnection=[OppConnection instance];
    loginConnection.delegate=self;
    [loginConnection login_and_DeviceToken:Token];
    
    
}

-(void)ReceiveData:(NSString *)responce Method:(NSString *)method_name{
    if([responce isEqualToString:@"cantlogin"]==YES){
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"エラー発生"
                                  message:@"サーバー管理者に問い合わせて下さい" delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil
                                  ];
        [alertView show];

    }else{
        NSUserDefaults *user_def = [NSUserDefaults standardUserDefaults];
        [user_def setObject:responce forKey:@"My_user_ID"];
        [user_def setBool:YES forKey:@"LoginState"];
        
        /*
        UIStoryboard *storyboard = [[[self window]rootViewController]storyboard];
        OppTimelineView *segu =[[OppTimelineView alloc]init];
        segu=[storyboard instantiateViewControllerWithIdentifier:@"TimelineView"];
        self.window.rootViewController=segu;
         */
    }
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"%@",userInfo);
    if (UIApplicationStateInactive == application.applicationState)
    {
        //ユーザが通知情報をタップしたことによってフォアグラウンドになった
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
    if (UIApplicationStateActive == application.applicationState)
    {
        //フォアグラウンドでバリバリ動いてる最中にpushが飛んできた
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
