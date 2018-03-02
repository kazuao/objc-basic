//
//  AppDelegate.m
//  stv_project 2.5.8
//
//  Created by kazua on 2018/02/16.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate () 
@end

@implementation AppDelegate

// version check
#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [FIRApp configure];
    [self registerForRemoteNotifications];
    return YES;
}

//
- (void)registerForRemoteNotifications {
    // 上か同じ以上なら
    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")){
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if(!error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                });
            }
        }];
    }
}

// フォアグランウンド時に呼び出す
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    NSLog(@"User Info : %@",notification.request.content.userInfo);
    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
}

// Called to let your app know which action was selected by the user for a given notification.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response
        withCompletionHandler:(void(^)(void))completionHandler{
    NSLog(@"User Info : %@",response.notification.request.content.userInfo);
    completionHandler();
}

    @end

