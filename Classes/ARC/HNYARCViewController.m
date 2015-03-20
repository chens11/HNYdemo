//
//  HNYARCViewController.m
//  Demo
//
//  Created by czq on 3/20/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "HNYARCViewController.h"

@interface HNYARCViewController ()

@end

@implementation HNYARCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    id __weak obj1;
    {
        id obj = [[NSObject alloc] init];
        obj1 = obj;
        NSLog(@"%@",obj1);
    }
    NSLog(@"%@",obj1);

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
