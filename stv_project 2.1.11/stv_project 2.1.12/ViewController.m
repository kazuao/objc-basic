//
//  ViewController.m
//  stv_project 2.1.12
//
//  Created by kazua on 2018/01/26.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"

typedef NS_ENUM(NSInteger, Class){
    animal = 0,
    fish,
};

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong,nonatomic) NSArray *imgAnimal;
@property (strong,nonatomic) NSArray *imgFish;
@property (strong,nonatomic) NSArray *imgAnimalTitles;
@property (strong,nonatomic) NSArray *imgFishTitles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imgAnimal = @[[UIImage imageNamed:@"6"],
                       [UIImage imageNamed:@"7"],
                       [UIImage imageNamed:@"8"]];
    self.imgFish   = @[[UIImage imageNamed:@"9"],
                       [UIImage imageNamed:@"10"],
                       [UIImage imageNamed:@"11"]];
    
    //プロジェクト内のファイルにアクセスできるオブジェクトを宣言
    NSBundle *bundle = [NSBundle mainBundle];
    //読み込むプロパティリストのファイルパスを指定
    NSString *path = [bundle pathForResource:@"Property List" ofType:@"plist"];
    //プロパティリストの中身データを取得
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *animal = [dic objectForKey:@"animal"];
    NSArray *fish = [dic objectForKey:@"fish"];
    
    //取得できた配列データをメンバ変数に代入
    self.imgAnimalTitles = animal;
    self.imgFishTitles   = fish;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // セクションタイトルの文字列変数を宣言
    NSString *title;
    
    // 表示しているセクションのタイトルを
    switch (section) {
        case fish:
            title = @"fish";
            break;
        case animal:
            title = @"animal";
            break;
        default:
            break;
    }
    return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //データの数によって行数が増える。
    NSInteger rows = 0;
    switch (section) {
        case fish:
            rows = [self.imgFish count];
            break;
        case animal:
            rows = [self.imgAnimal count];
            break;
        default:
            break;
    }
    return rows;
}

//-(CGFloat) tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
//
//    UITableViewCell *cell = (UITableViewCell*)[self tableView:self.myTableView cellForRowAtIndexPath:indexPath];
//
//    return cell.frame.size.height;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomTableViewCell *cell = (CustomTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell"forIndexPath:indexPath];
    
    UIImage *itemImg;
    switch (indexPath.section) {
        case fish:
            itemImg = self.imgFish[indexPath.row];
            break;
        case animal:
            itemImg = self.imgAnimal[indexPath.row];
            break;
        default:
            break;
    }

    NSString *itemName;
    switch (indexPath.section) {
        case fish:
            itemName = self.imgFishTitles[indexPath.row];
            break;
        case animal:
            itemName = self.imgAnimalTitles[indexPath.row];
            break;
        default:
            break;
    }

    cell.myImageView.image = itemImg;
    cell.myImageTitle.text = itemName;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
