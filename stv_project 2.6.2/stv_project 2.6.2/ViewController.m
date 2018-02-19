//
//  ViewController.m
//  stv_project 2.6.2
//
//  Created by kazua on 2018/02/15.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *param1;
@property (weak, nonatomic) IBOutlet UILabel *param2;
@property (weak, nonatomic) IBOutlet UIButton *getParamBtn;

@end

@implementation ViewController

- (IBAction)getParam:(id)sender {
    
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    self.param1.hidden = NO;
    self.param2.hidden = NO;
    self.param1.text = ad.result[@"sample1"];
    self.param2.text = ad.result[@"sample2"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
