//
//  HNYTabBar.m
//  Demo
//
//  Created by zqchen on 17/4/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYTabBar.h"

@implementation HNYTabBar
@synthesize backGroundImgView = _backGroundImgView;
#pragma mark - view life cycle
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createBackGroundImgView];
        self.autoresizesSubviews = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        // Initialization code
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)layoutIfNeeded{
    [super layoutIfNeeded];
}
#pragma mark - create background image view
- (void)createBackGroundImgView{
    self.backGroundImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"naviBar"]];
    self.backGroundImgView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:self.backGroundImgView];
}


@end
