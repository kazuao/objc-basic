//
//  main.m
//  stv_project 1.1.1
//
//  Created by kazua on 2018/01/16.
//  Copyright © 2018年 kazua. All rights reserved.
//

@import UIKit;
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    
    BOOL decisionBool = NO;
    NSLog(@"%d", decisionBool);

    NSString* tryString = @"hello world";
    NSLog(@"%@", tryString);
    
    NSInteger tryInteger = 10;
    NSLog(@"%ld", tryInteger);
    
    //double sampleNmb = 1.145451;
    NSNumber *tryNumberInt  = @3434.77f;
    NSNumber *tryNumberBool = @YES;
    NSLog(@"%@ - %@", tryNumberInt, tryNumberBool);
    
    return 0;
}
