//
//  Account.h
//  stv_project 1.1.4
//
//  Created by kazua on 2018/01/18.
//  Copyright © 2018年 kazua. All rights reserved.
//

@import Foundation;

@interface Account:NSObject

@property NSString  *name;
@property NSInteger age;
@property NSString  *sex;
@property NSString  *strongLang;

- (id)initWithName:(NSString *)name age:(NSInteger)age sex:(NSString*)sex strongLang:(NSString*)strongLang;

- (void)printAccount;

@end
