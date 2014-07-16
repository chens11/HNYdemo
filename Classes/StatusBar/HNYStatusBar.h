//
//  HNYStatusBar.h
//  Demo
//
//  Created by chenzq on 7/15/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNYStatusBar : UIWindow

/*
 * @brief get the singleton tips window
 */
+ (HNYStatusBar*)shareTipsWindow;

/*
 * @brief show tips message on statusBar
 */
- (void)showTips:(NSString*)tips;

/*
 * @brief show tips message on statusBar
 */
- (void)showTips:(NSString*)tips hideAfterDelay:(NSInteger)seconds;

/*
 * @brief show tips icon and message on statusBar
 */
- (void)showTipsWithImage:(UIImage*)tipsIcon message:(NSString*)message;

/*
 * @brief show tips icon and message on statusBar
 */
- (void)showTipsWithImage:(UIImage*)tipsIcon message:(NSString*)message hideAfterDelay:(NSInteger)seconds;


/*
 * @brief hide tips window
 */
- (void)hideTips;

@end
