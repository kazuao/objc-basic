//
//  CalendarViewController.m
//  SimpleCalendar
//
//  Created by hiraya.shingo on 2015/01/29.
//  Copyright (c) 2015年 hiraya.shingo. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarViewCell.h"

// Extension(よくわからない)
@implementation NSDate (Extension)

- (NSDate *)monthAgoDate {
    
    NSInteger addValue = -1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.month = addValue;
    return [calendar dateByAddingComponents:dateComponents toDate:self options:0];
}

- (NSDate *)monthLaterDate {
    
    NSInteger addValue = 1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.month = addValue;
    return [calendar dateByAddingComponents:dateComponents toDate:self options:0];
}

@end

const NSUInteger DaysPerWeek = 7;
const CGFloat CellMargin = 0.2f;

@interface CalendarViewController ()

@property (strong, nonatomic) NSDate *selectedDate;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedDate  = [NSDate date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//// 画面の切り替え
// 前の月
- (IBAction)didTapPrevButton:(id)sender {
    
    self.selectedDate = [self.selectedDate monthAgoDate];
    
    [self.myCollectionView reloadData];
}

// 次の月
- (IBAction)didTapNextButton:(id)sender {
    
    self.selectedDate = [self.selectedDate monthLaterDate];
    
    [self.myCollectionView reloadData];
}

// 現在の日付を取得し、タイトルをセット
- (void)setSelectedDate:(NSDate *)selectedDate {
    
    // スコープ内で使う、selfをつけるとクラッシュする
    _selectedDate = selectedDate;
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy年M日";
    self.title = [formatter stringFromDate:selectedDate];
}

// 月の初めを取得する
- (NSDate *)firstDateOfMonth {
    
    NSDateComponents *components =
    [[NSCalendar currentCalendar]
     components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self.selectedDate];
    components.day = 1;
    
    NSDate *firstDateMonth = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    return firstDateMonth;
}

// 表記する日付の取得
- (NSDate *)dateForCellAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger ordinalityOfFirstDay =
    [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay
                                            inUnit:NSCalendarUnitWeekOfMonth
                                           forDate:self.firstDateOfMonth];
    
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.day = indexPath.item - (ordinalityOfFirstDay - 1);
    
    NSDate *date = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents
                                                                 toDate:self.firstDateOfMonth
                                                                options:0];
    return date;
}

// collectionViewのheaderの設定
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    // セクションヘッダ・フッタを引っ張ってくる
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        // --- ヘッダ
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                  withReuseIdentifier:@"Header"
                                                                                         forIndexPath:indexPath];
        reusableview = headerView;
    }
    return reusableview;
}

// cellの列数を設定
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSRange rangeOfWeeks = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth
                                                              inUnit:NSCalendarUnitMonth
                                                             forDate:self.firstDateOfMonth];
    NSUInteger numberOfWeeks = rangeOfWeeks.length;
    NSInteger numberOfItems = numberOfWeeks * DaysPerWeek;
    
    return numberOfItems;
}

// cellの設定
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CalendarViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"d";
    // カレンダーの日付をセット
    cell.dateLabel.text = [formatter stringFromDate:[self dateForCellAtIndexPath:indexPath]];
    
    NSString *dateWeek = [self getWeekday:[self dateForCellAtIndexPath:indexPath]];
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
    NSDateComponents *comps = [calendar components:NSCalendarUnitMonth fromDate:[self dateForCellAtIndexPath:indexPath]];
    // 表示しているカレンダーの月を取得
    NSArray *params = [self.title componentsSeparatedByString:@"年"];
    int length = (int)[params[1] length];
    NSString *str = [params[1] substringToIndex:(length-1)];
    NSInteger thisMonth = [str integerValue];
    
    // 現在の月以外はグレーに
    if (comps.month != thisMonth) {
        cell.dateLabel.textColor = [UIColor grayColor];
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
    CGFloat height = width * 2.0f;
    
    return CGSizeMake(width, height);
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

