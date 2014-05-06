//
//  HNYTArchivingViewController.m
//  Demo
//
//  Created by chenzq on 5/6/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYTArchivingViewController.h"
#import "HNYUser.h"


@interface HNYTArchivingViewController ()

@end

@implementation HNYTArchivingViewController

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
    [self decodeButton:nil];
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
    
    UIButton *encodeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    encodeButton.frame = CGRectMake(10, 235, 60, 35);
    [encodeButton setTitle:@"encode" forState:UIControlStateNormal];
    [encodeButton addTarget:self action:@selector(encodeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:encodeButton];
    
    UIButton *decodeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    decodeButton.frame = CGRectMake(80, 235, 60, 35);
    [decodeButton setTitle:@"decode" forState:UIControlStateNormal];
    [decodeButton addTarget:self action:@selector(decodeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:decodeButton];
    
    
}

#pragma mark - IBAction
- (void)encodeButton:(UIButton*)sender{
    [self.view endEditing:YES];
    UITextField *nameField = (UITextField *)[self.view viewWithTag:1000];
    UITextField *phoneField = (UITextField *)[self.view viewWithTag:1001];
    UITextField *addressField = (UITextField *)[self.view viewWithTag:1002];
    
    HNYUser *user = [[HNYUser alloc] init];
    user.name = nameField.text;
    user.address = addressField.text;
    user.phone = phoneField.text;
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:user forKey:@"user"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];

    nameField.text = nil;
    phoneField.text = nil;
    addressField.text = nil;
    
}

- (void)decodeButton:(UIButton*)sender{
    UITextField *nameField = (UITextField *)[self.view viewWithTag:1000];
    UITextField *phoneField = (UITextField *)[self.view viewWithTag:1001];
    UITextField *addressField = (UITextField *)[self.view viewWithTag:1002];

    NSString *filePath = [self dataFilePath];
    //检查数据文件是否存在
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        //从文件获取用于解码的数据
        NSData *data = [[NSMutableData alloc] initWithContentsOfFile:[self dataFilePath]];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        HNYUser *user = [unarchiver decodeObjectForKey:@"user"];
        [unarchiver finishDecoding];
        
        nameField.text = user.name;
        phoneField.text = user.phone;
        addressField.text = user.address;
    }

}
#pragma makr - instance fun
//数据文件的完整路径
- (NSString *)dataFilePath {
    //检索Documents目录路径。第二个参数表示将搜索限制在我们的应用程序沙盒中
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //每个应用程序只有一个Documents目录
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //创建文件名
    return [documentsDirectory stringByAppendingPathComponent:@"user"];
}


@end
