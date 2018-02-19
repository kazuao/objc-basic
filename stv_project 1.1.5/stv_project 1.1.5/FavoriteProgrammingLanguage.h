//
//  FavoriteProgrammingLanguage.h
//  stv-project 1.1.5
//
//  Created by kazua on 2018/01/18.
//  Copyright © 2018年 kazua. All rights reserved.
//
#import <Foundation/Foundation.h>

// デリゲートプロトコル
@protocol FavoriteProgrammingLanguageDelegate <NSObject>
@optional
-(void)canDoObjC;
@end

@interface FavoriteProgrammingLanguage : NSObject
@property (nonatomic, weak)
        id<FavoriteProgrammingLanguageDelegate> delegate;
        //memo ↑デリゲートプロパティにFPLDプロトコルを付与する

-(void)joinIntern;
@end
