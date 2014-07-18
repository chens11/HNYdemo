//
//  HNYTDetailViewController.m
//  Demo
//
//  Created by zqchen on 19/7/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYTDetailViewController.h"
#import "HNYDetailTableViewController.h"

@interface HNYTDetailViewController ()<HNYDetailTableViewControllerDelegate,HNYPublicDelegate>
@property (nonatomic,strong) NSMutableArray *viewAry;
@property (nonatomic,strong) HNYDetailTableViewController *tableViewController;


@end

@implementation HNYTDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _viewAry = [[NSMutableArray alloc] initWithCapacity:0];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setContent];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.tableViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
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
- (void)setContent{
    {
        self.tableViewController = [[HNYDetailTableViewController alloc] init];
        self.tableViewController.delegate = self;
        self.tableViewController.customDelegate = self;
        [self addChildViewController:self.tableViewController];
        [self.tableViewController.view setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
        [self.view addSubview:self.tableViewController.view];
    }
    
    
    HNYDetailItemModel *firstItem = [[HNYDetailItemModel alloc] init];
    firstItem.viewType = Label;
    firstItem.textValue = @" 任务";
    firstItem.height = @"cellHeight/2";
    firstItem.fontSize = 12;
    firstItem.backGroundColor = [UIColor lightGrayColor];

    [_viewAry addObject:firstItem];

    {
        
        HNYDetailItemModel *itemVO = [[HNYDetailItemModel alloc] init];
        itemVO.viewType = TextView;
        itemVO.name = @"接  收  人:";
        itemVO.editable = YES;
        itemVO.key = @"innerUserList";
        itemVO.value = @"急急急急急急急急急急急急急急急";
        [_viewAry addObject:itemVO];
        
    }
    
    
    HNYDetailItemModel *itemVO = [[HNYDetailItemModel alloc] init];
    itemVO.viewType = TextView;
    itemVO.name = @"手机号码 :";
    itemVO.editable = YES;
    itemVO.key = @"outerUserMobiles";
    itemVO.value = @"36498327749879";
    [_viewAry addObject:itemVO];
    
    HNYDetailItemModel *taskItem = [[HNYDetailItemModel alloc] init];
    taskItem.viewType = TextView;
    taskItem.editable = NO;
    taskItem.name = @"任务内容:";
    taskItem.key = @"describe";
    taskItem.value = @"fjdlsjfk";
    taskItem.textValue = @"fjds;fdslkjfskl";
    taskItem.height = @"auto";
    taskItem.maxheight = self.tableViewController.cellHeight * 4;
    taskItem.minheight = self.tableViewController.cellHeight;
    [_viewAry addObject:taskItem];

    
    HNYDetailItemModel *descItemVO = [[HNYDetailItemModel alloc] init];
    descItemVO.viewType = TextView;
    descItemVO.editable = YES;
    descItemVO.height = @"1/1";
    descItemVO.key = @"desc";
    descItemVO.value = @"斤斤计较";
    [_viewAry addObject:descItemVO];


    
    self.tableViewController.viewAry = _viewAry;
    [self.tableViewController.tableView reloadData];
}

#pragma mark - EXDetailTableViewDelegate
- (void)valueDicChange:(HNYDetailTableViewController *)controller withValue:(id)value andKey:(NSString *)key{
    if ([controller isKindOfClass:[HNYDetailTableViewController class]]) {
        if ([@"innerUserList" isEqualToString:key]) {
        }
        else if ([@"outerUserMobiles" isEqualToString:key]){
        }
        else if ([@"desc" isEqualToString:key]){
        }
    }
}

@end
