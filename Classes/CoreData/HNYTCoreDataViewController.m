//
//  HNYTCoreDataViewController.m
//  Demo
//
//  Created by chenzq on 5/6/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYTCoreDataViewController.h"
#import "UserEntity.h"

@interface HNYTCoreDataViewController ()

@end

@implementation HNYTCoreDataViewController

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
    self.myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self createSubView];
//    [self readButton:nil];
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
    
    UIButton *writeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    writeButton.frame = CGRectMake(10, 235, 60, 35);
    [writeButton setTitle:@"write" forState:UIControlStateNormal];
    [writeButton addTarget:self action:@selector(writeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:writeButton];
    
    UIButton *readButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    readButton.frame = CGRectMake(80, 235, 60, 35);
    [readButton setTitle:@"read" forState:UIControlStateNormal];
    [readButton addTarget:self action:@selector(readButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:readButton];
    
    UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    updateButton.frame = CGRectMake(150, 235, 60, 35);
    [updateButton setTitle:@"update" forState:UIControlStateNormal];
    [updateButton addTarget:self action:@selector(writeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:updateButton];
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    deleteButton.frame = CGRectMake(220, 235, 60, 35);
    [deleteButton setTitle:@"delete" forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(writeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteButton];
    
    
}
#pragma mark - IBAction
- (void)writeButton:(UIButton*)sender{
    [self.view endEditing:YES];
    
    UITextField *nameField = (UITextField *)[self.view viewWithTag:1000];
    UITextField *phoneField = (UITextField *)[self.view viewWithTag:1001];
    UITextField *addressField = (UITextField *)[self.view viewWithTag:1002];

    //让CoreData在上下文中创建一个新对象(托管对象)
    UserEntity *entity = [NSEntityDescription insertNewObjectForEntityForName:@"UserEntity" inManagedObjectContext:self.myDelegate.managedObjectContext];
    [entity setName:nameField.text];
    [entity setPhone:phoneField.text];
    [entity setAddress:addressField.text];
    
    NSError *error;
    //托管对象准备好后，调用托管对象上下文的save方法将数据写入数据库
    BOOL isSaveSuccess = [self.myDelegate.managedObjectContext save:&error];
    if (!isSaveSuccess)
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    else
        NSLog(@"Save successful!");

    nameField.text = nil;
    phoneField.text = nil;
    addressField.text = nil;

}
- (void)readButton:(UIButton*)sender{
    //创建取回数据请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //设置要检索哪种类型的实体对象
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserEntity" inManagedObjectContext:self.myDelegate.managedObjectContext];
    //设置请求实体
    [request setEntity:entity];
    //指定对结果的排序方式
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptions = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];

    NSError *error = nil;
    //执行获取数据请求，返回数组
    self.entries = [[self.myDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (self.entries == nil)
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    NSLog(@"%@",self.entries);
}
//更新操作
-(void)updateEntry:(UserEntity *)entity{
    UITextField *nameField = (UITextField *)[self.view viewWithTag:1000];
    UITextField *phoneField = (UITextField *)[self.view viewWithTag:1001];
    UITextField *addressField = (UITextField *)[self.view viewWithTag:1002];
    
    [entity setName:nameField.text];
    [entity setPhone:phoneField.text];
    [entity setAddress:addressField.text];
    
    NSError *error;
    BOOL isUpdateSuccess = [self.myDelegate.managedObjectContext save:&error ];
    if (!isUpdateSuccess)
        NSLog(@"Error:%@,%@",error,[error userInfo]);
}

//删除操作
-(void)deleteEntry:(UserEntity *)entity{
    [self.myDelegate.managedObjectContext deleteObject:entity];
    [self.entries removeObject:entity];
    
    NSError *error;
    if (![self.myDelegate.managedObjectContext save:&error])
        NSLog(@"Error:%@,%@",error,[error userInfo]);
}

@end
