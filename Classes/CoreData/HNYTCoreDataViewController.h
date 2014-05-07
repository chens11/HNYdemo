//
//  HNYTCoreDataViewController.h
//  Demo
//
//  Created by chenzq on 5/6/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface HNYTCoreDataViewController : UIViewController
@property (strong,nonatomic) AppDelegate *myDelegate;
@property (strong,nonatomic) NSMutableArray *entries;

@end
