//
//  ViewController.m
//  stv_project 2.1.10
//
//  Created by kazua on 2018/01/26.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *cellTable;

@property (nonatomic) NSArray *animalName;
@property (nonatomic) NSArray *animalImg;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Assetから写真をarrayに代入
    self.animalImg = @[[UIImage imageNamed:@"1"],
                       [UIImage imageNamed:@"2"],
                       [UIImage imageNamed:@"3"]];
    
    // plistとbundleする
    NSBundle *bundle  = [NSBundle mainBundle];
    // ファイルパスを通す
    NSString *path    = [bundle pathForResource:@"animalList" ofType:@"plist"];
    // plistのデータを取得
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *animal   = [dic objectForKey:@"animal"];
    // インスタンス変数に代入する
    self.animalName = animal;
}

// cellを可変にする
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[self tableView:self.cellTable cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
}

// セクションの数を指定
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

// セルの数を指定 要素の数によって可変にする
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.animalImg count];
}

// 各セルの要素を指定 tagで指定する
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // テーブルセルの IDで インスタンスを生成
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    UIImage *img = self.animalImg[indexPath.row];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    imageView.image = img;
    
    UILabel *label = (UILabel *)[cell viewWithTag:2];
    label.text = self.animalName[indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
