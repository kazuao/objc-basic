//
//  PostInstagram.h
//  stv_project 2.4.8
//
//  Created by kazua on 2018/02/13.
//  Copyright © 2018年 kazua. All rights reserved.
//

@import UIKit;

@interface PostInstagram : UIViewController <UIDocumentInteractionControllerDelegate>

+ (BOOL)canInstagramOpen;
- (void)setImage:(UIImage *)image;

@property (nonatomic, retain) UIDocumentInteractionController *interactionController;

@end
