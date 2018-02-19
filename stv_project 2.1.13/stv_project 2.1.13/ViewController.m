//
//  ViewController.m
//  stv_project 2.1.13
//
//  Created by kazua on 2018/01/26.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic) NSArray *photos;
@property (nonatomic) NSArray *imgTitle;

@property IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 配列要素
    self.photos   = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8",@"9", @"10"];
    self.imgTitle = @[@"ball", @"moon", @"apple", @"totoro",
                 @"color", @"cat", @"dog", @"pig", @"buri", @"tuna"];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //section 数の設定、今回は１つにセット
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    // itemの数を設定する、配列の全要素数を入れる
    return self.photos.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell;
    //dequeueReusableCellWithReuseIdentifier の働きは再利用できるセルがあればそれを使う
    // 再利用できるセルがなければ生成する
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    //storyboard上の画像につけたタグに合わせて UIImageView のインスタンスを生成
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    // 配列のindexをcellのindexと同じにする
    NSString *imgName = self.photos[(int)(indexPath.row)];
    // 配列の名前の画像を呼び出す
    UIImage *image = [UIImage imageNamed:imgName];
    // UIImageをimageViewの画像として設定
    imageView.image = image;
    
    UILabel *label = (UILabel *)[cell viewWithTag:2];
    label.text = self.imgTitle[(int)(indexPath.row)];
//    NSLog(imgTitle[(int)(indexPath.row)]);
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
