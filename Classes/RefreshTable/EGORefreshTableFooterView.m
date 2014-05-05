//
//  EGORefreshTableFooterView.m
//  Demo
//
//修改人：禚来强 iphone开发qq群：79190809 邮箱：zhuolaiqiang@gmail.com
//

#import "EGORefreshTableFooterView.h"

#define RefreshViewHight 35.0f
#define TEXT_COLOR [UIColor blackColor]
#define SHADOW_COLOR [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
#define FLIP_ANIMATION_DURATION 0.18f


@interface EGORefreshTableFooterView(Private)

- (void)setState:(EGOPullRefreshState)aState;

@end

@implementation EGORefreshTableFooterView

@synthesize delegate = _delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		//self.backgroundColor = [UIColor blackColor];
        
		_lastUpdatedLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.0f, 25.0f, self.frame.size.width-30.0f, 20.0f)];
		_lastUpdatedLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		_lastUpdatedLabel.font = [UIFont systemFontOfSize:12.0f];
		_lastUpdatedLabel.textColor = TEXT_COLOR;
		_lastUpdatedLabel.shadowColor = SHADOW_COLOR;
		_lastUpdatedLabel.shadowOffset = CGSizeMake(1.0f, 1.0f);
		_lastUpdatedLabel.backgroundColor = [UIColor clearColor];
		_lastUpdatedLabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:_lastUpdatedLabel];
        
		_statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.0f, 5.0f, self.frame.size.width-30.0f, 20.0f)];
		_statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		_statusLabel.font = [UIFont boldSystemFontOfSize:13.0f];
		_statusLabel.textColor = TEXT_COLOR;
		_statusLabel.shadowColor = SHADOW_COLOR;
		_statusLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		_statusLabel.backgroundColor = [UIColor clearColor];
		_statusLabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:_statusLabel];
        
        CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(5.0f, 5.0f, 21.0f, 37.0f);
		layer.contentsGravity = kCAGravityResizeAspect;
		layer.contents = (id)[UIImage imageNamed:@"pullArrowDark.png"].CGImage;

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
			layer.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif

		[[self layer] addSublayer:layer];
		_arrowImage = layer;
        
		UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		view.frame = CGRectMake(5.0f, (RefreshViewHight - 22.0f), 20.0f, 20.0f);
		[self addSubview:view];
		_activityView = view;
		[self setState:EGOOPullRefreshNormal];
    }
    
    return self;
}

#pragma mark - Setters

- (void)refreshLastUpdatedDate
{
	if ([_delegate respondsToSelector:@selector(egoRefreshTableFooterDataSourceLastUpdated:)])
    {
		NSDate *date = [_delegate egoRefreshTableFooterDataSourceLastUpdated:self];
        if(date != nil){
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            _lastUpdatedLabel.text = [NSString stringWithFormat:@"最后加载: %@", [formatter stringFromDate:date]];
        }else {
            _lastUpdatedLabel.text = nil;
        }
	}else{
		_lastUpdatedLabel.text = nil;
	}
}

- (void)setState:(EGOPullRefreshState)aState
{
    switch(aState)
    {
		case EGOOPullRefreshPulling:
			_statusLabel.text = NSLocalizedString(@"松开即可加载...", @"松开即可加载...");
            [CATransaction begin];
			[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
			_arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
			[CATransaction commit];
			break;
            
		case EGOOPullRefreshNormal:
			_statusLabel.text = NSLocalizedString(@"上拉载入更多...", @"上拉载入更多...");
            if (_state == EGOOPullRefreshPulling) {
				[CATransaction begin];
				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
				_arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];
			}

			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			_arrowImage.hidden = NO;
			_arrowImage.transform = CATransform3DIdentity;
			[CATransaction commit];
            
            [_activityView stopAnimating];
			[self refreshLastUpdatedDate];
			break;
            
		case EGOOPullRefreshLoading:
			_statusLabel.text = NSLocalizedString(@"加载中...", @"加载中...");
			[_activityView startAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			_arrowImage.hidden = YES;
			[CATransaction commit];
			break;
            
		default:
			break;
	}
    
	_state = aState;
}

#pragma mark - ScrollView Methods

//手指屏幕上不断拖动调用此方法
- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_state == EGOOPullRefreshLoading) {
        
		//CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
		//offset = MIN(offset, 60);
		scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0f, self.frame.size.height, 0.0f);
        
	} else if (scrollView.isDragging) {
        
		BOOL _loading = NO;
		if ([_delegate respondsToSelector:@selector(egoRefreshTableFooterDataSourceIsLoading:)]) {
			_loading = [_delegate egoRefreshTableFooterDataSourceIsLoading:self];
		}
        
		if (_state == EGOOPullRefreshPulling && scrollView.contentOffset.y + scrollView.frame.size.height < scrollView.contentSize.height + self.frame.size.height && scrollView.contentOffset.y > 0.0f && !_loading) {
			[self setState:EGOOPullRefreshNormal];
		} else if (_state == EGOOPullRefreshNormal && scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height + self.frame.size.height  && !_loading) {
			[self setState:EGOOPullRefreshPulling];
		}
        
		if (scrollView.contentInset.bottom != 0) {
			scrollView.contentInset = UIEdgeInsetsZero;
		}
	}
}

//当用户停止拖动，并且手指从屏幕中拿开的的时候调用此方法
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView
{
	BOOL _loading = NO;
	if ([_delegate respondsToSelector:@selector(egoRefreshTableFooterDataSourceIsLoading:)]) {
		_loading = [_delegate egoRefreshTableFooterDataSourceIsLoading:self];
	}
    
	if(self.frame.size.height > 0  && scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height + self.frame.size.height && !_loading){
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, self.frame.size.height, 0.0f);
		[UIView commitAnimations];
        
		[self setState:EGOOPullRefreshLoading];
		if ([_delegate respondsToSelector:@selector(egoRefreshTableFooterDidTriggerRefresh:)]){
            [_delegate egoRefreshTableFooterDidTriggerRefresh:self];
		}
	}
}

//当页面数据刷新完毕调用此方法
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView scrollFooterBack:(BOOL)animate withEdgeInsets:(UIEdgeInsets)edgeInsets;
{
	[self setState:EGOOPullRefreshNormal];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
    if(animate){
        [scrollView setContentInset:edgeInsets];
    }
	[UIView commitAnimations];
}


@end