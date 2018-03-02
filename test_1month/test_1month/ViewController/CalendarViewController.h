//
//  CalendarViewController.h
//  test_1month
//
//  Created by kazua on 2018/02/22.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const NSUInteger DaysPerWeek;
extern const CGFloat CellMargin;

@interface CalendarViewController : UICollectionViewController

- (NSDate *)firstDateOfMonth;
- (NSDate *)dateForCellAtIndexPath:(NSIndexPath *)indexPath;

@end
