//
//  ViewController.m
//  stv_project 2.1.16
//
//  Created by kazua on 2018/01/29.
//  Copyright © 2018年 kazua. All rights reserved.


#import "ViewController.h"
#import "PageViewController.h"

@interface ViewController () <UIPageViewControllerDataSource>

@property (nonatomic, strong) NSArray *contentPages;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createPageViewController];
}

- (void)createPageViewController {
    
    self.contentPages = @[@"1", @"2", @"3", @"4", @"5"];
    
    UIPageViewController *pageController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageController"];
    pageController.dataSource = self;
    
    if (self.contentPages.count){
        NSArray *startingViewControllers = @[[self itemControllerForIndex:0]];
        [pageController setViewControllers:startingViewControllers
                                 direction:UIPageViewControllerNavigationDirectionForward
                                  animated:NO
                                completion:nil];
    }
    
    // viewを生成する
    UIPageViewController *pageViewController = pageController;
    [self addChildViewController:pageViewController];
    // viewを追加
    [self.view addSubview:pageViewController.view];
    // viewを確定
    [pageViewController didMoveToParentViewController:self];
}

// pageを戻す時のメソッド
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    PageViewController *itemController = (PageViewController *)viewController;
    
    // 戻るスワイプをした時にページを１枚減らす
    if (itemController.itemIndex > 0){
        return [self itemControllerForIndex:itemController.itemIndex-1];
    }
    return nil;
}

// pageを進めるメソッド
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    PageViewController *itemController = (PageViewController *)viewController;
    
    // 進むスワイプをした時にページを１枚増やす
    if (itemController.itemIndex+1 < self.contentPages.count){
        return [self itemControllerForIndex:itemController.itemIndex+1];
    }
    return nil;
}

- (PageViewController *)itemControllerForIndex:(NSUInteger)itemIndex{
    
    if (itemIndex < self.contentPages.count){
        // .storyboardを読み込み
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PageView" bundle:[NSBundle mainBundle]];
        // viewControllerを読み込み
        PageViewController *pageViewController = [storyboard instantiateViewControllerWithIdentifier:@"ItemController"];
        pageViewController.itemIndex  = itemIndex;
        pageViewController.labelName  = self.contentPages[itemIndex];
        pageViewController.labelCount = self.contentPages.count;
        
        return pageViewController;
    }
    return nil;
}

// ページ数
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.contentPages.count;
}

// 下に出てくる丸の位置
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
