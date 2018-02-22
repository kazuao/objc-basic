//
//  CalendarViewController.m
//  test_1month
//
//  Created by kazua on 2018/02/22.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation CalendarViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}


@end
