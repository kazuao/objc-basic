//
//  ViewController.m
//  stv_project 2.3.4
//
//  Created by kazua on 2018/02/02.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"
#import "RegisterViewController.h"

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

- (IBAction)toRegiBtn:(id)sender {
    RegisterViewController *regiView = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterView"];
    regiView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:regiView animated:YES completion:nil];
}

@end
