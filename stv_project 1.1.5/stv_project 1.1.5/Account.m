//
//  Account.m
//  stv-project 1.1.5
//
//  Created by kazua on 2018/01/18.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "Account.h"

@implementation Account 

// 初期化をしている
- (id)initWithName:(NSString *)name age:(NSInteger)age sex:(NSString*)sex strongLang:(NSString*)strongLang {
    
    if(self = [super init]){
        self.name       = name;
        self.age        = age;
        self.sex        = sex;
        self.strongLang = strongLang;
    }
    return self;
}

- (void)printAccount {
    
    if ([self.sex isEqual: @"man"]) {
        NSLog(@"%@君は、%@が得意な%ld歳です。",self.name, self.strongLang, self.age);
        
    } else {
        NSLog(@"%@さんは、%@が得意な%ld歳です。",self.name, self.strongLang, self.age);
    }
    
    // instance化&methodの使用
    FavoriteProgrammingLanguage *favoriteProgrammingLanguage = [FavoriteProgrammingLanguage new];
    favoriteProgrammingLanguage.delegate = self;
    [favoriteProgrammingLanguage joinIntern];
}

// delegate method
- (void)canDoObjC {
    if ([self.sex isEqual: @"man"]) {
        NSLog(@"%@君はObjective-Cができるよ！", self.name);
        
    }else{
        NSLog(@"%@さんはObjective-Cができるよ！", self.name);
    }
}

@end
