//
//  HNTAutorotateViewController.m
//  Demo
//
//  Created by chenzq on 4/29/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNTAutorotateViewController.h"

@interface HNTAutorotateViewController ()

@end

@implementation HNTAutorotateViewController

#pragma mark - autoratate setting
- (BOOL)shouldAutorotate{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return (toInterfaceOrientation == (UIInterfaceOrientationLandscapeLeft|UIInterfaceOrientationLandscapeRight|UIInterfaceOrientationPortrait|UIInterfaceOrientationPortraitUpsideDown));
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
//    CGSize size = [UIScreen mainScreen].bounds.size;
    self.view.window.frame = [UIScreen mainScreen].bounds;

    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
//        //        self.navBar.frame = CGRectMake(0, 20, size.height, 32);
//        self.statusBarWindow.frame = CGRectMake(0, 0, size.height, 20);
    }
    else if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
//        self.navBar.frame = CGRectMake(0, 20, size.width, 44);
//        self.statusBarWindow.frame = CGRectMake(0, 0, size.width, 20);
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
//    CGSize size = [UIScreen mainScreen].bounds.size;
//    NSLog(@"status window = %@",self.view.window);
//    if (UIInterfaceOrientationIsLandscape(fromInterfaceOrientation)) {
//        self.view.window.frame = [UIScreen mainScreen].bounds;
//    }
//    else if (UIInterfaceOrientationIsPortrait(fromInterfaceOrientation)) {
//        self.view.window.frame = [UIScreen mainScreen].bounds;
//    }
    
}

@end
