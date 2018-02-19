//
//  ViewController.m
//  stv_project 2.1.18
//
//  Created by kazua on 2018/01/28.
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

- (IBAction)pushBtn:(id)sender {
    UIStoryboard *second = [UIStoryboard storyboardWithName:@"Second" bundle:[NSBundle mainBundle]];
    UIViewController *secondView = [second instantiateInitialViewController];
    // navigationControllerで遷移
    [self.navigationController pushViewController:secondView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
