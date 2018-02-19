//
//  ViewController.m
//  stv_project 2.3.3
//
//  Created by kazua on 2018/02/02.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // FMDBお決まり文句
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * filePath = [[path firstObject] stringByAppendingString:@"sample.db"];
    // DB接続用のインスタンス生成
    FMDatabase *fm = [[FMDatabase alloc] initWithPath:filePath];
    
    [fm open];
    
    [fm executeUpdate:@"CREATE TABLE IF NOT EXISTS tr_todo(todo_id integer PRYMARY KEY,todo_title text,todo_contents text,created integer,modified integer,limit_date integer,delete_flg integer);"];
    
    FMResultSet *result = [fm executeQuery:@"SELECT * FROM sqlite_master"];
    while ([result next]){
        NSString *tableName = [result stringForColumn:@"name"];
        NSLog(@"table name is %@", tableName);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
