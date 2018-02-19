//
//  ViewController.m
//  stv_project 2.4.7
//
//  Created by kazua on 2018/02/13.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"
@import TwitterKit;

@interface ViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self tweetMain];
}

// tokenチェック
- (void)tweetMain {
    
    // Twitter 認証トークンのチェック
    if ([[Twitter sharedInstance].sessionStore hasLoggedInUsers]) { // 認証トークンあり
        [self imgTweet];
        
    } else { // 認証トークンなし
        // Twitterログイン
        [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
            if (session) { // ログイン OK
                NSLog(@"signed in as %@", [session userName]);
                
                [self imgTweet];
                
            } else { // ログイン キャンセル
                NSLog(@"error: %@", [error localizedDescription]);
            }
        }];
    }
}

// UIImagePickerController使う
- (void)imgTweet {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController *imagePickerController = [UIImagePickerController new];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.allowsEditing = YES;
        imagePickerController.delegate = self;
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}
// 画像取得後の処理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // Twitter投稿データ編集
    TWTRComposer *composer = [TWTRComposer new];
    [composer setText:@"testtest"];
    [composer setImage:image];
    [composer setURL:[NSURL URLWithString:@"https://yahoo.co.jp"]];
    
    // Twitter投稿画面表示
    [composer showFromViewController:self completion:^(TWTRComposerResult result) {
        if (result == TWTRComposerResultCancelled) { // キャンセル
            NSLog(@"Tweet composition cancelled");
        }
        else {
            NSLog(@"Sending Tweet!");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
