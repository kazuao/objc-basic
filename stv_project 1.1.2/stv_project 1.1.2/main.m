//
//  main.m
//  stv_project 1.1.2
//
//  Created by kazua on 2018/01/17.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    
    NSArray *foodArr  = @[@"醤油", @"味噌", @"塩", @"豚骨"];
    NSLog(@"%@", foodArr[0]);
    NSLog(@"%@", foodArr[1]);
    NSLog(@"%@", foodArr[2]);
    NSLog(@"%@", foodArr[3]);
    NSString *arrString = [NSString stringWithFormat:@"%@",foodArr];
    NSString *arrUTFNonLossyASCIIStringEncoding = [NSString stringWithCString:[arrString cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    NSLog(@"afterFormat : %@", arrUTFNonLossyASCIIStringEncoding);
    
    NSDictionary *nutriDic = @{@"protein": @"タンパク質",
                               @"fat"    : @"脂肪",
                               @"carb"   : @"炭水化物"
                               };
    NSLog(@"%@", nutriDic[@"protein"]);
    NSLog(@"%@", nutriDic[@"fat"]);
    NSLog(@"%@", nutriDic[@"carb"]);
    
    return 0;
}
