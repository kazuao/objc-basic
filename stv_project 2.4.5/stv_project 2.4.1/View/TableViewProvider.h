//
//  TableViewProvider.h
//  stv_project 2.4.1
//
//  Created by kazua on 2018/02/09.
//  Copyright © 2018年 kazua. All rights reserved.
//

@import UIKit;
#import <Foundation/Foundation.h>
#import "Weather.h"

@interface TableViewProvider : NSObject <UITableViewDataSource>

@property (strong, nonatomic)NSMutableArray<Weather *> *weatherLists;

@end
