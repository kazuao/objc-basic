//
//  AppDelegate.h
//  stv_project 2.5.8
//
//  Created by kazua on 2018/02/16.
//  Copyright © 2018年 kazua. All rights reserved.
//

@import UIKit;
@import Firebase;
@import UserNotifications;

@interface AppDelegate : UIResponder<UIApplicationDelegate, FIRMessagingDelegate, UNUserNotificationCenterDelegate>

@property(nonatomic, strong) UIWindow *window;

@end
