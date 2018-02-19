//
//  ViewController.m
//  stv_project 2.1.19
//
//  Created by kazua on 2018/01/31.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *myText;
@property (weak, nonatomic) NSString *passString;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)pushBtn:(id)sender {
    // サブ画面のビューコントローラを取得
    SecondViewController *sv = [[SecondViewController alloc]init];
    UIStoryboard *secondStory = [UIStoryboard storyboardWithName:@"Second" bundle:[NSBundle mainBundle]];
    // storyboard
    sv = [secondStory instantiateInitialViewController];
    
    sv.msgValue = self.myText.text;
    
    [self.navigationController pushViewController:sv animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//AppDelegate *appDelegate;
//appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//singleView.text = appDelegate.singleString;

@end
