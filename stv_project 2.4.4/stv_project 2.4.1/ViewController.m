//
//  ViewController.m
//  stv_project 2.4.1
//
//  Created by kazua on 2018/02/06.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "WetherTableViewCell.h"
#import "Wether.h"
#import "Model.h"

// 天気APIの取得
const NSString *getWether = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=130010";

@protocol MyProtocol
@optional
- (void)registerWater:registerContent;
- (BOOL) checkDBTable;
- (id)fetchWether;
@end

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, MyProtocol>

@property NSMutableArray *wether;
@property NSArray *forecasts;
@property NSMutableArray *wetherClasses;
@property NSIndexPath *indexPaths;
@property NSInteger countRows;

@property NSMutableArray *wetherLists;
@property BOOL isBoolDB;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.wetherTable.delegate = self;
    self.wetherTable.dataSource = self;
    
    // DBから入れ直す
    Model *dbModel = [Model new];
    // selector生成
    SEL checkSelector = @selector(checkDBTable);
    self.isBoolDB     = [dbModel performSelector:checkSelector];
    
    SEL wetherSelector = @selector(fetchWether);
    self.wetherLists   = [dbModel performSelector:wetherSelector];
}

// APIからいろいろ取ってくる
- (void)connectAPI {
    
    self.wether = [NSMutableArray new];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:(NSString *)getWether parameters:nil progress:nil
         success:^(NSURLSessionTask *task, id responseObject)
     {
         @try {
             if ((self.forecasts = responseObject[@"forecasts"])) {
                 for (NSDictionary *forecast in self.forecasts) {
                     
                     Wether *wetherClass  = [Wether new];
                     wetherClass.wt_date  = forecast[@"date"];
                     wetherClass.wt_state = forecast[@"telop"];
                     wetherClass.wt_icon  = forecast[@"image"][@"url"];
                     
                     [self.wether addObject:wetherClass];
                     [self.wetherTable reloadData];
                 }
             }
         } @catch (NSException *exception) {
             NSLog(@"[ERROR)\n exception[%@]", exception);
         }
         
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         // エラーの場合の処理
         NSLog(@"APIを取得できませんでした。");
     }];
}

// 登録ボタンを押すとDBに登録する
- (IBAction)registerBtn:(id)sender {
    
    // selector生成
    SEL registerSelector = @selector(registerWether:);
    Model *dbModel = [Model new];
    Model *registerContent = self.wether.mutableCopy;
    
    [dbModel performSelector:registerSelector withObject:registerContent];
    
    [self successAlert];
}

// title
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = @"天気予報";
    return title;
}
// cellの数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%lu", (unsigned long)self.wetherLists.count);
    return self.wetherLists.count;
}

// custom cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WetherTableViewCell *cell =
    (WetherTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (self.isBoolDB == 1) {
        Wether *wetherList = self.wetherLists[indexPath.row];
        
        // 画像のキャッシュ化
        dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_queue_t q_main   = dispatch_get_main_queue();
        cell.cellImg.image = nil;
        dispatch_async(q_global, ^{
            NSURL *url       = [NSURL URLWithString:wetherList.wt_icon];
            NSData *data     = [NSData dataWithContentsOfURL:url];
            UIImage *imgData = [UIImage imageWithData:data];
            
            dispatch_async(q_main, ^{
                cell.cellImg.image = imgData;
                [cell layoutSubviews];
            });
        });
        
        cell.cellDateLabel.text = wetherList.wt_date;
        cell.cellTelop.text     = wetherList.wt_state;
    }
    return cell;
}

- (void)successAlert {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Success"
                                          message:@"登録に成功しました。"
                                          preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [self connectAPI];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
