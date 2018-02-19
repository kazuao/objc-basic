//
//  ViewController.m
//  stv_project 2.4.6
//
//  Created by kazua on 2018/02/13.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"
@import Photos;
@import FBSDKShareKit.FBSDKSharePhoto;
@import FBSDKShareKit.FBSDKSharePhotoContent;
@import FBSDKShareKit.FBSDKShareDialog;

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property FBSDKSharePhotoContent *content;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)imgPickBtn:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController *imagePickerController = [UIImagePickerController new];
        // 起動した際に何を開くかの選択
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 取得後編集するかどうか
        imagePickerController.allowsEditing = YES;
        imagePickerController.delegate = self;
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

// 選択をすると自動的に呼ばれる
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // まずはmodalを閉じないとhierarchy errorがでる
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 選択したイメージを受け取る
    UIImage *image = info[UIImagePickerControllerOriginalImage];

    FBSDKSharePhoto *photo = [FBSDKSharePhoto new];
    photo.image = image;
    photo.userGenerated = YES;
    self.content = [FBSDKSharePhotoContent new];
    self.content.photos = @[photo];
    
    [FBSDKShareDialog showFromViewController:self
                                 withContent:self.content
                                    delegate:nil];
}

// キャンセル押した時のメソッド
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
