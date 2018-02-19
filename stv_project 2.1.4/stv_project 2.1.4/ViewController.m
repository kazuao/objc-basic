//
//  ViewController.m
//  stv_project 2.1.4
//
//  Created by kazua on 2018/01/20.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)alertBtn:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Sample Alert"
                                                                             message:@"どちらかのボタンを押してください"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action) {
                                    [self otherButtonPushed];
                                }]];
    
    [alertController addAction:[UIAlertAction
                                actionWithTitle:@"cancel"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action) {
                                    [self cancelButtonPushed];
                                }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)otherButtonPushed{
    NSLog(@"OKボタンを押しました。");
};
-(void)cancelButtonPushed{
//    NSLog(@"cancelボタンを押しました。");
}

@end
