//
//  Account.h
//  stv-project 1.1.5
//
//  Created by kazua on 2018/01/18.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavoriteProgrammingLanguage.h"

                        //memo ↓採用するプロトコル 入れなくてもエラーはでない(警告のみ
@interface Account:NSObject <FavoriteProgrammingLanguageDelegate>

@property NSString  *name;
@property NSInteger age;
@property NSString  *sex;
@property NSString  *strongLang;

-(id)initWithName:(NSString *)name
              age:(NSInteger)age
              sex:(NSString*)sex
       strongLang:(NSString*)strongLang;

-(void)printAccount;


@end
