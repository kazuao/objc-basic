//
//  ViewController.m
//  stv_project 2.5.5
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
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
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

// saveに失敗した際の処理
- (void)savedPic:(UIImage *)image didFinishSavingWithError:(NSError *)error
     contextInfo:(void *)contextInfo
{
    if (!error) {
        self.cameraView.image = self.cameraImage;
    } else {
        NSLog(@"error2");
    }
}

// キャンセル時の処理
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)changeFilter:(id)sender {
    
    // ビットマップ形式に一度変換する　しないとなぜかimageViewに表示する際に回転する
    UIGraphicsBeginImageContext(self.cameraImage.size);
    [self.cameraImage drawInRect:CGRectMake(0, 0, self.cameraImage.size.width, self.cameraImage.size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // UIImageをCIImageに変換
    CIImage *filteredImage = [[CIImage alloc] initWithCGImage:image.CGImage];
    
    // CIFilterを作成
    CIFilter *filter = [CIFilter filterWithName:@"CIMinimumComponent"];
    [filter setValue:filteredImage forKey:@"inputImage"];
    
    // フィルタ後の画像を取得
    filteredImage = filter.outputImage;
    
    //CIImageをUIImageに変換する
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [ciContext createCGImage:filteredImage fromRect:[filteredImage extent]];
    UIImage *outputImage = [UIImage imageWithCGImage:imageRef scale:1.0f orientation:UIImageOrientationUp];
    CGImageRelease(imageRef);
    
    self.cameraView.image = outputImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
