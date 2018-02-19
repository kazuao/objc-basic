//
//  TodoList.h
//  stv_project 2.3.4
//
//  Created by kazua on 2018/02/04.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodoList : NSObject

@property (nonatomic, assign) NSInteger todo_id;
@property (nonatomic,   copy) NSString *todo_title;
@property (nonatomic,   copy) NSString *todo_contents;
@property (nonatomic,   copy) NSDate *created;
@property (nonatomic,   copy) NSDate *modified;
@property (nonatomic,   copy) NSString *limit_date;

@end
