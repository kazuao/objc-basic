//
//  ViewController.m
//  stv_project 2.4.1
//
//  Created by kazua on 2018/02/20.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

NSString *const VCGetWeather = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=130010";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self connectAPI];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)connectAPI {
    
    __block NSArray *forecasts;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:(NSString *)VCGetWeather parameters:nil progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             @try {
                 if ((forecasts = responseObject[@"forecasts"])) {
                     for (NSDictionary *forecast in forecasts) {

                         NSLog(@"%@", forecast[@"date"]);
                         NSLog(@"%@", forecast[@"telop"]);
                         NSLog(@"%@", forecast[@"image"][@"url"]);
                     }
                 }
             } @catch (NSException *exception) {
                 NSLog(@"[ERROR)\n exception[%@]", exception);
             }
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             NSLog(@"APIを取得できませんでした。");
         }];
}

@end
