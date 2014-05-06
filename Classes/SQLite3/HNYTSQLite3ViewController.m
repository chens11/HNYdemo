//
//  HNYTSQLite3ViewController.m
//  Demo
//
//  Created by chenzq on 5/5/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYTSQLite3ViewController.h"
#import "sqlite3.h"
#import "HNYSQLite3UserViewController.h"


#define HNYDatabaseName @"database.sqlite3"

@interface HNYTSQLite3ViewController ()<UITableViewDataSource,UITableViewDelegate,PublicDelegate>
@property (nonatomic,strong) NSMutableArray *list;

@end

@implementation HNYTSQLite3ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.list = [NSMutableArray array];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [paths objectAtIndex:0];
        NSString *dataBasePath = [path stringByAppendingPathComponent:HNYDatabaseName];
        self.databaseFilePath = dataBasePath;

        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupBarItem];
    [self createTable];
    self.view.backgroundColor = [UIColor whiteColor];
}
#pragma mark - create sub views

- (void)setupBarItem{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addUser:)];
}
- (void)createTable{
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    table.tag = 1111;
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
    
}
#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"UITableSqlite2Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentify];
    }
    NSDictionary *dictionary = [self.list objectAtIndex:indexPath.row];
    cell.textLabel.text = [dictionary objectForKey:@"name"];
    cell.detailTextLabel.text = [dictionary objectForKey:@"phone"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

#pragma mark - IBAction
- (void)addUser:(UIBarButtonItem*)sender{
    HNYSQLite3UserViewController *controller = [[HNYSQLite3UserViewController alloc] init];
    controller.delegate = self;
    controller.databaseFilePath = self.databaseFilePath;
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark - PublicDelegate
- (void)viewController:(HNYSQLite3UserViewController *)vController actionWitnInfo:(NSDictionary *)info{
    UITableView *table = (UITableView*)[self.view viewWithTag:1111];
    [table reloadData];
}

- (NSMutableArray *)list{
    sqlite3 *database;
    NSMutableArray *array = [NSMutableArray array];
    if (sqlite3_open([self.databaseFilePath UTF8String], &database) == SQLITE_OK) {
        NSString *querrySql = @"select name, phone, address from user";
        sqlite3_stmt *stmt;
        if (sqlite3_prepare_v2(database, [querrySql UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
                NSString *phone = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
                NSString *address = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
                [array addObject:[NSDictionary dictionaryWithObjectsAndKeys:name,@"name",phone,@"phone",address,@"address", nil]];
            }
        }
        
    }
    return array;
}
@end
