//
//  ViewController.m
//  stv_project 2.1.1
//
//  Created by kazua on 2018/01/19.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *stLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stLabel.text = NSLocalizedString(@"obcLocalizedStringText", @"");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
