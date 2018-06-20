//
//  ViewController.m
//  stv_project 2.5.4
//
//  Created by kazua on 2018/02/14.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *cameraView;
@property (weak, nonatomic) UIImage *cameraImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)cameraStart:(id)sender {
    
    // カメラの利用
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 利用可能チェック
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *cameraPicker = [UIImagePickerController new];
        cameraPicker.sourceType = sourceType;
        cameraPicker.delegate   = self;
        
        [self presentViewController:cameraPicker animated:YES completion:nil];
    } else {
        NSLog(@"error1");
    }
}

// 完了後
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    self.cameraImage = [info objectForKey:UIImagePickerControllerOriginalImage];

    [self dismissViewControllerAnimated:YES completion:nil];
    
    // イメージのフォトアルバムへの書き込み
    UIImageWriteToSavedPhotosAlbum(self.cameraImage, self, @selector(savedPic:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)savedPic:(UIImage *)image didFinishSavingWithError:(NSError *)error
     contextInfo:(void *)contextInfo
{
    if (error == nil) {
        self.cameraView.image = self.cameraImage;
    } else {
        NSLog(@"error2");
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
