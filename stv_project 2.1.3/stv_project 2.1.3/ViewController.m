//
//  ViewController.m
//  stv_project 2.1.3
//
//  Created by kazua on 2018/01/20.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *backgroundChangeBtn;

@end

@implementation ViewController

- (IBAction)tapedBtn:(UIButton *)sender {
    // 背景画像の配列化
    NSArray<UIImage *> *imgArr =
                         @[[UIImage imageNamed:@"1"],
                           [UIImage imageNamed:@"2"],
                           [UIImage imageNamed:@"3"],
                           [UIImage imageNamed:@"4"],
                           [UIImage imageNamed:@"5"]];
    // 画像枚数分のランダム作成
    int randNum = (int)arc4random_uniform((uint32_t)imgArr.count);
                    //memo _uniformをつけるのがいいらしい uint32_tは4バイト符号なし整数(つけるべきらしい)
    [self.backgroundChangeBtn setBackgroundImage:imgArr[randNum] forState:UIControlStateNormal];
                                                            //memo つけないと怒られる ボタンが通常時に作用する
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
