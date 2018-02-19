//
//  ViewController.m
//  stv_project 2.5.7
//
//  Created by kazua on 2018/02/14.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"
@import MapKit;

@interface ViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    
    // 表示する位置を指定
    CLLocationCoordinate2D location;
    location.latitude  =  35.623655;
    location.longitude = 139.724858;
    // 指定した位置で地図を表示
    [self.mapView setCenterCoordinate:location animated:NO];
    
    //縮尺
    MKCoordinateRegion region = self.mapView.region;
    region.center = location;
    region.span.latitudeDelta  = 0.01;
    region.span.longitudeDelta = 0.01;
    [self.mapView setRegion:region animated:NO];
    
    // 表示タイプを航空写真と地図の組み合わせ選ぶ(今回は普通の
    self.mapView.mapType = MKMapTypeStandard;
    
    // アノテーション
    // 新しいピンを作成
    MKPointAnnotation *annotation = [MKPointAnnotation new];
    // ピンの位置
    annotation.coordinate = CLLocationCoordinate2DMake(35.623655, 139.724858);
    annotation.title = @"スマートテックベンチャーズ";
    annotation.subtitle = @"東京都品川区大崎5-1-5 4F";
    [self.mapView addAnnotation:annotation];
    
    [self.view addSubview:self.mapView];
}

// annotation用のデリゲートメソッド
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    // 識別子を定義
    static NSString *Identifier = @"PinAnnotationIdentifier";
    MKPinAnnotationView *pinView;
    // 再利用可能なものを取得
    pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:Identifier];
    
    if (!pinView) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:Identifier];
        return pinView;
    }
    pinView.annotation = annotation;
    return pinView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
