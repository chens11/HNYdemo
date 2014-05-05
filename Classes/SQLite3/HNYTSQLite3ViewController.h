//
//  HNYTSQLite3ViewController.h
//  Demo
//
//  Created by chenzq on 5/5/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNYTSQLite3ViewController : UIViewController
@property (copy, nonatomic) NSString *databaseFilePath;

- (void)applicationWillResignActive:(NSNotification *)notification;

@end
