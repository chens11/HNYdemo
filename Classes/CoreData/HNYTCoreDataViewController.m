//
//  HNYTCoreDataViewController.m
//  Demo
//
//  Created by chenzq on 5/6/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYTCoreDataViewController.h"

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
    
    
}
#pragma mark - IBAction
- (void)writeButton:(UIButton*)sender{
    [self.view endEditing:YES];

    id appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error;
    for(int i = 1000; i <= 1002; i++) {
        UITextField *textField = (UITextField *)[self.view viewWithTag:i];
        //创建提取请求
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        //创建实体描述并关联到请求
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Line"
                                                             inManagedObjectContext:context];
        [request setEntity:entityDescription];
        
        //设置检索数据的条件
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"(lineNum = %d)", i];
        [request setPredicate:pred];
        
        NSManagedObject *theLine = nil;
        ////检查是否返回了标准匹配的对象，如果有则加载它，如果没有则创建一个新的托管对象来保存此字段的文本
        NSArray *objects = [context executeFetchRequest:request error:&error];
        if(!objects) {
            NSLog(@"There was an error");
        }
        //if(objects.count > 0) {
        //  theLine = [objects objectAtIndex:0];
        //} else {
        //创建一个新的托管对象来保存此字段的文本
        theLine = [NSEntityDescription insertNewObjectForEntityForName:@"Line"
                                                inManagedObjectContext:context];
        [theLine setValue:[NSNumber numberWithInt:i] forKey:@"lineNum"];
        [theLine setValue:textField.text forKey:@"lineText"];
        //}
    }
    //通知上下文保存更改
    [context save:&error];
    UITextField *nameField = (UITextField *)[self.view viewWithTag:1000];
    UITextField *phoneField = (UITextField *)[self.view viewWithTag:1001];
    UITextField *addressField = (UITextField *)[self.view viewWithTag:1002];

    nameField.text = nil;
    phoneField.text = nil;
    addressField.text = nil;

}
- (void)readButton:(UIButton*)sender{
    id appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    //创建一个实体描述
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Line" inManagedObjectContext:context];
    //创建一个请求，用于提取对象
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    //检索对象
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    if(!objects) {
        NSLog(@"There was an error!");
    }
    for(NSManagedObject *obj in objects) {
        NSNumber *lineNum = [obj valueForKey:@"lineNum"];
        NSString *lineText = [obj valueForKey:@"lineText"];
        UITextField *textField = (UITextField*)[self.view viewWithTag:[lineNum intValue]];
        textField.text = lineText;
    }
}
-(void) applicationWillResignActive:(NSNotification *)notification {
    
}

@end
