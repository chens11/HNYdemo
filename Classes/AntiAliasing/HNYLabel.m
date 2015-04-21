//
//  HNYLabel.m
//  Demo
//
//  Created by zq chen on 4/17/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "HNYLabel.h"

@implementation HNYLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGPoint pointFromWindow = [[[UIApplication sharedApplication] keyWindow] convertPoint:self.frame.origin fromView:[self superview]];
    if (pointFromWindow.x - (int)pointFromWindow.x > 0 || pointFromWindow.y - (int)pointFromWindow.y) {
        CGPoint point1 = [[self superview] convertPoint:CGPointMake((int)(pointFromWindow.x + .5),(int)(pointFromWindow.y + .5)) fromView:[[UIApplication sharedApplication] keyWindow]];
        if (self.frame.size.width - (int)self.frame.size.width > 0 && self.frame.size.height - (int)self.frame.size.height > 0) {
            self.frame = CGRectMake(point1.x, point1.y, (int)self.frame.size.width, (int)self.frame.size.height);
        }
    }
}

@end
