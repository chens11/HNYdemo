//
//  MainViewController.m
//  Demo
//
//  Created by zqchen on 12/4/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "MainViewController.h"
#import "HNYTRefreshTableViewController.h"
#import "HNYBaseViewController.h"
#import "HNYTActionSheetViewController.h"
#import "HNYTSQLite3ViewController.h"
#import "HNYTArchivingViewController.h"
#import "HNYTPListViewController.h"
#import "HNYTCoreDataViewController.h"
#import "HNYTJSONViewController.h"
#import "HNYRSAViewController.h"
#import "ELCImagePickerController.h"
#import "HNYMulLocationViewController.h"
#import "HNYGetIPViewController.h"
#import "HNYTDetailViewController.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *dataList;
@property (nonatomic,strong) UITableViewController *tableController;
@end

@implementation MainViewController
@synthesize dataList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Demo by chenzq";
        self.dataList = [NSMutableArray array];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self createContentView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tableController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

#pragma mark - init sub view
- (void)createContentView{
    self.tableController = [[UITableViewController alloc] init];
    self.tableController.tableView.delegate = self;
    self.tableController.tableView.dataSource = self;
    [self.view addSubview:self.tableController.view];
    [self addChildViewController:self.tableController];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.text = [[self.dataList objectAtIndex:indexPath.row] objectForKey:@"title"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *controllerType = [[self.dataList objectAtIndex:indexPath.row] objectForKey:@"type"];
    if ([@"refresh Table" isEqualToString:controllerType]) {
        HNYTRefreshTableViewController *controller = [[HNYTRefreshTableViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([@"base view controller" isEqualToString:controllerType]) {
        HNYBaseViewController *controller = [[HNYBaseViewController alloc] init];
        controller.hideTabView = [NSNumber numberWithBool:YES];
        controller.hideNavView = [NSNumber numberWithBool:YES];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([@"test local notification" isEqualToString:controllerType]){
        UILocalNotification *localNotifacition = [[UILocalNotification alloc] init];
        localNotifacition.fireDate = [[NSDate alloc] initWithTimeIntervalSinceNow:5];
        localNotifacition.alertBody = @"test local notification";
        localNotifacition.alertAction = @"open";
        localNotifacition.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"value",@"key", nil];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotifacition];
        
    }
    else if ([@"Test tab bar" isEqualToString:controllerType]){
    }
    else if ([@"Test Action Sheet" isEqualToString:controllerType]){
        HNYTActionSheetViewController *controller = [[HNYTActionSheetViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([@"Test sqlite3" isEqualToString:controllerType]){
        HNYTSQLite3ViewController *controller = [[HNYTSQLite3ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([@"data archiving" isEqualToString:controllerType]){
        HNYTArchivingViewController *controller = [[HNYTArchivingViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([@"save data to plist" isEqualToString:controllerType]){
        HNYTPListViewController *controller = [[HNYTPListViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([@"core data" isEqualToString:controllerType]){
        HNYTCoreDataViewController *controller = [[HNYTCoreDataViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([@"Test json" isEqualToString:controllerType]){
        HNYTJSONViewController *controller = [[HNYTJSONViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([@"encrypt and decrypt" isEqualToString:controllerType]){
        HNYRSAViewController *controller = [[HNYRSAViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([@"image picker" isEqualToString:controllerType]){
        ELCImagePickerController *controller = [[ELCImagePickerController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([@"Test backgound location" isEqualToString:controllerType]){
        HNYMulLocationViewController *controller = [[HNYMulLocationViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];

    }
    else if ([@"Get Ip" isEqualToString:controllerType]){
        HNYGetIPViewController *controller = [[HNYGetIPViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([@"Test Detail Control" isEqualToString:controllerType]){
        HNYTDetailViewController *controller = [[HNYTDetailViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([@"Test json" isEqualToString:controllerType]){
    }
    else if ([@"Test json" isEqualToString:controllerType]){
    }
    else if ([@"Test json" isEqualToString:controllerType]){
    }
    else if ([@"Test json" isEqualToString:controllerType]){
    }
    else if ([@"Test json" isEqualToString:controllerType]){
    }
    else if ([@"Test json" isEqualToString:controllerType]){
    }
}

#pragma mark - init data for the table view controller
- (void)initData{
    
    
    NSDictionary *detailDic = [NSDictionary dictionaryWithObjectsAndKeys:@"Test Detail Control ",@"title",@"Test Detail Control",@"type", nil];
    [self.dataList addObject:detailDic];
    
    NSDictionary *getIP = [NSDictionary dictionaryWithObjectsAndKeys:@"Get Ip ",@"title",@"Get Ip",@"type", nil];
    [self.dataList addObject:getIP];
    
    NSDictionary *bgLocation = [NSDictionary dictionaryWithObjectsAndKeys:@"Test backgound location ",@"title",@"Test backgound location",@"type", nil];
    [self.dataList addObject:bgLocation];
    
    NSDictionary *json = [NSDictionary dictionaryWithObjectsAndKeys:@"Test json ",@"title",@"Test json",@"type", nil];
    [self.dataList addObject:json];
    
    NSDictionary *imageDic = [NSDictionary dictionaryWithObjectsAndKeys:@"Test custom image picker",@"title",@"image picker",@"type", nil];
    [self.dataList addObject:imageDic];
    
    NSDictionary *rsaDic = [NSDictionary dictionaryWithObjectsAndKeys:@"Test rsa encrypt and decrypt",@"title",@"encrypt and decrypt",@"type", nil];
    [self.dataList addObject:rsaDic];
    
    NSDictionary *refreshDic = [NSDictionary dictionaryWithObjectsAndKeys:@"Test refresh tabel view controller",@"title",@"refresh Table",@"type", nil];
    [self.dataList addObject:refreshDic];
    
    NSDictionary *baseViewControllerDic = [NSDictionary dictionaryWithObjectsAndKeys:@"Test base view controller",@"title",@"base view controller",@"type", nil];
    [self.dataList addObject:baseViewControllerDic];
    
    NSDictionary *localNotification = [NSDictionary dictionaryWithObjectsAndKeys:@"Test local notification",@"title",@"test local notification",@"type", nil];
    [self.dataList addObject:localNotification];
    
//    NSDictionary *testTabBar = [NSDictionary dictionaryWithObjectsAndKeys:@"Test tab bar",@"title",@"Test tab bar",@"type", nil];
//    [self.dataList addObject:testTabBar];
    
    NSDictionary *testActionSheet = [NSDictionary dictionaryWithObjectsAndKeys:@"Test Action Sheet and popover ",@"title",@"Test Action Sheet",@"type", nil];
    [self.dataList addObject:testActionSheet];
    
    NSDictionary *testSqlite3 = [NSDictionary dictionaryWithObjectsAndKeys:@"Test sqlite3 ",@"title",@"Test sqlite3",@"type", nil];
    [self.dataList addObject:testSqlite3];
    
    NSDictionary *archiving = [NSDictionary dictionaryWithObjectsAndKeys:@"Test data archiving ",@"title",@"data archiving",@"type", nil];
    [self.dataList addObject:archiving];
    
    NSDictionary *plist = [NSDictionary dictionaryWithObjectsAndKeys:@"Test save data to plist ",@"title",@"save data to plist",@"type", nil];
    [self.dataList addObject:plist];
    
    NSDictionary *coreData = [NSDictionary dictionaryWithObjectsAndKeys:@"Test core data ",@"title",@"core data",@"type", nil];
    [self.dataList addObject:coreData];
    

}

@end
