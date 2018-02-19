//
//  PostInstagram.m
//  stv_project 2.4.8
//
//  Created by kazua on 2018/02/13.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "PostInstagram.h"

@interface PostInstagram()

- (void)closeView;

@end

@implementation PostInstagram

+ (BOOL)canInstagramOpen {
    
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
    // instagram が　open できれば
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        return YES;
    }
    return NO;
}

- (void)openInstagram {

    // 投稿画像を作る
    // .igo型にする
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/image.igo"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];

    // interactionControllerは直接ファイルフォーマットを処理できないファイルをプレビュー、開く、印刷するviewController
    self.interactionController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    // instagramだけを対象にする場合に記載する
    self.interactionController.UTI = @"com.instagram.exclusivegram";
    self.interactionController.delegate = self;

    BOOL present = [self.interactionController presentOpenInMenuFromRect:self.view.frame inView:self.view animated:YES];
    if (!present) {
        [self closeView];
    }
}

- (void)setImage:(UIImage *)image {
    
    // NSDataに変換する　0.75fは画像のクオリティ指数
    NSData *imageData = UIImageJPEGRepresentation(image, 0.75f);
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/image.igo"];
    [imageData writeToFile:filePath atomically:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self openInstagram];
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller
           didEndSendingToApplication:(NSString *)application
{
    [self closeView];
}

- (void)closeView {
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    self.interactionController.delegate = nil;
}

#pragma mark - UIDocumentInteractionControllerDelegate

- (void)documentInteractionController:(UIDocumentInteractionController *)controller
        willBeginSendingToApplication:(NSString *)application
{
}

- (void) documentInteractionControllerDidDismissOpenInMenu: (UIDocumentInteractionController *) controller {
    // キャンセルで閉じたとき
    [self closeView];
}

@end
