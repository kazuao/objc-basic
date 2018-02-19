//
//  PageViewController.h
//  stv_project 2.1.16
//
//  Created by kazua on 2018/01/29.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewController : UIViewController

@property (nonatomic) NSInteger itemIndex;
@property (nonatomic, strong) NSString *labelName;
@property (nonatomic) NSInteger labelCount;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
