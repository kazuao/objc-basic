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
#import "Weather.h"

@implementation Model

- (void)registerWeather:registerContents {
    
    // インスタンス化
    Weather *weather = [Weather new];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir  = [paths objectAtIndex:0];
    NSString *filePath = [dir stringByAppendingPathComponent:@"weather.db"];
    FMDatabase *fm = [[FMDatabase alloc] initWithPath:filePath];

    // datebase用 現在時刻の取得
    NSDate *date = [self fetchDate];
    
    // delete_flgの初期値
    NSInteger delete_false = 0;
    
    NSString *createTableSql =
    @"CREATE TABLE IF NOT EXISTS weatherInfo(wt_id INTEGER PRIMARY KEY,wt_state TEXT,wt_date TEXT UNIQUE,wt_icon TEXT,created DATE,modified DATE,delete_flg TEXT);";
    NSString *insertTableSql =
    @"INSERT OR REPLACE INTO weatherInfo(`wt_state`,`wt_date`,`wt_icon`,`created`,`modified`,`delete_flg`) VALUES(:wt_state,:wt_date,:wt_icon,:created,:modified,:delete_flg);";
    
    [fm open];
    
    // APIをぐるぐる回して日付順に登録していく
    int i;
    for (i = 0; i < [registerContents count]; i++) {
        weather = registerContents[i];
        NSString *wt_state = weather.wt_state;
        NSString *wt_date  = weather.wt_date;
        NSString *wt_icon  = weather.wt_icon;
        
        [fm executeUpdate:createTableSql];
        
        [fm executeUpdate:insertTableSql withParameterDictionary:@{@"wt_state":wt_state,
                                                                   @"wt_date":wt_date,
                                                                   @"wt_icon":wt_icon,
                                                                   @"created":date,
                                                                   @"modified":date,
                                                                   @"delete_flg":[NSNumber numberWithInteger:delete_false]}];
    }
    [fm close];
}

- (id)fetchDate {
    
    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSString *date = [df stringFromDate:[NSDate date]];
    return date;
}

- (void)fetchWeather {
    
    self.weatherArr = [NSMutableArray new];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir  = [paths objectAtIndex:0];
    NSString *filePath = [dir stringByAppendingPathComponent:@"weather.db"];
    FMDatabase *fm = [[FMDatabase alloc] initWithPath:filePath];
    
    NSLog(@"%@", NSHomeDirectory());
    
    NSString *selectTableSql =
    @"SELECT `wt_id`, `wt_state`,`wt_date`,`wt_icon` FROM weatherInfo WHERE `delete_flg` = 0 ORDER BY `wt_id` asc;";
    
    [fm open];
    
    FMResultSet *results = [fm executeQuery:selectTableSql];
    
    while ([results next]) {
        // ↓ whileの中に書かないと一行のみを繰り返す
        Weather *weatherList = [Weather new];
        weatherList.wt_state = [results stringForColumn:@"wt_state"];
        weatherList.wt_date  = [results stringForColumn:@"wt_date"];
        weatherList.wt_icon  = [results stringForColumn:@"wt_icon"];
        
        [self.weatherArr addObject:weatherList];
    }
    [results close];
    [fm close];
    
}

@end
