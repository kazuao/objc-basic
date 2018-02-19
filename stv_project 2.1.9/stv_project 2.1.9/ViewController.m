//
//  ViewController.m
//  stv_project 2.1.9
//
//  Created by kazua on 2018/01/25.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *pickerLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIToolbar *pickerToolbar;
@property (weak, nonatomic) NSDate *date;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self disablePicker];
    
    // 初期値を今日の日付に
    [self.datePicker setDate:[NSDate date]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changedPicker:(UIDatePicker *)sender {
    // 初期化
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    
    // 日付のフォーマット
    dateFormat.dateFormat = @"yy/MM/dd";
    
    // ラベルに日付を反映
    self.pickerLabel.text = [dateFormat stringFromDate:self.datePicker.date];
}

- (IBAction)doneBtn:(UIBarButtonItem *)sender {
    [self disablePicker];
}
        - (void)enablePicker{
            self.datePicker.hidden = NO;
            self.pickerToolbar.hidden = NO;
        }
        - (void)disablePicker{
            self.datePicker.hidden = YES;
            self.pickerToolbar.hidden = YES;
        }

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([event touchesForView:self.pickerLabel]){
        [self enablePicker];
    } else {
        [self disablePicker];
    }
}

@end
