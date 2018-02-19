//
//  ViewController.m
//  stv_project 2.1.12
//
//  Created by kazua on 2018/01/26.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) NSArray *photos;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.photos = @[@"1", @"2", @"3"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    // storyboardのtagに合わせてimageを設定
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    // 配列のindexをcellのindexと同じにする
    NSString *imgName = self.photos[(int)(indexPath.row)];
    // 配列の名前の画像を呼び出す
    UIImage *image = [UIImage imageNamed:imgName];
    imageView.image = image;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
