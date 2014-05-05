//
//  HNYPopoverView.h
//  Demo
//
//  Created by chenzq on 4/18/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HNYPopoverView;

@protocol HNYPopoverViewDelegate <NSObject>
@optional

/* Called on the delegate when the popover controller will dismiss the popover. Return NO to prevent the dismissal of the view.
 */
- (void)hNYPopoverViewWillDismissPopover:(HNYPopoverView *)popover;

/* Called on the delegate when the user has taken action to dismiss the popover. This is not called when -dismissPopoverAnimated: is called directly.
 */
- (void)hNYPopoverViewDidDismissPopover:(HNYPopoverView *)popover;

@end



@interface HNYPopoverView : UIView
@property (nonatomic, assign) id <HNYPopoverViewDelegate> delegate;

@property (nonatomic, retain) UIView *contentView;
+ (HNYPopoverView *)showPopoverFromRect:(CGRect)rect inView:(UIView *)view withText:(NSString *)text delegate:(id<HNYPopoverViewDelegate>)delegate;

+ (HNYPopoverView *)showPopoverFromRect:(CGRect)rect inView:(UIView *)view withTitle:(NSString *)title withText:(NSString *)text delegate:(id<HNYPopoverViewDelegate>)delegate;
//
//+ (HNYPopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withViewArray:(NSArray *)viewArray delegate:(id<HNYPopoverViewDelegate>)delegate;
//
//+ (HNYPopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withViewArray:(NSArray *)viewArray delegate:(id<HNYPopoverViewDelegate>)delegate;
//
//+ (HNYPopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withStringArray:(NSArray *)stringArray delegate:(id<HNYPopoverViewDelegate>)delegate;
//
//+ (HNYPopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withStringArray:(NSArray *)stringArray delegate:(id<HNYPopoverViewDelegate>)delegate;
//
//+ (HNYPopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withContentView:(UIView *)cView delegate:(id<HNYPopoverViewDelegate>)delegate;
//
//+ (HNYPopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withContentView:(UIView *)cView delegate:(id<HNYPopoverViewDelegate>)delegate;

- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withText:(NSString *)text;

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view;

- (void)dismissPopoverAnimated:(BOOL)animated;

@end
