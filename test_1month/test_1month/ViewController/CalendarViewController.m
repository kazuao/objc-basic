//
//  CalendarViewController.m
//  SimpleCalendar
//
//  Created by hiraya.shingo on 2015/01/29.
//  Copyright (c) 2015年 hiraya.shingo. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarViewCell.h"
#import "CollectionViewProvider.h"

const NSUInteger DaysPerWeek = 7;
const CGFloat CellMargin = 0.2f;

@interface CalendarViewController ()

@property (strong, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (strong, nonatomic) NSDate *selectedDate;
@property (strong, nonatomic) CollectionViewProvider *collectionVP;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.selectedDate  = [NSDate date];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.myCollectionView reloadData];
    [super viewWillAppear:animated];
    
    self.collectionVP = [CollectionViewProvider new];
    self.myCollectionView.delegate   = self.collectionVP;
    self.myCollectionView.dataSource = self.collectionVP;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//// 画面の切り替え
// 前の月
- (IBAction)didTapPrevButton:(id)sender {
    
    self.selectedDate = [self monthAgoDate];
    
    [self.myCollectionView reloadData];
}

// 次の月
- (IBAction)didTapNextButton:(id)sender {
    
    self.selectedDate = [self monthLaterDate];
    
    [self.myCollectionView reloadData];
}
- (NSDate *)monthAgoDate {
    
    NSInteger addValue = -1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.month = addValue;
    return [calendar dateByAddingComponents:dateComponents toDate:self.selectedDate options:0];
}

- (NSDate *)monthLaterDate {
    
    NSInteger addValue = 1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.month = addValue;
    return [calendar dateByAddingComponents:dateComponents toDate:self.selectedDate options:0];
}

// 現在の日付を取得し、タイトルをセット
- (void)setSelectedDate:(NSDate *)selectedDate {
    
    // スコープ内で使う、selfをつけるとクラッシュする
    _selectedDate = selectedDate;
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy年M月";
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

@end
