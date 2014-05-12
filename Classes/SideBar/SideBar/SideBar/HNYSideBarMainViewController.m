//
//  HNYSideBarMainViewController.m
//  SideBar
//
//  Created by chenzq on 5/12/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYSideBarMainViewController.h"
#import "HNYViewController.h"

#define TableCellHeight 44.0f;

@interface HNYSideBarMainViewController () <UITableViewDataSource,UITableViewDelegate,PublicDelegate>
@property (nonatomic,strong) UITableView *leftTable;
@property (nonatomic,strong) NSMutableArray *leftMenuAry;
@property (nonatomic,strong) UITableView *rightTable;
@property (nonatomic,strong) NSMutableArray *rightMenuAry;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UINavigationController *navController;

@end

@implementation HNYSideBarMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.leftMenuAry = [NSMutableArray array];
        self.rightMenuAry = [NSMutableArray array];
        for (int i = 0; i < 6; i++) {
            [self.leftMenuAry addObject:[NSString stringWithFormat:@"HNYSideBarMenu %d",i]];
            [self.rightMenuAry addObject:[NSString stringWithFormat:@"HNYSideBarMenu %d",i]];
        }
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frame = self.view.frame;
    self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
    self.scrollView.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:self.scrollView];
    
    
    
    self.leftTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.leftTable.tag = 0;
    self.leftTable.alpha = 0.0;
    self.leftTable.dataSource = self;
    self.leftTable.delegate = self;
    [self.view addSubview:self.leftTable];
    
    self.rightTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.rightTable.tag = 1;
    self.rightTable.alpha = 0.0;
    self.rightTable.dataSource = self;
    self.rightTable.delegate = self;
    [self.view addSubview:self.rightTable];

    
    
    self.navController = [[UINavigationController alloc] init];
    self.navController.view.frame = frame;
    self.navController.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.navController.view];
    [self addChildViewController:self.navController];
    
    HNYViewController *controller = [[HNYViewController alloc] init];
    controller.delegate = self;
    controller.title = @"Home";
    controller.view.backgroundColor = [UIColor blueColor];
    [self.navController setViewControllers:[NSArray arrayWithObjects:controller, nil]];
//    [self.scrollView addSubview:self.leftTable];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 0) {
        return self.leftMenuAry.count;
    }
    else if (tableView.tag == 1){
        return self.rightMenuAry.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return TableCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"UISideBarTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    if (tableView.tag == 0) {
        cell.textLabel.text = [self.leftMenuAry objectAtIndex:indexPath.row];
    }
    else if (tableView.tag == 1){
        cell.textLabel.textAlignment = NSTextAlignmentRight;
        cell.textLabel.text = [self.rightMenuAry objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HNYViewController *controller = [[HNYViewController alloc] init];
    controller.delegate = self;
    if (tableView.tag == 0) {
        controller.title = [self.leftMenuAry objectAtIndex:indexPath.row];
    }
    else if (tableView.tag == 1) {
        controller.title = [self.rightMenuAry objectAtIndex:indexPath.row];
    }
    
    [self.navController setViewControllers:[NSArray arrayWithObjects:controller, nil]];
        [UIView animateWithDuration:0.3 animations:^{
            self.navController.view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
            self.navController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                self.leftTable.alpha = .0;
                self.rightTable.alpha = .0;
            }];
        }];
}
#pragma mark - PublicDelegate
- (void)viewController:(UIViewController *)vController actionWitnInfo:(NSDictionary *)info{
    if ([@"leftBarButton" isEqualToString:[info objectForKey:@"buttonClick"]]) {
        [UIView animateWithDuration:0.3 animations:^{
            self.navController.view.center = CGPointMake(self.view.frame.size.width, self.view.frame.size.height/2);
            self.navController.view.transform = CGAffineTransformMakeScale(0.8, 0.8);
        } completion:^(BOOL finished) {
           [UIView animateWithDuration:0.5 animations:^{
               self.leftTable.alpha = 1.0;
           }];
        }];
    }
    else if ([@"rightBarButton" isEqualToString:[info objectForKey:@"buttonClick"]]) {
        [UIView animateWithDuration:0.3 animations:^{
            self.navController.view.center = CGPointMake(0, self.view.frame.size.height/2);
            self.navController.view.transform = CGAffineTransformMakeScale(0.8, 0.8);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                self.rightTable.alpha = 1.0;
            }];
        }];
    }
}

@end
