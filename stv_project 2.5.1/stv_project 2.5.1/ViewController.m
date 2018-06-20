//
//  ViewController.m
//  stv_project 2.5.1
//
//  Created by kazua on 2018/02/13.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"
@import MessageUI.MFMailComposeViewController;

@interface ViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation ViewController

-(IBAction) doSendEmail:(id) sender {
    
    Class mail = (NSClassFromString(@"MFMailComposeViewController"));
    if (mail) {
        //メールの設定がされているかどうかチェック
        if ([mail canSendMail]) {
            [self showComposerSheet];
            NSLog(@"aa");
        } else {
            NSLog(@"メールが起動出来ません！");
        }
    }
}

-(void) showComposerSheet {
    
    MFMailComposeViewController *mail = [MFMailComposeViewController new];
    mail.mailComposeDelegate = self;
    
    // 初期入力
    [mail setSubject:@"アプリからメール送信"];
    [mail setMessageBody:@"ここに本文を入力してください。" isHTML:NO];
    
    [self presentViewController:mail animated:YES completion:nil];
}

// メーラーを操作した時の操作分岐
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{    
    switch (result){
        // キャンセルした場合
        case MFMailComposeResultCancelled:
            break;
        // 保存した場合
        case MFMailComposeResultSaved:
            break;
        // 送信した場合
        case MFMailComposeResultSent:
            break;
        // 失敗した場合
        case MFMailComposeResultFailed:
            NSLog(@"メールの送信に失敗しました。");
            break;
        default:
            break;
    }
    // ないと閉じない
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
