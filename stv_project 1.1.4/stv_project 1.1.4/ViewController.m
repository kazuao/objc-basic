//
//  ViewController.m
//  stv_project 1.1.4
//
//  Created by kazua on 2018/01/17.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"
#import "Account.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // accountのinstance化
    Account *ken = [[Account alloc]
                    initWithName:@"ken"
                    age:29
                    sex:@"man"
                    strongLang:@"PHP"];
    
    Account *aya = [[Account alloc]
                    initWithName:@"aya"
                    age:26
                    sex:@"woman"
                    strongLang:@"swift"];
    
    NSArray *team = @[ken, aya];
    
    for (Account *person in team) {
        [person printAccount];
    }
}

@end
