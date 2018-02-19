//
//  Model.m
//  stv_project 2.4.1
//
//  Created by kazua on 2018/02/07.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "Model.h"
#import "FMDB.h"
#import "ViewController.h"
#import "Wether.h"

@implementation Model

- (void)registerWether:registerContent {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir  = [paths objectAtIndex:0];
    NSString *filePath = [dir stringByAppendingPathComponent:@"wether.db"];
    FMDatabase *fm = [[FMDatabase alloc] initWithPath:filePath];
    
    // datebase用 現在時刻の取得
    NSDate *date = [self fetchDate];
    
    // 引数を登録用に分解
    Wether *wether = [Wether new];
    
    // delete_flgの初期値
    NSInteger delete_false = 0;
    
    NSString *createTableSql =
    @"CREATE TABLE IF NOT EXISTS wetherInfo(wt_id INTEGER PRIMARY KEY,wt_state TEXT,wt_date TEXT,wt_icon TEXT,created DATE,modified DATE,delete_flg TEXT);";
    NSString *insertTableSql =
    @"INSERT INTO wetherInfo(`wt_state`, `wt_date`, `wt_icon`, `created`, `modified`, `delete_flg`) VALUES(:wt_state,:wt_date,:wt_icon,:created,:modified,:delete_flg);";
    
    [fm open];
    
    // APIをぐるぐる回して日付順に登録していく
    int i;
    for (i = 0; i < [registerContent count]; i++) {
        wether = registerContent[i];
        NSString *wt_state = wether.wt_state;
        NSString *wt_date  = wether.wt_date;
        NSString *wt_icon  = wether.wt_icon;
        
        [fm executeUpdate:createTableSql];
        
        [fm executeUpdate:insertTableSql withParameterDictionary:@{@"wt_state":wt_state, @"wt_date":wt_date, @"wt_icon":wt_icon, @"created":date, @"modified":date, @"delete_flg":[NSNumber numberWithInteger:delete_false]}];
    }
    
    [fm close];
}

// select前にdbの有無をチェック
- (BOOL) checkDBTable {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir  = [paths objectAtIndex:0];
    NSString *filePath = [dir stringByAppendingPathComponent:@"wether.db"];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:filePath]) {
        
        NSLog(@"true");
        return NO;
    } else {
        NSLog(@"false");
        return YES;
    }
}

- (id)fetchDate {
    
    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSString *date = [df stringFromDate:[NSDate date]];
    return date;
}

- (id)fetchWether {
    
    ViewController *viewController = [ViewController new];
    NSMutableArray *wetherArr = [NSMutableArray new];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir  = [paths objectAtIndex:0];
    NSString *filePath = [dir stringByAppendingPathComponent:@"wether.db"];
    FMDatabase *fm = [[FMDatabase alloc] initWithPath:filePath];
    
    NSString *selectTableSql =
    @"SELECT `wt_id`, `wt_state`,`wt_date`,`wt_icon` FROM wetherInfo WHERE `delete_flg` = 0 ORDER BY `wt_id` asc;";
    
    [fm open];
    
    FMResultSet *results = [fm executeQuery:selectTableSql];
    
    while ([results next]) {
        // ↓whileの中に書かないと一行のみを繰り返す
        Wether *wetherList = [Wether new];
        wetherList.wt_state = [results stringForColumn:@"wt_state"];
        wetherList.wt_date  = [results stringForColumn:@"wt_date"];
        wetherList.wt_icon  = [results stringForColumn:@"wt_icon"];
        
        [wetherArr addObject:wetherList];
    }
    [results close];
    [fm close];
    
    [viewController.wetherTable reloadData];
    
    return wetherArr;
}

@end
