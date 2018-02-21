//
//  ModelAPI.m
//  stv_project 2.4.1
//
//  Created by kazua on 2018/02/09.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ModelAPI.h"
#import "Weather.h"
#import "AFNetworking.h"

@implementation ModelAPI

- (id)connectAPI {
    
    self.weather = [NSMutableArray new];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:(NSString *)VCGetWeather parameters:nil progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
         @try {
             if ((self.forecasts = responseObject[@"forecasts"])) {
                 for (NSDictionary *forecast in self.forecasts) {
                     
                     Weather *weatherClass  = [Weather new];
                     weatherClass.wt_date  = forecast[@"date"];
                     weatherClass.wt_state = forecast[@"telop"];
                     weatherClass.wt_icon  = forecast[@"image"][@"url"];
                     
                     [self.weather addObject:weatherClass];
                 }
             }
         } @catch (NSException *exception) {
             NSLog(@"[ERROR)\n exception[%@]", exception);
         }
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         NSLog(@"APIを取得できませんでした。");
     }];
    return self.weather;
}

@end
