//
//  main.m
//  stv_project 1.1.1
//
//  Created by kazua on 2018/01/16.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    
    BOOL YesOrNo = NO;
    NSLog(@"%d", YesOrNo);

    NSString* sampleStr = @"hello world";
    NSLog(@"%@", sampleStr);
    
    NSInteger sampleInt = 10;
    NSLog(@"%ld", sampleInt);
    
    //double sampleNmb = 1.145451;
    NSNumber *numberText = @3434.77f;
    NSLog(@"%@", numberText);
    
    return 0;
}
