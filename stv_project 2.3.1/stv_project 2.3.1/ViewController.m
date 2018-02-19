//
//  ViewController.m
//  stv_project 2.3.1
//
//  Created by kazua on 2018/02/01.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // インスタンス生成
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    // 値をキーに保存
    [userDefaults setInteger:400 forKey:@"key_int"];
    [userDefaults setDouble:22.22 forKey:@"key_double"];
    [userDefaults setObject:@"hogehoge" forKey:@"key_string"];
    // 確定
    [userDefaults synchronize];
    
    // 読み込み
    NSInteger userDefaultsInteger = [userDefaults integerForKey:@"key_int"];
    double    userDefaultsDouble  = [userDefaults doubleForKey:@"key_double"];
    NSString *userDefaultsString  = [userDefaults stringForKey:@"key_string"];
    
    NSLog(@"int -> %ld , double -> %f , string -> %@", userDefaultsInteger, userDefaultsDouble, userDefaultsString);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
