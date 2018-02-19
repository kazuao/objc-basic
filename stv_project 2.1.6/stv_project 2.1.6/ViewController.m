//
//  ViewController.m
//  stv_project 2.1.6
//
//  Created by kazua on 2018/01/21.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

// webロード時のインジケータを回す処理（左上のくるくる
- (void)webViewStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
// 上記インジケータストップ
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

// オフライン時の処理
- (void)offlineAlert {
    UIAlertController *nosignalAlert = [UIAlertController
                                        alertControllerWithTitle:@"オフライン"
                                        message:@"ネットワークはオフラインです。"
                                        preferredStyle:UIAlertControllerStyleAlert];
    
    [nosignalAlert addAction:[UIAlertAction
                              actionWithTitle:@"OK"
                              style:UIAlertActionStyleDefault
                              handler:nil]];
    [self presentViewController:nosignalAlert animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // デリゲートの設定
    self.webView.delegate = self;
}

//memo 画面アニメーション終了後の処理の記述
//     DidLoadだとヒエラルキーエラーがでる
- (void)viewDidAppear:(BOOL)animated {
    // urlの指定
    NSURL *url = [NSURL URLWithString:@"http://www.apple.com/jp"];
    NSURLRequest *urlReq = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlReq];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    // オフライン時の処理
    [self offlineAlert];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
