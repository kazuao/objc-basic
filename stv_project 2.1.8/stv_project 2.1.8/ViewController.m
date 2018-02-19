//
//  ViewController.m
//  stv_project 2.1.8
//
//  Created by kazua on 2018/01/25.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *sampleLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *samplePicker;
@property (weak, nonatomic) IBOutlet UIToolbar *sampleToolBar;
@property (nonatomic) NSArray *picArr;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // delegate,datasourceの設定
    self.samplePicker.delegate = self;
    self.samplePicker.dataSource = self;
    
    // 要素を配列に
    self.picArr = @[@"北海道", @"東北", @"関東", @"中部", @"北陸"];
    
    // pickerとtoolbarを最初に消す
    [self disablePicker];
}

// labelがtouchされた時の処理
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([event touchesForView:self.sampleLabel]){
        [self enablePicker];
    } else {
        [self disablePicker];
    }
}
// doneを押した時の処理
- (IBAction)doneBtn:(UIBarButtonItem *)sender {
    [self disablePicker];
}
        // pickerを出す
        - (void)enablePicker{
            self.samplePicker.hidden  = NO;
            self.sampleToolBar.hidden = NO;
        }
        // pickerを消す
        - (void)disablePicker{
            self.samplePicker.hidden  = YES;
            self.sampleToolBar.hidden = YES;
        }

// pickerに列数を返す
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
// pickerに行数を返す
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.picArr count];
}

// pickerにpicArrの項目を反映する
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.picArr[row];
}

// labelに選択した項目を反映させる
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.sampleLabel.text = self.picArr[row];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
