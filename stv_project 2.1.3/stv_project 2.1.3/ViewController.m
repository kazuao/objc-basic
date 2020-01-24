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
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property NSArray<UIImage *> *imageArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    self.backgroundImage.image = self.imageArray[0];
}

- (void)setup {
    // 背景画像の配列化
    self.imageArray = @[[UIImage imageNamed:@"1"],
                        [UIImage imageNamed:@"2"],
                        [UIImage imageNamed:@"3"],
                        [UIImage imageNamed:@"4"],
                        [UIImage imageNamed:@"5"]];
}

- (IBAction)tapedBtn:(UIButton *)sender {

    // 画像枚数分のランダム作成
    int randNum = (int)arc4random_uniform((uint32_t)self.imageArray.count);
    self.backgroundImage.image = self.imageArray[randNum];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
