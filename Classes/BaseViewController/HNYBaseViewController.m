//
//  HNYBaseViewController.m
//  Demo
//
//  Created by zqchen on 17/4/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYBaseViewController.h"
#import "HNTAutorotateViewController.h"


@interface HNYBaseViewController ()
@property (strong, nonatomic) UIWindow *statusBarWindow;

@end

@implementation HNYBaseViewController
@synthesize navBar = _navBar;
@synthesize tabBar = _tabBar;
#pragma mark - view life cycle
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
    [self createStatusWindow];
    [self createNavigationBar];
    [self createNavBarItems];
    [self createTabBar];
    [self createTabBarItems];
    [self createContentView];
    [self initData];
    self.view.backgroundColor = [UIColor whiteColor];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    button.frame = CGRectMake(50, 50, 50, 50);
//    [button addTarget:self action:@selector(touchesButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - create custom navigation bar

- (void)createStatusWindow{
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, StatusBarHeight)];
    self.statusView.hidden = YES;
    self.statusView.backgroundColor = StatusBarBackGroundColor;
    self.statusBarWindow = [[UIWindow alloc] init];
    self.statusBarWindow.backgroundColor = [UIColor clearColor];
    self.statusBarWindow.frame = CGRectMake(0, 0, size.width, StatusBarHeight);
    self.statusBarWindow.windowLevel = UIWindowLevelNormal;
    self.statusBarWindow.hidden = NO;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 6.9)
        self.statusView.hidden = NO;
    if (self.hideStatusView && [self.hideStatusView boolValue])
        self.statusView.hidden = YES;
    else if (self.hideStatusView && ![self.hideStatusView boolValue])
        self.statusView.hidden = NO;
    [self.statusBarWindow addSubview:self.statusView];
    [self.statusBarWindow makeKeyAndVisible];
}

- (void)createNavigationBar{
    if (self.navigationController.isNavigationBarHidden) {
        float height = 0;
        if ([[UIDevice currentDevice].systemVersion floatValue] > 6.9)
            height = StatusBarHeight;
        
        self.navBar = [[HNYNavigationBar alloc] initWithFrame:CGRectMake(0, height, self.view.frame.size.width,NavBarHeight)];
        self.navBar.backgroundColor = [UIColor redColor];
        self.navBar.autoresizingMask = UIViewAutoresizingNone;
        [self.view addSubview:self.navBar];
        if (self.hideNavView && [self.hideNavView boolValue]) {
            [self.navBar removeFromSuperview];
            self.navBar = nil;
        }
        
    }
    else{
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navBar"] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    }

}

- (void)createNavBarItems{
    if (self.navigationController.isNavigationBarHidden) {
        
    }
    else{
        UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(clickLeftBarButton:)];
        self.navigationItem.leftBarButtonItem = backBarItem;
    }
}

- (void)createTabBar{
    float height = 0;
    if (!self.navigationController.isNavigationBarHidden) {
        height = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height;
        if ([[UIDevice currentDevice].systemVersion floatValue] < 6.9)
            height -= 20;
    }
    self.tabBar = [[HNYTabBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - TabBarHeight - height, self.view.frame.size.width,TabBarHeight)];
    self.tabBar.backgroundColor = [UIColor redColor];
    self.tabBar.autoresizingMask = UIViewAutoresizingNone;
    [self.view addSubview:self.tabBar];
    if (self.hideTabView && [self.hideTabView boolValue]) {
        [self.tabBar removeFromSuperview];
        self.tabBar = nil;
    }
}

- (void)createTabBarItems{
    
}

- (void)createContentView{
    
}

- (void)initData{
    
}
#pragma mark - IBAction
- (void)touchesButton:(UIButton*)sender{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"status window = %@",self.statusBarWindow);
    NSLog(@"key window = %@",self.view.window);
}

- (void)clickLeftBarButton:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

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
#pragma mark - autoroateing notifcication

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    CGSize size = [UIScreen mainScreen].bounds.size;
    float navBarOriginY = 0;
    float tabBarOffset = StatusBarHeight;
    if ([[UIDevice currentDevice].systemVersion floatValue] > 6.9){
        navBarOriginY = 20;
        tabBarOffset = 0;
        if (!self.navigationController.isNavigationBarHidden) {
            if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
                tabBarOffset += self.navigationController.navigationBar.frame.origin.y + 32;
            else
                tabBarOffset += self.navigationController.navigationBar.frame.origin.y + NavBarHeight;
        }
    }
    else{
        if (!self.navigationController.isNavigationBarHidden) {
            if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
                tabBarOffset += 32;
            else
                tabBarOffset += NavBarHeight;
        }
    }
    
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        self.navBar.frame = CGRectMake(0, navBarOriginY, size.height, 32);
        self.tabBar.frame = CGRectMake(0, size.width - TabBarHeight - tabBarOffset, size.height, TabBarHeight);
        if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
            self.statusBarWindow.frame = CGRectMake(0, 0, StatusBarHeight, size.height);
            self.statusView.frame = CGRectMake(0, 0, StatusBarHeight, size.height);
        }else{
            self.statusBarWindow.frame = CGRectMake(size.width - StatusBarHeight, 0, StatusBarHeight, size.height);
            self.statusView.frame = CGRectMake(0, 0, StatusBarHeight, size.height);
        }
    }
    else if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        self.navBar.frame = CGRectMake(0, navBarOriginY, size.width, NavBarHeight);
        self.tabBar.frame = CGRectMake(0, size.height - TabBarHeight - tabBarOffset, size.width, TabBarHeight);
        if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
            self.statusBarWindow.frame = CGRectMake(0, 0, size.width, StatusBarHeight);
            self.statusView.frame = CGRectMake(0, 0, size.width, StatusBarHeight);
        }else{
            self.statusBarWindow.frame = CGRectMake(0, size.height - StatusBarHeight, size.width, StatusBarHeight);
            self.statusView.frame = CGRectMake(0, 0, size.width, StatusBarHeight);
        }
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    CGSize size = [UIScreen mainScreen].bounds.size;
    float navBarOriginY = 0;
    float tabBarOffset = StatusBarHeight;
    if ([[UIDevice currentDevice].systemVersion floatValue] > 6.9){
        navBarOriginY = StatusBarHeight;
        tabBarOffset = 0;
        if (!self.navigationController.isNavigationBarHidden)
            tabBarOffset += self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height;
    }
    else{
        if (!self.navigationController.isNavigationBarHidden)
            tabBarOffset += self.navigationController.navigationBar.frame.size.height;
    }
    
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        self.navBar.frame = CGRectMake(0, navBarOriginY, size.width, NavBarHeight);
        self.tabBar.frame = CGRectMake(0, size.height - TabBarHeight - tabBarOffset, size.width, TabBarHeight);
    }
    else if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        self.navBar.frame = CGRectMake(0, navBarOriginY, size.height, 32);
        self.tabBar.frame = CGRectMake(0, size.width - TabBarHeight - tabBarOffset, size.height, TabBarHeight);
    }

    NSLog(@"status window = %@",self.statusBarWindow);
    NSLog(@"key window = %@",self.view.window);
}
@end
