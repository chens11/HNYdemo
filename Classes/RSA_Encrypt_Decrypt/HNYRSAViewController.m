//
//  HNYRSAViewController.m
//  Demo
//
//  Created by chenzq on 6/27/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYRSAViewController.h"
#import "RSA.h"

@interface HNYRSAViewController ()
@property (nonatomic,strong) UITextField *enField;
@property (nonatomic,strong) UITextField *deField;
@property (nonatomic,strong) UIButton *generateBtn;
@property (nonatomic,strong) UIActivityIndicatorView *activeIndicator;


@end

@implementation HNYRSAViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    self.enField = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width - 20, 35)];
    self.enField.placeholder = @"请输入需要加密的数据";
    self.enField.tag = 1002;
    [self.view addSubview:self.enField];
    
    self.deField = [[UITextField alloc] initWithFrame:CGRectMake(10, 150, self.view.frame.size.width - 20, 35)];
    self.deField.placeholder = @"显示解密数据";
    self.deField.tag = 1003;
    self.deField.enabled = NO;
    [self.view addSubview:self.deField];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addButton.frame = CGRectMake(10, 200, self.view.frame.size.width - 20, 35);
    [addButton setTitle:@"add" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(encrypt:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)encrypt:(id)sender{
    [self.view endEditing:YES];
    [self.activeIndicator startAnimating];
    
    RSA *rsa = [RSA shareInstance];
    [rsa generateKeyPairRSACompleteBlock:^{
        if (self.enField.text) {
            //encrypt
            NSData *encryptData = [rsa RSA_EncryptUsingPublicKeyWithData:[self.enField.text dataUsingEncoding:NSUTF8StringEncoding]];
            
            //decrypt
            NSData *decryptData = [rsa RSA_DecryptUsingPrivateKeyWithData:encryptData];
            NSString *originString = [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
            
            self.deField.text = originString;
            
            [self.activeIndicator stopAnimating];
        }
    }];
}

@end
