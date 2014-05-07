//
//  HNYPopoverView.m
//  Demo
//
//  Created by chenzq on 4/18/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYPopoverView.h"
@interface HNYPopoverView ()
@property (nonatomic,strong) UIView *view;
@property (nonatomic) CGPoint arrowPoint;
@property (nonatomic) BOOL above;
@property (nonatomic) CGRect contentRect;

@end

@implementation HNYPopoverView

#pragma mark - vies life cycle
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.above = NO;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognize:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGFloat minx = CGRectGetMinX(self.contentRect);
    CGFloat maxx = CGRectGetMaxX(self.contentRect);
    CGFloat miny = CGRectGetMinY(self.contentRect);
    CGFloat maxy = CGRectGetMaxY(self.contentRect);
    CGFloat radius = HNYPopoverViewCornerRadius;
    CGFloat arrowOffset = HNYArrowOffset;
    CGFloat arrowHeight = HNYArrowHeight;
    //创建path
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 添加圆到path
    [path moveToPoint:CGPointMake(minx, miny + radius)];
    [path addCurveToPoint:CGPointMake(minx + radius, miny) controlPoint1:CGPointMake(minx, miny + radius - arrowOffset) controlPoint2:CGPointMake(minx + radius - arrowOffset, miny)];

    if (!self.above) {
        [path addLineToPoint:CGPointMake(self.arrowPoint.x - arrowHeight, miny)];
        [path addCurveToPoint:self.arrowPoint controlPoint1:CGPointMake(self.arrowPoint.x - arrowHeight + arrowOffset, miny) controlPoint2:CGPointMake(self.arrowPoint.x, self.arrowPoint.y + arrowOffset)];
        [path addCurveToPoint:CGPointMake(self.arrowPoint.x + arrowHeight, miny) controlPoint1:CGPointMake(self.arrowPoint.x, self.arrowPoint.y + arrowOffset) controlPoint2:CGPointMake(self.arrowPoint.x + arrowHeight - arrowOffset, miny)];
    }
    [path addLineToPoint:CGPointMake(maxx - radius, miny)];
    [path addCurveToPoint:CGPointMake(maxx, miny + radius) controlPoint1:CGPointMake(maxx - radius + arrowOffset, miny) controlPoint2:CGPointMake(maxx, miny + radius - arrowOffset)];

    [path addLineToPoint:CGPointMake(maxx, maxy - radius)];
    [path addCurveToPoint:CGPointMake(maxx - radius, maxy) controlPoint1:CGPointMake(maxx, maxy - radius + arrowOffset) controlPoint2:CGPointMake(maxx - radius + arrowOffset, maxy)];

    if (self.above) {
        [path addLineToPoint:CGPointMake(self.arrowPoint.x + arrowHeight, maxy)];
        [path addCurveToPoint:self.arrowPoint controlPoint1:CGPointMake(self.arrowPoint.x + arrowHeight - arrowOffset,maxy) controlPoint2:CGPointMake(self.arrowPoint.x, self.arrowPoint.y - arrowOffset)];
        [path addCurveToPoint:CGPointMake(self.arrowPoint.x - arrowHeight, maxy) controlPoint1:CGPointMake(self.arrowPoint.x, self.arrowPoint.y - arrowOffset) controlPoint2:CGPointMake(self.arrowPoint.x - arrowHeight + arrowOffset, maxy)];
    }
    [path addLineToPoint:CGPointMake(minx + radius, maxy)];
    [path addCurveToPoint:CGPointMake(minx, maxy - radius) controlPoint1:CGPointMake(minx + radius - arrowOffset, maxy) controlPoint2:CGPointMake(minx, maxy - radius + arrowOffset)];

    [path addLineToPoint:CGPointMake(minx, miny + radius)];

    // 设置描边宽度（为了让描边看上去更清楚）
    //设置颜色（颜色设置也可以放在最上面，只要在绘制前都可以）
    [[UIColor clearColor] setStroke];
    [[UIColor colorWithWhite:0.8 alpha:0.8] setFill];
    // 描边和填充
    [path stroke];
    [path fill];
}
#pragma mark - Class Static presenting Method

+ (HNYPopoverView *)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withText:(NSString *)text delegate:(id<HNYPopoverViewDelegate>)delegate{
    HNYPopoverView *sheet = [[HNYPopoverView alloc] initWithFrame:CGRectZero];
    sheet.delegate = delegate;
    [sheet presentFromRect:rect inView:view withTitle:nil withText:text];
    [sheet presentPopoverAnimated:YES];
    return sheet;
}

+ (HNYPopoverView *)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withTitle:(NSString *)title withText:(NSString *)text delegate:(id<HNYPopoverViewDelegate>)delegate{
    HNYPopoverView *sheet = [[HNYPopoverView alloc] initWithFrame:CGRectZero];
    sheet.delegate = delegate;
    [sheet presentFromRect:rect inView:view withTitle:title withText:text];
    [sheet presentPopoverAnimated:YES];
    return sheet;
}

+ (HNYPopoverView *)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withTitle:(NSString *)title withContentView:(UIView *)cView delegate:(id<HNYPopoverViewDelegate>)delegate{
    HNYPopoverView *sheet = [[HNYPopoverView alloc] initWithFrame:CGRectZero];
    sheet.delegate = delegate;
    [sheet presentFromRect:rect inView:view withTitle:title withContentView:cView];
    [sheet presentPopoverAnimated:YES];
    return sheet;
}

#pragma mark - Instance presenting Methods

- (void)presentFromRect:(CGRect)rect inView:(UIView *)view withTitle:(NSString *)title withText:(NSString *)text {
    UIView *topView = [self getTopViewOfTheWindow];
    float font = HNYPopoverViewTextFont;
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(topView.frame.size.width - 40, topView.frame.size.height *4/5) lineBreakMode:NSLineBreakByWordWrapping];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    textView.text = text;
    textView.backgroundColor = [UIColor clearColor];
    textView.font = [UIFont systemFontOfSize:font];
    textView.editable = NO;
    if (!text)
        textView = nil;
    [self presentFromRect:rect inView:view withTitle:title withContentView:textView];
}

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withTitle:(NSString *)title withContentView:(UIView *)cView delegate:(id<HNYPopoverViewDelegate>)delegate{
    
}

- (void)presentFromRect:(CGRect)rect inView:(UIView *)view withTitle:(NSString *)title withContentView:(UIView *)cView {
    
    UIView *topView = [self getTopViewOfTheWindow];
    float font = HNYPopoverViewTextFont;
    CGSize size = CGSizeZero;
    if (cView) {
        size = [title sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(cView.frame.size.width,44) lineBreakMode:NSLineBreakByWordWrapping];
        if (size.width < cView.frame.size.width)
            size.width = cView.frame.size.width;
        if (size.height < 44)
            size.height =44;
    }
    else{
        size = [title sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(topView.frame.size.width - 40, topView.frame.size.height *4/5) lineBreakMode:NSLineBreakByWordWrapping];
        if (size.width < topView.frame.size.width - 40)
            size.width = topView.frame.size.width - 40;
        if (size.height < 44)
            size.height = 44;
    }

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.numberOfLines = 0;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.font = [UIFont systemFontOfSize:font];
    if (!title)
        titleLabel = nil;
    
    cView.frame = CGRectMake(0, titleLabel.frame.size.height, cView.frame.size.width, cView.frame.size.height);
    UIView *containtView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, titleLabel.frame.size.height + cView.frame.size.height)];
    
    if (titleLabel)
        [containtView addSubview:titleLabel];
    if (cView)
        [containtView addSubview:cView];
    [self presentFromRect:rect inView:view withContentView:containtView];

}

- (void)presentFromRect:(CGRect)rect inView:(UIView *)view withContentView:(UIView *)cView {

    UIView *topView = [self getTopViewOfTheWindow];
    CGRect topViewFram = topView.frame;
    CGRect rectInTopView = [topView convertRect:rect fromView:view];
    
    //Get the arrowPoint
    CGPoint arrowPoint = CGPointZero;
    arrowPoint.x = CGRectGetMidX(rectInTopView);
    arrowPoint.y = CGRectGetMaxY(rectInTopView);
    if (arrowPoint.y > topViewFram.size.height/2 ){
        self.above = YES;
        arrowPoint.y = CGRectGetMinY(rectInTopView);
    }
    self.arrowPoint = arrowPoint;
    
    CGRect contentRect = CGRectMake(20, 0, cView.frame.size.width, cView.frame.size.height);
    contentRect.origin.y = arrowPoint.y + HNYArrowHeight;
    if (self.above)
        contentRect.origin.y = arrowPoint.y - contentRect.size.height - HNYArrowHeight;
    self.contentRect = contentRect;
    cView.frame = contentRect;
    [self addSubview:cView];
    
}


- (void)presentPopoverAnimated:(BOOL)animated{

    UIView *topView = [self getTopViewOfTheWindow];
    self.layer.anchorPoint = CGPointMake(self.arrowPoint.x / topView.bounds.size.width, self.arrowPoint.y / topView.bounds.size.height);
    self.frame = topView.bounds;
    [topView addSubview:self];
    
    self.alpha = 0.f;
    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    
    //animate into full size
    //First stage animates to 1.05x normal size, then second stage animates back down to 1x size.
    //This two-stage animation creates a little "pop" on open.
    [UIView animateWithDuration:0.2f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1.f;
        self.transform = CGAffineTransformMakeScale(1.05f, 1.05f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.08f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
}

#pragma mark - UITapGestureRecognizer
- (void)tapGestureRecognize:(UITapGestureRecognizer*)gesture{
    CGPoint point = [gesture locationInView:self];
    if (!CGRectContainsPoint(self.view.frame, point)) {
        [self dismissPopoverAnimated:YES];
    }
}

#pragma mark - dismiss popover
- (void)dismissPopoverAnimated:(BOOL)animated{
    if ([self.delegate respondsToSelector:@selector(hNYPopoverViewWillDismissPopover:)]) {
        [self.delegate hNYPopoverViewWillDismissPopover:self];
    }
    
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if ([self.delegate respondsToSelector:@selector(hNYPopoverViewDidDismissPopover:)]) {
            [self.delegate hNYPopoverViewDidDismissPopover:self];
        }
    }];
}
#pragma mark - Get tht key Window top view
- (UIView*)getTopViewOfTheWindow{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window)
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    return [[window subviews] objectAtIndex:0];
}

@end
