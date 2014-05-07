//
//  HNYTPListViewController.m
//  Demo
//
//  Created by chenzq on 5/6/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYTPListViewController.h"

#define KPLIST @"HNYTPlist.plist"

@interface HNYTPListViewController ()

@end

@implementation HNYTPListViewController

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
    [self readButton:nil];
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
    
    
}
#pragma mark - IBAction
- (void)writeButton:(UIButton*)sender{
    [self.view endEditing:YES];
    UITextField *nameField = (UITextField *)[self.view viewWithTag:1000];
    UITextField *phoneField = (UITextField *)[self.view viewWithTag:1001];
    UITextField *addressField = (UITextField *)[self.view viewWithTag:1002];

    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject: nameField.text];
    [array addObject: phoneField.text];
    [array addObject: addressField.text];
    [array writeToFile:[self dataFilePath] atomically:YES];
    
    nameField.text = nil;
    phoneField.text = nil;
    addressField.text = nil;
}
- (void)readButton:(UIButton*)sender{
    UITextField *nameField = (UITextField *)[self.view viewWithTag:1000];
    UITextField *phoneField = (UITextField *)[self.view viewWithTag:1001];
    UITextField *addressField = (UITextField *)[self.view viewWithTag:1002];
    NSString *filePath = [self dataFilePath];
    //检查数据文件是否存在
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
        nameField.text = [array objectAtIndex:0];
        phoneField.text = [array objectAtIndex:1];
        addressField.text = [array objectAtIndex:2];
    }
}
#pragma mark - instance fun
- (NSString*)dataFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return [path stringByAppendingPathComponent:KPLIST];
}
@end
