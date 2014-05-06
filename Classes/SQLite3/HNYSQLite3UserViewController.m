//
//  HNYSQLite3UserViewController.m
//  Demo
//
//  Created by chenzq on 5/6/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYSQLite3UserViewController.h"
#import "sqlite3.h"

@interface HNYSQLite3UserViewController ()

@end

@implementation HNYSQLite3UserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createSubView];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - create sub views
- (void)createSubView{
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 60, 35)];
    nameLabel.text = @"名字:";
    nameLabel.backgroundColor = [UIColor clearColor];
    
    UITextField *nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(75, 100, 150, 35)];
    nameTextField.placeholder = @"请输入名字";
    nameTextField.tag = 1000;
    [self.view addSubview:nameLabel];
    [self.view addSubview:nameTextField];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 145, 60, 35)];
    phoneLabel.text = @"号码:";
    phoneLabel.backgroundColor = [UIColor clearColor];
    
    UITextField *phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(75, 145, 150, 35)];
    phoneTextField.placeholder = @"请输入号码";
    phoneTextField.tag = 1001;
    [self.view addSubview:phoneLabel];
    [self.view addSubview:phoneTextField];
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 190, 60, 35)];
    addressLabel.text = @"地址:";
    addressLabel.backgroundColor = [UIColor clearColor];
    
    UITextField *addressTextField = [[UITextField alloc] initWithFrame:CGRectMake(75, 190, 150, 35)];
    addressTextField.placeholder = @"请输入地址";
    addressTextField.tag = 1002;
    [self.view addSubview:addressLabel];
    [self.view addSubview:addressTextField];
    
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    saveButton.frame = CGRectMake(10, 235, 60, 35);
    [saveButton setTitle:@"save" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    searchButton.frame = CGRectMake(150, 235, 60, 35);
    [searchButton setTitle:@"search" forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
    
    
}

#pragma mark - IBAction
- (void)saveButton:(UIButton*)sender{
    [self.view endEditing:YES];
    //插入数据
    UITextField *nameField = (UITextField *)[self.view viewWithTag:1000];
    UITextField *phoneField = (UITextField *)[self.view viewWithTag:1001];
    UITextField *addressField = (UITextField *)[self.view viewWithTag:1002];
    if (nameField.text.length == 0 || phoneField.text.length == 0 || nameField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请把信息填写完整" message:nil delegate:self cancelButtonTitle:@"sure" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    sqlite3 *database;
    //打开数据库，如果没有就创建
    if (sqlite3_open([self.databaseFilePath UTF8String], &database) == SQLITE_OK) {
        //创建数据库表USER
        //        NSString *createSQL = @"CREATE TABLE IF NOT EXISTS USER (NAME TEXT PRIMARY KEY, PHONE TEXT,ADDRESS TEXT);";
        NSString *createSQL = @"create table if not exists user (name text primary key, phone text, address text);";
        char *errorMsg;
        if (sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errorMsg) == SQLITE_OK) {
            
            char *update = "INSERT OR REPLACE INTO USER (NAME, PHONE,ADDRESS) VALUES (?,?,?);";
            sqlite3_stmt *stmt;
            if (sqlite3_prepare_v2(database, update, -1, &stmt, nil) == SQLITE_OK) {
                sqlite3_bind_text(stmt, 1, [nameField.text UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 2, [phoneField.text UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 3, [addressField.text UTF8String], -1, NULL);
            }
            char *errorMsg = NULL;
            if (sqlite3_step(stmt) == SQLITE_DONE){
                NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:nameField.text,@"name",phoneField.text,@"phone",addressField.text,@"address", nil];
                [self.delegate viewController:self actionWitnInfo:dictionary];
                nameField.text = nil;
                phoneField.text = nil;
                addressField.text = nil;
            }else
                NSAssert(0, @"更新数据库表FIELDS出错: %s", errorMsg);
            sqlite3_finalize(stmt);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            sqlite3_close(database);
            NSAssert(0, @"创建数据库表错误: %s", errorMsg);
        }
    }
    else{
        sqlite3_close(database);
        NSLog(@"打开数据库失败");
    }
}
- (void)searchButton:(UIButton*)sender{
    //打开数据库
    sqlite3 *database;
    if (sqlite3_open([self.databaseFilePath UTF8String], &database) == SQLITE_OK){
        UITextField *nameField = (UITextField *)[self.view viewWithTag:1000];
        UITextField *phoneField = (UITextField *)[self.view viewWithTag:1001];
        UITextField *addressField = (UITextField *)[self.view viewWithTag:1002];
        
        NSString *querySQL = [NSString stringWithFormat:@"SELECT NAME, PHONE, ADDRESS FROM user where name=\"%@\"",nameField.text];
        
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [querySQL UTF8String], -1, &statement, nil) == SQLITE_OK) {
            //依次读取数据库表格FIELDS中每行的内容，并显示在对应的TextField
            if (sqlite3_step(statement) == SQLITE_ROW) {
                //获得数据
                char *nameData = (char *)sqlite3_column_text(statement, 0);
                char *phoneData = (char *)sqlite3_column_text(statement, 1);
                char *addressData = (char *)sqlite3_column_text(statement, 2);
                //设置文本
                
                nameField.text = [NSString stringWithUTF8String:nameData];
                phoneField.text = [NSString stringWithUTF8String:phoneData];
                addressField.text = [NSString stringWithUTF8String:addressData];
            }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(database);
    }
    
    
}


@end
