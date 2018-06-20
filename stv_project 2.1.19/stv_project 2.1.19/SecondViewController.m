//
//  SecondViewController.m
//  stv_project 2.1.19
//
//  Created by kazua on 2018/01/31.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UILabel *changeLabel;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.changeLabel.text = self.msgValue;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
