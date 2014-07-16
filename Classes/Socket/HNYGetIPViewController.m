//
//  HNYGetIPViewController.m
//  Demo
//
//  Created by chenzq on 7/16/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYGetIPViewController.h"


@interface HNYGetIPViewController ()

@end

@implementation HNYGetIPViewController

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
    
    UIButton *inIPBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    inIPBtn.frame = CGRectMake(10, 100, self.view.frame.size.width - 20, 35);
    [inIPBtn setTitle:@"GetLocalIP" forState:UIControlStateNormal];
    [inIPBtn addTarget:self action:@selector(inIPBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:inIPBtn];

    UIButton *outIPBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    outIPBtn.frame = CGRectMake(10, 150, self.view.frame.size.width - 20, 35);
    [outIPBtn setTitle:@"GetLocalIP" forState:UIControlStateNormal];
    [outIPBtn addTarget:self action:@selector(outIPBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:outIPBtn];
    

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

#pragma mark - IBAction

- (void)inIPBtn:(UIButton*)sender{
    NSLog(@"macaddress = %@",[HNYGetIPUtils getMacAddress]);
//    NSLog(@"whatismyipdotcom = %@",[self whatismyipdotcom]);
    NSLog(@"localWiFiIPAddress = %@",[HNYGetIPUtils getLocalWiFiIPAddress]);
}

- (void)outIPBtn:(UIButton*)sender{
    
}


+ (NSString*)getStringFormChar:(unsigned char*)uchar{
    NSMutableString *hexString = [NSMutableString string];
    for (int i=0; i<sizeof(uchar); i++)
    {
        [hexString appendFormat:@"%02x ", uchar[i]];
    }
    return hexString;
}
+ (unsigned char )getUnCharFormString:(NSString*)string{
    unsigned char mCode;
    int length = string.length;
    unsigned char sData[length];
    NSArray *arr = [string componentsSeparatedByString:@" "];
    for (int i = 0; i < arr.count ; ++i) {
        sscanf([[arr objectAtIndex:i] UTF8String], "%s", &mCode);
        sData[i] = mCode;
    }
    return *sData;
}

@end
