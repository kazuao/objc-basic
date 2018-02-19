//
//  ViewController.m
//  stv_project 2.4.8
//
//  Created by kazua on 2018/02/13.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"
#import "PostInstagram.h"

@interface ViewController ()
<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIDocumentInteractionControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self imgPost];
}

- (void)imgPost {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController *imagePickerController = [UIImagePickerController new];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.allowsEditing = YES;
        imagePickerController.delegate = self;
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // カメラロールから画像を取得したらinstagramのURL Schemeを起動する
    if ([PostInstagram canInstagramOpen]) {
        
        PostInstagram *instagramViewController = [[PostInstagram alloc] init];
        [instagramViewController setImage:image];
        [self.view addSubview:instagramViewController.view];
        [self addChildViewController:instagramViewController];
        
    } else {
        NSLog(@"できないよ！");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
