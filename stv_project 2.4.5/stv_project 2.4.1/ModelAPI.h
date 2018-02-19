//
//  ModelAPI.h
//  stv_project 2.4.1
//
//  Created by kazua on 2018/02/09.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface ModelAPI : NSObject

@property ViewController *viewController;

@property (nonatomic) NSMutableArray *weather;
@property NSArray *forecasts;
@property NSMutableArray *weatherClasses;

- (id)connectAPI;

@end
