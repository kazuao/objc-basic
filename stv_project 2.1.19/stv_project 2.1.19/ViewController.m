//
//  ViewController.m
//  stv_project 2.1.19
//
//  Created by kazua on 2018/01/31.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *myText;
@property (weak, nonatomic) NSString *passString;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)pushBtn:(id)sender {
    
    UIStoryboard *secondStory = [UIStoryboard storyboardWithName:@"Second" bundle:[NSBundle mainBundle]];
    // storyboard
    SecondViewController *sv = [secondStory instantiateInitialViewController];
    
    sv.msgValue = self.myText.text;
    
    [self.navigationController pushViewController:sv animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
