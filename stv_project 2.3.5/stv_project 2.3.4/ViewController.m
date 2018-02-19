//
//  ViewController.m
//  stv_project 2.3.4
//
//  Created by kazua on 2018/02/02.
//  Copyright © 2018年 kazua. All rights reserved.
//

#import "ViewController.h"
#import "RegisterViewController.h"
#import "CustomTableViewCell.h"
#import "FMDB.h"
#import "TodoList.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *todoTable;

@property (strong,nonatomic) NSMutableArray *todoLists;
@property (weak, nonatomic) NSDate *date;
@property (weak, nonatomic) NSString *setDay;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchTodoList];
    
    self.todoTable.delegate = self;
    self.todoTable.dataSource = self;
}

// 遷移
- (IBAction)toRegiBtn:(id)sender {
    // 名前を指定して UIStoryboard を生成
    UIStoryboard *registerStoryboard = [UIStoryboard storyboardWithName:@"Register" bundle:[NSBundle mainBundle]];
    
    // 生成した UIStoryboard から InitialViewController を取得する
    UIViewController *regiView = [registerStoryboard instantiateInitialViewController];
    regiView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController pushViewController:regiView animated:YES];
}

- (void)fetchTodoList {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir = [paths objectAtIndex:0];
    NSString *filePath = [dir stringByAppendingPathComponent:@"tr_todo.db"];
    FMDatabase *fm = [FMDatabase databaseWithPath:filePath];
    
    // Table取得
    NSString *selectTableSql =
    @"SELECT todo_title, limit_date FROM tr_todo WHERE delete_flg = 0";
    
    [fm open];
    
    FMResultSet *results =  [fm executeQuery:selectTableSql];
    self.todoLists = [[NSMutableArray alloc] init];
    
    while ([results next]) {
        TodoList *todoList  = [TodoList new];
        todoList.todo_title = [results stringForColumn:@"todo_title"];
        todoList.limit_date = [results dateForColumn:@"limit_date"];

        [self.todoLists addObject:todoList];
    }
    [results close];
    [fm close];
    
    [self.todoTable reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = @"ToDo List";
    
    return title;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.todoLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomTableViewCell *cell =
        (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    TodoList *todoList = _todoLists[indexPath.row];

    // unixtime -> date
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:@"YYYY-MM-dd"];
    self.date = todoList.limit_date;
    NSString *setDay = [dateFormat stringFromDate:self.date];
    
    cell.readTitle.text = todoList.todo_title;
    cell.readLimit.text = setDay;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
