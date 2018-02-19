//
//  RegisterViewController.m
//  stv_project 2.3.4
//
//  Created by kazua on 2018/02/02.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "RegisterViewController.h"
#import "ViewController.h"
#import "FMDB.h"

@interface RegisterViewController()

@property (weak, nonatomic) IBOutlet UITextField *todoTitle;
@property (weak, nonatomic) IBOutlet UITextView *todoComment;
@property (weak, nonatomic) IBOutlet UITextField *todoLimit;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIToolbar *pickerToolbar;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.todoComment.layer.cornerRadius = 5.0f;
    [[self.todoComment layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.todoComment layer] setBorderWidth:0.5];
    [[self.datePicker layer] setBackgroundColor:[[UIColor whiteColor] CGColor]];
    
    [self disablePicker];
    [self datePicker];
}

- (IBAction)datePicker:(id)sender {
    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"YY/MM/dd";
    self.todoLimit.text = [df stringFromDate:self.datePicker.date];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([event touchesForView:self.todoLimit]) {
        [self enablePicker];
    } else {
        [self disablePicker];
    }
}

- (IBAction)doneBtn:(UIBarButtonItem *)sender {
    [self disablePicker];
}
- (void)enablePicker {
    self.pickerToolbar.hidden = NO;
    self.datePicker.hidden    = NO;
}
- (void)disablePicker {
    self.pickerToolbar.hidden = YES;
    self.datePicker.hidden    = YES;
}

- (IBAction)regiBtn:(id)sender {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir = [paths objectAtIndex:0];
    NSString *filePath = [dir stringByAppendingPathComponent:@"tr_todo.db"];
    FMDatabase *fm = [[FMDatabase alloc] initWithPath:filePath];
    
    // Table作成
    NSString *createTableSql =
    @"CREATE TABLE IF NOT EXISTS tr_todo(todo_id INTEGER PRIMARY KEY,todo_title TEXT,todo_contents TEXT,created INTEGER,modified INTEGER,limit_date INTEGER,delete_flg INTEGER);";
    // tableにinsert
    NSString *insertTableSql = @"INSERT INTO tr_todo(todo_title, todo_contents, created, modified, limit_date, delete_flg) VALUES(?,?,?,?,?,?);";
    
    // 現在の時間を取得
    NSString* nowTime = [self dateCapture];
    NSString *limit = self.todoLimit.text;
    // database開始
    [fm open];
    // tableを作成
    [fm executeUpdate:createTableSql];
    
    // titleが入力されていれば登録、されていなければalertviewを出す
    if (self.todoTitle.text.length != 0) {
        [fm executeUpdate:insertTableSql, self.todoTitle, self. todoComment, nowTime, nowTime, limit, @"0"];
        NSLog(@"ok");
    } else {
        [self titleNullAlert];
        NSLog(@"ng");
    }
    [fm close];
}
// 現在の時間を取得する
- (id)dateCapture {
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:@"YY/MM/dd HH:mm:ss"];
    NSString *setToday = [dateFormat stringFromDate:[NSDate date]];
    return setToday;
}
// alertview
- (void)titleNullAlert {
    UIAlertController *ac = [UIAlertController
                             alertControllerWithTitle:@"Alert"
                             message:@"titleは入力必須です。"
                             preferredStyle:UIAlertControllerStyleAlert];
    [ac addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:ac animated:YES completion:nil];
}

@end
