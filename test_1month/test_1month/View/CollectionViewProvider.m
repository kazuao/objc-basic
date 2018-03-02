//
//  CollectionViewProvider.m
//  test_1month
//
//  Created by kazua on 2018/02/22.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "CollectionViewProvider.h"
#import "CalendarViewCell.h"

@implementation CollectionViewProvider

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSLog(@"aa");
    return 2;
}

// cellの列数を設定
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    CalendarViewController *CalendarVC = [CalendarViewController new];
    
    if (section == 0){
        return 7;
        
    } else {
        NSRange rangeOfWeeks = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth
                                                                  inUnit:NSCalendarUnitMonth
                                                                 forDate:CalendarVC.firstDateOfMonth];
        NSUInteger numberOfWeeks = rangeOfWeeks.length;
        NSInteger numberOfItems = numberOfWeeks * DaysPerWeek;
        
        return numberOfItems;
    }
}

// cellの設定
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CalendarViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.dateLabel.textColor = [UIColor blackColor];
    
    CalendarViewController *CalendarVC = [CalendarViewController new];
    
    if (indexPath.section == 0) {
        
        NSArray *weekdays = @[@"日", @"月", @"火", @"水", @"木", @"金", @"土"];
        cell.dateLabel.text = weekdays[indexPath.row];
        
    } else if (indexPath.section == 1) {
        
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"d";
        // カレンダーの日付をセット
        cell.dateLabel.text = [formatter stringFromDate:[CalendarVC dateForCellAtIndexPath:indexPath]];
        
        NSString *dateWeek = [self getWeekday:[CalendarVC dateForCellAtIndexPath:indexPath]];
        // 日曜日は赤色にする
        if ([dateWeek isEqual:@"日"]) {
            cell.dateLabel.textColor = [UIColor redColor];
        }
        // 土曜日は青色にする
        if ([dateWeek isEqual:@"土"]) {
            cell.dateLabel.textColor = [UIColor blueColor];
        }
        
        // 表示しているカレンダーの日付から月を取得
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = [calendar components:NSCalendarUnitMonth fromDate:[CalendarVC dateForCellAtIndexPath:indexPath]];
        // 表示しているカレンダーの月を取得
        NSArray *params = [CalendarVC.title componentsSeparatedByString:@"年"];
        int length = (int)[params[1] length];
        NSString *str = [params[1] substringToIndex:(length-1)];
        NSInteger thisMonth = [str integerValue];
        
        // 現在の月以外はグレーに
        if (comps.month != thisMonth) {
            cell.dateLabel.textColor = [UIColor grayColor];
        }
    }
    return cell;
}

// 曜日を取得する
- (id)getWeekday:date {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    
    //comps.weekdayは 1-7の値が取得できるので-1する
    NSString *weekDayStr = df.shortWeekdaySymbols[comps.weekday-1];
    return weekDayStr;
}

// cellのサイズ
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger numberOfMargin = 8;
    CGFloat width = floorf((collectionView.frame.size.width - CellMargin * numberOfMargin) / DaysPerWeek);
    
    if (indexPath.section == 0) {
        CGFloat height = width * 1.0f;
        return CGSizeMake(width, height);
        
    } else {
        CGFloat height = width * 1.7f;
        return CGSizeMake(width, height);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(CellMargin, CellMargin, CellMargin, CellMargin);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return CellMargin;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return CellMargin;
}

@end
