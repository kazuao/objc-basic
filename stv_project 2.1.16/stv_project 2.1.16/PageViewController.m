//
//  PageViewController.m
//  stv_project 2.1.16
//
//  Created by kazua on 2018/01/29.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "PageViewController.h"

@implementation PageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.contentLabel.text = [NSString stringWithFormat:@"%@ / %ld", self.labelName, (long)self.labelCount];
}

@end
