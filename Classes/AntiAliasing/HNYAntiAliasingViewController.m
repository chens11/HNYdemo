//
//  HNYAntiAliasingViewController.m
//  Demo
//
//  Created by zq chen on 4/17/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "HNYAntiAliasingViewController.h"
#import "HNYLabel.h"

@interface HNYAntiAliasingViewController (){
    UILabel *label;
    UILabel *label1;
}

@end

@implementation HNYAntiAliasingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0.132423, 100.33333, self.view.frame.size.width, 400);
//    btn.frame = CGRectMake(0, 100, self.view.frame.size.width, 400);
    [btn addTarget:self action:@selector(toucheBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    label = [[HNYLabel alloc] initWithFrame:CGRectMake(10, 10, 200.3243, 30.432432)];
    label = [[HNYLabel alloc] initWithFrame:CGRectMake(10, 10.6, 200.234, 30.343)];
    label.font = [UIFont boldSystemFontOfSize:18];
    label.text = @"测测擦擦擦擦擦擦擦擦擦擦";
    [btn addSubview:label];
    
    label1 = [[HNYLabel alloc] initWithFrame:CGRectMake(10., 33.4, 200.432, 30.33)];
    label1.font = [UIFont boldSystemFontOfSize:18];
    label1.text = @"测测擦擦擦擦擦擦擦擦擦擦";
    [btn addSubview:label1];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    float offerSetX = self.frame.origin.x - (pointFromWindow.x - (int)pointFromWindow.x);
//    float offerSetY = self.frame.origin.y - (pointFromWindow.y - (int)pointFromWindow.y);
//    self.frame = CGRectMake(offerSetX, offerSetY, (int)self.frame.size.width, (int)self.frame.size.height);

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)toucheBtn:(UIButton*)sender{

    CGPoint pointFromWindow = [[[UIApplication sharedApplication] keyWindow] convertPoint:label.frame.origin fromView:sender];
    CGPoint point1 = [sender convertPoint:CGPointMake((int)(pointFromWindow.x + .5),(int)(pointFromWindow.y + .5)) fromView:[[UIApplication sharedApplication] keyWindow]];

    label.frame = CGRectMake(point1.x, point1.y, (int)label.frame.size.width, (int)label.frame.size.height);

    
    CGPoint pointFromWindowrrr = [[[UIApplication sharedApplication] keyWindow] convertPoint:label.frame.origin fromView:sender];

    CGPoint pointFromWindow4 = [[[UIApplication sharedApplication] keyWindow] convertPoint:label1.frame.origin fromView:sender];
    CGPoint point = [sender convertPoint:CGPointMake((int)(pointFromWindow4.x + .5),(int)(pointFromWindow4.y + .5)) fromView:[[UIApplication sharedApplication] keyWindow]];
    
    label1.frame = CGRectMake(point.x, point.y, (int)label1.frame.size.width, (int)label1.frame.size.height);
    

}
@end
