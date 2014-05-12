//
//  HNYViewController.h
//  SideBar
//
//  Created by chenzq on 5/12/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicDelegate.h"

@interface HNYViewController : UIViewController
@property (nonatomic,weak) id <PublicDelegate> delegate;

@end
