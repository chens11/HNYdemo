//
//  HNYSQLite3UserViewController.h
//  Demo
//
//  Created by chenzq on 5/6/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicDelegate.h"

@interface HNYSQLite3UserViewController : UIViewController
@property (copy, nonatomic) NSString *databaseFilePath;
@property (weak, nonatomic) id <PublicDelegate> delegate;

@end
