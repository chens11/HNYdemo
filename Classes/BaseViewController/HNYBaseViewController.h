//
//  HNYBaseViewController.h
//  Demo
//
//  Created by zqchen on 17/4/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNYNavigationBar.h"
#import "HNYTabBar.h"
#define NavBarHeight 44
#define TabBarHeight 48
#define StatusBarHeight 20
#define StatusBarBackGroundColor [UIColor lightGrayColor]

@interface HNYBaseViewController : UIViewController
@property (strong, nonatomic) UIView *statusView;
@property (nonatomic,strong) HNYNavigationBar *navBar;
@property (nonatomic,strong) HNYTabBar *tabBar;
@property (nonatomic,strong) NSNumber *hideStatusView;
@property (nonatomic,strong) NSNumber *hideNavView;
@property (nonatomic,strong) NSNumber *hideTabView;
@property (nonatomic,strong) UINavigationController *customNavController;

- (void)createStatusWindow;
- (void)createNavigationBar;
- (void)createNavBarItems;
- (void)createTabBar;
- (void)createTabBarItems;
- (void)createContentView;
- (void)initData;

@end
