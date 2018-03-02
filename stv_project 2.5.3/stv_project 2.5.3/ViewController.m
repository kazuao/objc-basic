//
//  ViewController.m
//  stv_project 2.5.3
//
//  Created by kazua on 2018/02/14.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"
@import AVFoundation;

@interface ViewController () <AVCapturePhotoCaptureDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *videoPreviewView;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (nonatomic) AVCaptureSession  *captureSesssion;
@property AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic) AVCapturePhotoOutput *stillImageOutput;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.captureSesssion = [AVCaptureSession new]; // AVCaptureSessionは入力から出力へのデータフロー調整する
    self.captureSesssion.sessionPreset = AVCaptureSessionPreset1920x1080; // クオリティの設定
    self.stillImageOutput = [AVCapturePhotoOutput new]; // 出力先の設定用のインスタンス
    // デバイスの指定
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = [NSError new];
    
    @try {
        AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
        
        if ([self.captureSesssion canAddInput:input]) {
            [self.captureSesssion addInput:input];
            if ([self.captureSesssion canAddOutput:self.stillImageOutput]) {
                [self.captureSesssion addOutput:self.stillImageOutput];
                [self.captureSesssion startRunning];
                
                // カメラに合わせて動くview
                AVCaptureVideoPreviewLayer *captureVideoLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSesssion];
                captureVideoLayer.frame = self.videoPreviewView.bounds;
                captureVideoLayer.videoGravity = AVLayerVideoGravityResizeAspect;
                [self.videoPreviewView.layer addSublayer:captureVideoLayer];
            }
        }
    } @catch (NSException *ex) {
        NSLog(@"%@",error);
    }
}

//撮影ボタンを押した際に呼ばれるメソッド。
- (IBAction)takePhoto:(UIButton *)sender {
    
    AVCapturePhotoSettings *settings = [AVCapturePhotoSettings new];
    settings.flashMode = AVCaptureFlashModeAuto;
    [self.stillImageOutput capturePhotoWithSettings:settings delegate:self];
}

// 写真キャプチャの結果を
- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(NSError *)error {
    
    // 適した形に自動的に変換してくれる
    NSData *imageData = [photo fileDataRepresentation];
    UIImage *resultImage = [UIImage imageWithData:imageData];

    self.photoView.image = resultImage;
    UIImageWriteToSavedPhotosAlbum(resultImage, nil, nil, nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
