//
//  FavoriteProgrammingLanguage.m
//  stv-project 1.1.5
//
//  Created by kazua on 2018/01/18.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "FavoriteProgrammingLanguage.h"

@implementation FavoriteProgrammingLanguage

-(void)joinIntern{
    //memo メソッドを定義しつつ、プロパティに付与したプロトコルを埋め込む
    if ([self.delegate respondsToSelector:@selector(canDoObjC)]){
        NSLog(@"インターンに参加する！");
        [self.delegate canDoObjC];
    }
}

@end
