//
//  ViewController.h
//  stv_project 2.4.1
//
//  Created by kazua on 2018/02/06.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const VCGetWeather;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *weatherTable;
@property NSMutableArray *weatherLists;

@end

