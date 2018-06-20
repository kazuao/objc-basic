//
//  ViewController.m
//  stv_project 1.13
//
//  Created by kazua on 2018/01/17.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 課題
    // if~else文
    NSInteger ifCheckInt = 1;
    if (ifCheckInt == 1){
        NSLog(@"これは%ldです", ifCheckInt);
    } else {
        NSLog(@"これは1ではありません");
    }
    
    // if~else if文
    NSInteger ifCheckInt2 = 2;
    if (ifCheckInt2 == 1){
        NSLog(@"これは%ldです", ifCheckInt2);
    }else if(ifCheckInt2 == 2){
        NSLog(@"これは%ldです", ifCheckInt2);
    }else{
        NSLog(@"これは2ではありません");
    }
    
    // 三項演算子
    NSString *compareStr1 = @"a";
    NSString *compareStr2 = @"b";
    NSString *isSameStr = (compareStr1 == compareStr2)? @"同じ": @"違う";
    NSLog(@"どっち? = %@", isSameStr);
    
    // for文
    for (int i = 0; i <= 10; i++){
        NSLog(@"%d回目", i);
    }
    
    // 高速列挙構文
    NSArray *colorArr = @[@"赤", @"青", @"緑"];
    for (NSString *color in colorArr){
        NSLog(@"今の色は%@", color);
    }
    
    NSDictionary *colorDic = @{@"red": @"赤", @"blue": @"青", @"green": @"緑"};
    for (NSString *key in colorDic){
        NSLog(@"%@は%@", key, colorDic[key]);
    }
    // switch文
    NSInteger switchInt = 2;
    switch (switchInt) {
        case 1:
            NSLog(@"これは%ldです", switchInt);
            break;
        case 2:
            NSLog(@"これは%ldです", switchInt);
            break;
        case 3:
            NSLog(@"これは%ldです", switchInt);
            break;
        default:
            break;
    }
}

@end
