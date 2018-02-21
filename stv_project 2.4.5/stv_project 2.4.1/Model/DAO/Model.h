//
//  Model.h
//  stv_project 2.4.1
//
//  Created by kazua on 2018/02/07.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"

@protocol DataModelDelegate<NSObject>

- (void)reloadData;

@end

@interface Model : NSObject

@property NSMutableArray *weatherArr;
@property (weak, nonatomic) id<DataModelDelegate> delegate;

- (void)registerWeather:registerContents;
- (id)fetchDate;
- (void)fetchWeather;

@end
