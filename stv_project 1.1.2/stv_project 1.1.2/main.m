//
//  main.m
//  stv_project 1.1.2
//
//  Created by kazua on 2018/01/17.
//  Copyright © 2018年 kazua. All rights reserved.
//

@import UIKit;
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    
    // arrayの課題
    NSArray *foodArray  = @[@"醤油", @"味噌", @"塩", @"豚骨"];
    NSLog(@"醤油 = %@", foodArray[0]);
    NSLog(@"味噌 = %@", foodArray[1]);
    NSLog(@"塩 = %@", foodArray[2]);
    NSLog(@"豚骨 = %@", foodArray[3]);
    
    // arrayを一括出力した際に文字化けする問題対策
    NSString *arrString = [NSString stringWithFormat:@"%@",foodArray];
    NSString *arrUTFNonLossyASCIIStringEncoding =
    [NSString stringWithCString:[arrString cStringUsingEncoding:NSUTF8StringEncoding]
                       encoding:NSNonLossyASCIIStringEncoding];
    NSLog(@"afterFormat : %@", arrUTFNonLossyASCIIStringEncoding);
    
    // dictionaryの課題
    NSDictionary *nutrientsDictionary = @{@"protein": @"タンパク質",
                                          @"fat"    : @"脂肪",
                                          @"carb"   : @"炭水化物"
                                          
    };
    
    NSLog(@"タンパク質 = %@", nutrientsDictionary[@"protein"]);
    NSLog(@"脂肪 = %@", nutrientsDictionary[@"fat"]);
    NSLog(@"炭水化物 = %@", nutrientsDictionary[@"carb"]);
    
    return 0;
}
