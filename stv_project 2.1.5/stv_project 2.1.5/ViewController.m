//
//  ViewController.m
//  stv_project 2.1.5
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)alertBtn:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"sample alert"
                                          message:@"どれかボタンを押してください"
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    // Facebook
    [alertController addAction:[UIAlertAction actionWithTitle:@"Facebook" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
        [self facebookButtonPushed];
    }]];
    
    // Twitter
    [alertController addAction:[UIAlertAction actionWithTitle:@"Twitter"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
        [self twitterButtonPushed] ;
    }]];
    
    // LINE
    [alertController addAction:[UIAlertAction actionWithTitle:@"LINE"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
        [self lineButtonPushed] ;
    }]];
    
    // Cancel
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
        [self cancelButtonPushed];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void) facebookButtonPushed{
    NSLog(@"Facebookボタンを押しました。");
}

-(void) twitterButtonPushed{
    NSLog(@"Twitterボタンを押しました。");
}

-(void) lineButtonPushed{
    NSLog(@"LINEボタンを押しました。");
}

-(void) cancelButtonPushed{
    NSLog(@"Cancelボタンを押しました。");
}

@end
