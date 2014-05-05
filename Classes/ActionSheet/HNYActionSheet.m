//
//  HNYActionSheet.m
//  VillageEducation
//
//  Created by chenzq on 4/24/14.
//  Copyright (c) 2014 hubei. All rights reserved.
//

#import "HNYActionSheet.h"

@interface HNYActionSheet()<UIActionSheetDelegate>
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *cancelButton;
@property (nonatomic,strong) UIButton *sureButton;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIView *view;
@property (nonatomic,strong) UIButton *buttonClick;

@end

@implementation HNYActionSheet

#pragma mark - vies life cycle
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognize:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

#pragma mark - Class fun
+ (HNYActionSheet*)showWithTitle:(NSString *)title contentView:(UIView *)cView cancelBtnTitle:(NSString *)cTitle sureBtnTitle:(NSString *)sTitle delegate:(id<HNYActionSheetDelegate>)delegate{
    
    HNYActionSheet *sheet = [[HNYActionSheet alloc] initWithFrame:CGRectZero];
    sheet.delegate = delegate;
    [sheet showWithTitle:title contentView:cView cancelBtnTitle:nil sureBtnTitle:nil];
    [sheet show];
    return sheet;
}

+ (HNYActionSheet *)showWithContentView:(UIView *)cView delegate:(id<HNYActionSheetDelegate>)delegate{
    
    HNYActionSheet *sheet = [[HNYActionSheet alloc] initWithFrame:CGRectZero];
    sheet.delegate = delegate;
    [sheet showWithTitle:nil contentView:cView cancelBtnTitle:nil sureBtnTitle:nil];
    [sheet show];
    return sheet;
}

#pragma mark - fun the hide and show HNYActionSheet
- (void)hide{
    CGRect frame = self.view.frame;

    if ([self.delegate respondsToSelector:@selector(hNYActionSheet:willDismissWithButtonIndex:)])
        [self.delegate hNYActionSheet:self willDismissWithButtonIndex:0];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0.1f;
        self.view.frame = CGRectMake(frame.origin.x, self.frame.size.height, frame.size.width, frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if ([self.delegate respondsToSelector:@selector(hNYActionSheet:didDismissWithButtonIndex:)])
            [self.delegate hNYActionSheet:self didDismissWithButtonIndex:self.buttonClick.tag];
    }];

}

- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window)
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    
    UIView *topView = [[window subviews] objectAtIndex:0];
    [topView addSubview:self];

    CGRect frame = self.view.frame;
    self.view.frame = CGRectMake(frame.origin.x, self.frame.size.height, frame.size.width, frame.size.height);

    if ([self.delegate respondsToSelector:@selector(willPresentHNYActionSheet:)])
        [self.delegate willPresentHNYActionSheet:self];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0.7f;
        self.view.frame = frame;
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(didPresentHNYActionSheet:)]) {
            [self.delegate didPresentHNYActionSheet:self];
        }
    }];

}

#pragma mark  - UITapGestureRecognizer
- (void)tapGestureRecognize:(UITapGestureRecognizer*)gesture{
    self.buttonClick = self.cancelButton;
    CGPoint point = [gesture locationInView:self];
    if (!CGRectContainsPoint(self.view.frame, point)) {
        [self hide];
    }
}
#pragma mark - IBAction
- (void)touchButton:(UIButton*)sender{
    self.buttonClick = sender;
    if ([self.delegate respondsToSelector:@selector(hNYActionSheet:clickedButtonAtIndex:)]) {
        [self.delegate hNYActionSheet:self clickedButtonAtIndex:sender.tag];
    }
    [self hide];
    
}


#pragma mark - Create SubViews
- (void)showWithTitle:(NSString*)title contentView:(UIView *)cView cancelBtnTitle:(NSString *)cTitle sureBtnTitle:(NSString *)sTitle{
    
    self.view = [[UIView alloc] init];
    self.contentView = cView;
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = title;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.backgroundColor = [UIColor colorWithRed:43.0/255 green:136.0/255 blue:201.0/255 alpha:1.0];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.tag = 0;
    self.cancelButton.layer.borderWidth = 1;
    self.cancelButton.layer.cornerRadius = 3;
    self.cancelButton.layer.borderColor = [UIColor grayColor].CGColor;
    [self.cancelButton setTitle:cTitle forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self.cancelButton setBackgroundColor:self.titleLabel.backgroundColor];
    [self.cancelButton addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureButton.tag = 1;
    self.sureButton.layer.borderWidth = 1;
    self.sureButton.layer.cornerRadius = 3;
    self.sureButton.layer.borderColor = [UIColor grayColor].CGColor;
    [self.sureButton setTitle:sTitle forState:UIControlStateNormal];
    [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self.sureButton setBackgroundColor:self.titleLabel.backgroundColor];
    [self.sureButton addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
    
    if (title)
        [self.view addSubview:self.titleLabel];
    if (cView)
        [self.view addSubview:self.contentView];
    if (cTitle)
        [self.view addSubview:self.cancelButton];
    if (sTitle)
        [self.view addSubview:self.sureButton];
    [self addSubview:self.view];
    [self setTheFrame];
}
- (void)setTheFrame{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window)
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    
    UIView *topView = [[window subviews] objectAtIndex:0];
    
    self.layer.backgroundColor = [[UIColor lightGrayColor] CGColor];
    self.layer.opacity = 0.1;
    self.frame = topView.bounds;

    CGSize size = topView.bounds.size;
    CGSize titleLabelSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    if (titleLabelSize.height < HNYActionSheetButtonHeight)
        titleLabelSize.height = HNYActionSheetButtonHeight;
    self.titleLabel.frame = CGRectMake(0, 0, size.width, titleLabelSize.height);
    
    CGFloat height = self.titleLabel.frame.size.height;
    if (!self.titleLabel.text)
        height -= height;
    
    self.contentView.frame = CGRectMake(0, height, size.width, self.contentView.frame.size.height);
    height += self.contentView.frame.size.height;
    
    if (self.sureButton.titleLabel.text) {
        self.sureButton.frame = CGRectMake(size.width/2-1, height, size.width/2+2, HNYActionSheetButtonHeight + 1);
        self.cancelButton.frame = CGRectMake(-1, height, size.width/2+2, HNYActionSheetButtonHeight + 1);
        height += HNYActionSheetButtonHeight;
    }
    else if (self.cancelButton.titleLabel.text){
        self.cancelButton.frame = CGRectMake(-1, height, size.width+2, HNYActionSheetButtonHeight + 1);
        height += HNYActionSheetButtonHeight;
    }
    
    self.view.frame = CGRectMake(0, size.height - height, size.width, height);

}

@end
