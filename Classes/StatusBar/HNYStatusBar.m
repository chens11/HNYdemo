//
//  HNYStatusBar.m
//  Demo
//
//  Created by chenzq on 7/15/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//
#import "HNYStatusBar.h"

#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define HEIGHT   20

#define ICON_WIDTH 20

#define TIPMESSAGE_RIGHT_MARGIN 20
#define ICON_RIGHT_MARGIN       5


@interface HNYStatusBar () {
    UILabel     *_tipsLbl;
    UIImageView *_tipsIcon;
    
    NSTimer     *_hideTimer;
}

@property (nonatomic, copy)     NSString *tipsMessage;

@end



@implementation HNYStatusBar

@synthesize tipsMessage;


static HNYStatusBar *tipsWindow = nil;

+ (HNYStatusBar*)shareTipsWindow
{
    if (!tipsWindow) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            tipsWindow = [[super allocWithZone:NULL] init];
        });
    }
    
    return tipsWindow;
}

+ (id)copyWithZone:(NSZone *)zone
{
    return [self shareTipsWindow];
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self shareTipsWindow];
}



- (id)init
{
    CGRect frame = [UIApplication sharedApplication].statusBarFrame;
    self = [super initWithFrame:frame];
    if (self) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.windowLevel = UIWindowLevelStatusBar + 10;
        self.backgroundColor = [UIColor clearColor];
        
        _tipsIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ICON_WIDTH, ICON_WIDTH)];
        _tipsIcon.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tipsIcon.backgroundColor = [UIColor redColor];
        [self addSubview:_tipsIcon];
        
        _tipsLbl = [[UILabel alloc] initWithFrame:self.bounds];
#ifdef NSTextAlignmentRight
        _tipsLbl.textAlignment = NSTextAlignmentLeft;
        _tipsLbl.lineBreakMode = NSLineBreakByTruncatingTail;
#else
        _tipsLbl.textAlignment = 0; // means UITextAlignmentLeft
        _tipsLbl.lineBreakMode = 4; //UILineBreakModeTailTruncation;
#endif
        _tipsLbl.textColor = [UIColor whiteColor];
        _tipsLbl.font = [UIFont systemFontOfSize:12];
        _tipsLbl.backgroundColor = [UIColor blackColor];
        _tipsLbl.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self addSubview:_tipsLbl];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateOrientation:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Notification Handle

- (void)updateOrientation:(NSNotification*)noti
{
    UIInterfaceOrientation newOrientation = [[noti.userInfo valueForKey:UIApplicationStatusBarOrientationUserInfoKey] integerValue];
    NSLog(@"new orientation: %d", newOrientation);
    
    switch (newOrientation) {
        case UIInterfaceOrientationPortrait:
        {
            self.transform = CGAffineTransformIdentity;
            self.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT);
            
            break;
        }
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            // 先转矩阵，坐标系统落在屏幕有右下角，朝上是y，朝左是x
            self.transform = CGAffineTransformMakeRotation(M_PI);
            self.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - HEIGHT / 2);
            self.bounds = CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT);
            
            break;
        }
        case UIInterfaceOrientationLandscapeLeft:
        {
            self.transform = CGAffineTransformMakeRotation(-M_PI_2);
            // 这个时候坐标轴已经转了90°，调整x相当于调节竖向调节，y相当于横向调节
            self.center = CGPointMake(HEIGHT / 2, [UIScreen mainScreen].bounds.size.height / 2);
            self.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, HEIGHT);
            
            break;
        }
        case UIInterfaceOrientationLandscapeRight:
        {
            // 先设置transform，在设置位置和大小
            self.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.center = CGPointMake(SCREEN_WIDTH - HEIGHT / 2, SCREEN_HEIGHT / 2);
            self.bounds = CGRectMake(0, 0, SCREEN_HEIGHT, HEIGHT);
            
            break;
        }
        default:
            break;
    }
}

#pragma mark -
#pragma mark Tips Method

/*
 * @brief show tips message on statusBar
 */
- (void)showTips:(NSString*)tips
{
    if (_hideTimer) {
        [_hideTimer invalidate];
    }
    
    _tipsIcon.image = nil;
    _tipsIcon.hidden = YES;
    
    CGSize size = [tips sizeWithFont:_tipsLbl.font constrainedToSize:CGSizeMake(320, 30)];
    size.width += TIPMESSAGE_RIGHT_MARGIN;
    if (size.width > self.bounds.size.width - ICON_WIDTH) {
        size.width = self.bounds.size.width - ICON_WIDTH;
    }
    
    _tipsLbl.frame = CGRectMake(self.bounds.size.width - size.width, 0, size.width, self.bounds.size.height);
    _tipsLbl.text = tips;
    
    [self makeKeyAndVisible];
}

- (void)showTips:(NSString*)tips hideAfterDelay:(NSInteger)seconds
{
    [self showTips:tips];
    
    _hideTimer = [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(hideTips) userInfo:nil repeats:NO];
}

/*
 * @brief show tips icon and message on statusBar
 */
- (void)showTipsWithImage:(UIImage*)tipsIconImage message:(NSString*)message
{
    if (_hideTimer) {
        [_hideTimer invalidate];
    }
    
    CGSize size = [message sizeWithFont:_tipsLbl.font constrainedToSize:self.bounds.size];
    size.width += TIPMESSAGE_RIGHT_MARGIN;
    if (size.width > self.bounds.size.width - ICON_WIDTH) {
        size.width = self.bounds.size.width - ICON_WIDTH;
    }
    
    _tipsLbl.frame = CGRectMake(self.bounds.size.width - size.width, 0, size.width, self.bounds.size.height);
    _tipsLbl.text = message;
    
    _tipsIcon.center = CGPointMake(self.bounds.size.width - _tipsLbl.bounds.size.width - ICON_WIDTH / 2 - ICON_RIGHT_MARGIN, self.bounds.size.height / 2);
    _tipsIcon.image = tipsIconImage;
    _tipsIcon.hidden = NO;
    
    [self makeKeyAndVisible];
}

- (void)showTipsWithImage:(UIImage*)tipsIconImage message:(NSString*)message hideAfterDelay:(NSInteger)seconds
{
    [self showTipsWithImage:tipsIconImage message:message];
    
    _hideTimer = [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(hideTips) userInfo:nil repeats:NO];
}

/*
 * @brief hide tips window
 */
- (void)hideTips
{
    self.hidden = YES;
}

@end


