//
//  ViewController.m
//  stv_project 2.1.7
//
//  Created by kazua on 2018/01/30.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

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

- (IBAction)btnTap:(id)sender {
    UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"Second" bundle:nil];
    // 画面遷移
    UIViewController *initialViewController = [secondStoryboard instantiateViewControllerWithIdentifier:@"SecondView"];

    [self presentViewController:initialViewController animated:YES completion:nil];
}
@end
