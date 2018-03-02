//
//  ViewController.m
//  stv_project 2.5.6
//
//  Created by kazua on 2018/02/14.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"
@import CoreLocation;

@interface ViewController () <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UILabel *labelLatitude;
@property (weak, nonatomic) IBOutlet UILabel *labelLongitude;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (nil == self.locationManager) {
        self.locationManager = [CLLocationManager new];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
            // 起動中常にgpsを取得する
            [self.locationManager requestAlwaysAuthorization];
        }
    }
    if (nil == self.locationManager) {
        self.locationManager = [CLLocationManager new];
    }
    self.locationManager.delegate = self;
    
    // 情報更新＋位置情報取得
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *location = [locations lastObject];
    // 緯度 %+.6f
    self.labelLatitude.text  = [NSString stringWithFormat:@"%+.6f", location.coordinate.latitude];
    // 経度 %+.6f
    self.labelLongitude.text = [NSString stringWithFormat:@"%+.6f", location.coordinate.longitude];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
