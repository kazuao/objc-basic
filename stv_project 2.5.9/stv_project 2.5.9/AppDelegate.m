//
//  AppDelegate.m
//  stv_project 2.5.9
//
//  Created by kazua on 2018/02/18.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "AppDelegate.h"
@import UserNotifications;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    [application unregisterForRemoteNotifications];
//    [application registerForRemoteNotifications];
    
    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){10, 0, 0}]){
        
        //iOS10以上での、DeviceToken要求方法
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert |
                                                 UNAuthorizationOptionBadge |
                                                 UNAuthorizationOptionSound)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  if (error) {
                                      return;
                                  }
                                  if (granted) {
                                      //通知を許可にした場合DeviceTokenを要求
                                      [[UIApplication sharedApplication] registerForRemoteNotifications];
                                  }
                              }];
    } else if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){8, 0, 0}]){
        
        //iOS10未満での、DeviceToken要求方法
        
        //通知のタイプを設定したsettingを用意
        UIUserNotificationType type = UIUserNotificationTypeAlert |
        UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound;
        UIUserNotificationSettings *setting;
        setting = [UIUserNotificationSettings settingsForTypes:type
                                                    categories:nil];
        
        //通知のタイプを設定
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
        
        //DeviceTokenを要求
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        
        //iOS8未満での、DeviceToken要求方法
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeAlert |
          UIRemoteNotificationTypeBadge |
          UIRemoteNotificationTypeSound)];
    }
    
    return YES;
}
// DeviceToken受信成功
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *token = deviceToken.description;
    
    // <aaaa bbbb cccc dddd>みたいな形式でくるので、"<"、">"、"(空白)"を取ってあげると便利だよ
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"deviceToken: %@", token);
}

// DeviceToken受信失敗
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"deviceToken error: %@", [error description]);
}
// 通常のPush通知の受信
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"pushInfo: %@", [userInfo description]);
}

// BackgroundFetchによるバックグラウンドの受信
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"pushInfo in Background: %@", [userInfo description]);
    completionHandler(UIBackgroundFetchResultNoData);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
