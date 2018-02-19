//
//  Account.m
//  stv_project 1.1.4
//
//  Created by kazua on 2018/01/18.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "Account.h"

@implementation Account

// 初期化をしている
-(id)initWithName:(NSString *)name
              age:(NSInteger)age
              sex:(NSString*)sex
       strongLang:(NSString*)strongLang {
    if(self = [super init]){
        self.name       = name;
        self.age        = age;
        self.sex        = sex;
        self.strongLang = strongLang;
    }
    return self;
}

-(void)printAccount{
    if ([self.sex isEqual: @"man"]){
        NSLog(@"%@くんは、%@が得意な%ld歳です。", self.name, self.strongLang, self.age);
    }else{
        NSLog(@"%@さんは、%@が得意な%ld歳です。", self.name, self.strongLang, self.age);
    }
}

@end
