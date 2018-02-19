//
//  WetherTableViewCell.h
//  stv_project 2.4.1
//
//  Created by kazua on 2018/02/06.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WetherTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellTelop;
@property (weak, nonatomic) IBOutlet UILabel *cellText;
@property (weak, nonatomic) IBOutlet UIImageView *cellImg;

@end
