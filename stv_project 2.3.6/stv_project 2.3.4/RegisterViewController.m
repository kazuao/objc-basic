//
//  RegisterViewController.m
//  stv_project 2.3.4
//
//  Created by kazua on 2018/02/02.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "RegisterViewController.h"
#import "ViewController.h"
#import "CustomTableViewCell.h"
#import "FMDB.h"

@interface RegisterViewController()

@property (weak, nonatomic) IBOutlet UITextField  *todoTitle;
@property (weak, nonatomic) IBOutlet UITextView   *todoComment;
@property (weak, nonatomic) IBOutlet UITextField  *todoLimit;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIToolbar    *pickerToolbar;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // textViewの設定
    self.todoComment.layer.cornerRadius   = 5.0f;
    self.todoComment.layer.borderColor    = [UIColor grayColor].CGColor;
    self.todoComment.layer.borderWidth    = 0.5;
    self.datePicker.layer.backgroundColor = [UIColor whiteColor].CGColor;
    // pickerを隠しておく
    [self disablePicker];
    // datePickerの初期時間を今日に
    [self.datePicker setDate:[NSDate date]];
    // textFieldへのタップジェスチャー
    UITapGestureRecognizer *singleFingerDTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.todoLimit addGestureRecognizer:singleFingerDTap];
}
// タップジェスチャー
- (void)handleSingleTap:(UIGestureRecognizer *)sender {
    [self enablePicker];
}

// textFieldへdatePickerの反映
- (IBAction)datePicker:(id)sender {
    [self datePickTime];
}

// date型のフォーマットを変更する
- (id)datePickTime {
    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"YYYY-MM-dd";
    self.todoLimit.text = [df stringFromDate:self.datePicker.date];
    return self.todoLimit.text;
}

// タッチイベント
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([event touchesForView:self.todoLimit]) {
        [self enablePicker];
    } else {
        [self disablePicker];
    }
}

// doneボタンを押した時の処理
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

// 登録ボタンの処理
- (IBAction)regiBtn:(id)sender {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir = [paths objectAtIndex:0];
    NSString *filePath = [dir stringByAppendingPathComponent:@"tr_todo.db"];
    FMDatabase *fm = [[FMDatabase alloc] initWithPath:filePath];
    
    // delete_flgをtrueに
    NSInteger delete_true = 0;
    
    // Table作成
    NSString *createTableSql =
    @"CREATE TABLE IF NOT EXISTS tr_todo(todo_id INTEGER PRIMARY KEY,todo_title TEXT,todo_contents TEXT,created DATE,modified DATE,limit_date TEXT,delete_flg INTEGER);";
    // tableにinsert
    NSString *insertTableSql = @"INSERT INTO tr_todo(`todo_title`, `todo_contents`, `created`, `modified`, `limit_date`, `delete_flg`) VALUES(:todo_title, :todo_contents, :created, :modified, :limit_date, :delete_flg);";
    
    // スペースをエスケープする
    NSString *trimTodoTitle = [self.todoTitle.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    // datebase用 現在時刻の取得
    NSDate *date = [self fetchDate];
    // 期限
    NSString *limit = [self datePickTime];
    
    // database開始
    [fm open];
    // tableを作成
    [fm executeUpdate:createTableSql];
    
    // titleが入力されていれば登録、されていなければalertviewを出す
    if (trimTodoTitle.length != 0) {
        [fm executeUpdate:insertTableSql withParameterDictionary:@{@"todo_title":trimTodoTitle,
                                                                   @"todo_contents":self.todoComment.text,
                                                                   @"created":date,
                                                                   @"modified":date,
                                                                   @"limit_date":limit,
                                                                   @"delete_flg":[NSNumber numberWithInteger:delete_true]}];
        [self successAlert];
    } else {
        [self titleNullAlert];
    }
    [fm close];
}

// 現在の時間を取得する
- (id)fetchDate {
    
    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSString *date = [df stringFromDate:[NSDate date]];
    return date;
}

// alertview
- (void)titleNullAlert {
    
    UIAlertController *alertController = [UIAlertController
                             alertControllerWithTitle:@"Alert"
                             message:@"titleは入力必須です。"
                             preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)successAlert {
    
    UIAlertController *alertController = [UIAlertController
                             alertControllerWithTitle:@"Success"
                             message:@"登録に成功しました。"
                             preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
