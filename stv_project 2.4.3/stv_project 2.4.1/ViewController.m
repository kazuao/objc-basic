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

// 天気APIの取得
const NSString *getWether = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=130010";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *wetherTable;

@property NSMutableArray *wether;
@property NSArray *forecasts;
@property NSMutableArray *wetherClasses;
@property NSDictionary *descriptionText;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.wetherTable.delegate = self;
    self.wetherTable.dataSource = self;
    
    [self connectAPI];
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
                     
                     Wether *wetherClass = [Wether new];
                     wetherClass.cellDateLabel = forecast[@"dateLabel"];
                     wetherClass.cellTelop     = forecast[@"telop"];
                     wetherClass.cellImg       = forecast[@"image"][@"url"];
                     
                     [self.wether addObject:wetherClass];
                     [self.wetherTable reloadData];
                 }
             }
             self.descriptionText = responseObject[@"description"];
        } @catch (NSException *exception) {
            NSLog(@"[ERROR)\n exception[%@]", exception);
        }
         
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         // エラーの場合の処理
         NSLog(@"APIを取得できませんでした。");
     }];
}

// title
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = @"天気予報";
    return title;
}
// cellの数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.forecasts.count;
}
// custom cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WetherTableViewCell *cell =
    (WetherTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Wether *wetherClass = [Wether new];
    wetherClass = self.wether[indexPath.row];
    
    // 画像のキャッシュ化
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main   = dispatch_get_main_queue();
    cell.cellImg.image = nil;
    dispatch_async(q_global, ^{
        NSURL *url       = [NSURL URLWithString:wetherClass.cellImg];
        NSData *data     = [NSData dataWithContentsOfURL:url];
        UIImage *imgData = [UIImage imageWithData:data];
        
        dispatch_async(q_main, ^{
            cell.cellImg.image = imgData;
            [cell layoutSubviews];
        });
    });
    
    cell.cellDateLabel.text = wetherClass.cellDateLabel;
    cell.cellTelop.text     = wetherClass.cellTelop;
    cell.cellText.text      = self.descriptionText[@"text"];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
