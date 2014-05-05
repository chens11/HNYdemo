//
//  HNYNavigationBar.m
//  Demo
//
//  Created by zqchen on 17/4/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYNavigationBar.h"

@implementation HNYNavigationBar
@synthesize backGroundImgView = _backGroundImgView;
@synthesize title = _title;
@synthesize titleLable = _titleLable;
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

#pragma mark - create background image view 
- (void)createBackGroundImgView{
    self.backGroundImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"naviBar"]];
    self.backGroundImgView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:self.backGroundImgView];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


@end
