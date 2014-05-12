//
//  HNYViewController.m
//  SideBar
//
//  Created by chenzq on 5/12/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYViewController.h"

@interface HNYViewController ()

@end

@implementation HNYViewController

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
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStyleBordered target:self action:@selector(clickLeftBarButton:)];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStyleBordered target:self action:@selector(clickRightBarButton:)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;

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

#pragma mark - IBAciton 

- (void)clickLeftBarButton:(UIBarButtonItem*)sender{
    [self.delegate viewController:self actionWitnInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"leftBarButton",@"buttonClick", nil]];
}
- (void)clickRightBarButton:(UIBarButtonItem*)sender{
    [self.delegate viewController:self actionWitnInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"rightBarButton",@"buttonClick", nil]];
}

@end
