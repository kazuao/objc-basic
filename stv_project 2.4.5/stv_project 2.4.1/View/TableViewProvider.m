//
//  TableViewProvider.m
//  stv_project 2.4.1
//
//  Created by kazua on 2018/02/09.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "TableViewProvider.h"
#import "WeatherTableViewCell.h"

@implementation TableViewProvider

// title
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *title = @"天気予報";
    return title;
}

// cellの数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.weatherLists.count;
}

// custom cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // 画像のキャッシュ化
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main   = dispatch_get_main_queue();
    cell.cellImg.image = nil;
    dispatch_async(q_global, ^{
        NSURL *url       = [NSURL URLWithString:self.weatherLists[indexPath.row].wt_icon];
        NSData *data     = [NSData dataWithContentsOfURL:url];
        UIImage *imgData = [UIImage imageWithData:data];
        
        dispatch_async(q_main, ^{
            cell.cellImg.image = imgData;
        });
    });
    cell.cellDateLabel.text = self.weatherLists[indexPath.row].wt_date;
    cell.cellTelop.text     = self.weatherLists[indexPath.row].wt_state;

    return cell;
}

@end
