//
//  PublicDelegate.h
//  Demo
//
//  Created by chenzq on 5/6/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PublicDelegate <NSObject>
@optional

- (void)viewController:(UIViewController*)vController actionWitnInfo:(NSDictionary*)info;
- (void)view:(UIView*)aView actionWitnInfo:(NSDictionary*)info;

@end
