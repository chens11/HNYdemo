//
//  HNYTActionSheetViewController.m
//  Demo
//
//  Created by chenzq on 4/30/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYTActionSheetViewController.h"
#import "HNYActionSheet.h"
#import "HNYPopoverView.h"

@interface HNYTActionSheetViewController ()<HNYActionSheetDelegate,HNYPopoverViewDelegate,UIActionSheetDelegate>

@end

@implementation HNYTActionSheetViewController

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
    for (int i = 0; i < 5; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.tag = i;
        button.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        button.layer.borderWidth = 1;
        button.frame = CGRectMake(20,self.navigationController.navigationBar.frame.size.height + 20 + 60*i, self.view.frame.size.width - 40, 40);
        [button setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (void)touchButton:(UIButton*)sender{
    if (sender.tag == 0) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, 100, 200);
        label.backgroundColor = [UIColor blackColor];
        [HNYPopoverView showPopoverFromRect:sender.frame inView:self.view withTitle:@"test" withText:@"implemented -[<UIApplicationDelegate> application:didReceiveRemoteNotification:fetchCompletionHandler:], but you still need to add to the list of your supported UIBackgroundModes in your Info.plis" delegate:self];

//        UILabel *label = [[UILabel alloc] init];
//        label.frame = CGRectMake(0, 0, 100, 200);
//        label.backgroundColor = [UIColor blackColor];
//        [HNYActionSheet showWithTitle:@"Test ActionSheet With Content View" contentView:label cancelBtnTitle:@"Cancel" sureBtnTitle:@"Sure" delegate:self];
    }
    else if (sender.tag == 1) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, 100, 200);
        label.backgroundColor = [UIColor blackColor];
        [HNYActionSheet showWithContentView:label delegate:self];
    }
    else if (sender.tag == 2) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, 100, 200);
        label.backgroundColor = [UIColor blackColor];
        [HNYPopoverView showPopoverFromRect:sender.frame inView:self.view withTitle:@"test" withText:@"implemented -[<UIApplicationDelegate> application:didReceiveRemoteNotification:fetchCompletionHandler:], but you still need to add to the list of your supported UIBackgroundModes in your Info.plis" delegate:self];
    }
    else if (sender.tag == 3) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, 100, 200);
        label.backgroundColor = [UIColor blackColor];
        [HNYPopoverView showPopoverFromRect:sender.frame inView:self.view withTitle:@"test" withText:@"implemented -[<UIApplicationDelegate> application:didReceiveRemoteNotification:fetchCompletionHandler:], but you still need to add to the list of your supported UIBackgroundModes in your Info.plis" delegate:self];
    }

}


@end
