//
//  ViewController.m
//  stv_project 1.1.5
//
//  Created by kazua on 2018/01/19.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"
#import "Account.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 個人の設定
    Account *ken = [[Account new]
                    initWithName:@"ken"
                    age:29
                    sex:@"man"
                    strongLang:@"PHP"];
    
    Account *aya = [[Account new]
                    initWithName:@"aya"
                    age:26
                    sex:@"woman"
                    strongLang:@"swift"];
    
    
    NSArray *team = @[ken, aya];
    
    for (Account *person in team){
        [person printAccount];
    }
}

@end
