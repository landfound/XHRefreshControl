//
//  XHDemoRefreshControl.m
//  XHRefreshControl
//
//  Created by 辉 薛 on 11/7/14.
//  Copyright (c) 2014 tupiance. All rights reserved.
//

#import "XHDemoRefreshControl.h"

@interface XHDemoRefreshControl()
@property (nonatomic, assign) UIEdgeInsets contentInsets;
@end

@implementation XHDemoRefreshControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _titleLabel.text = @"H";
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _titleLabel.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

- (void)setRefreshing:(BOOL)refreshing
{
    if (_refreshing != refreshing) {
        if (refreshing) {
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            animation.toValue = @(-M_PI);
            animation.delegate = self;
            animation.duration = 1.0;
            [_titleLabel.layer addAnimation:animation forKey:@"test"];
            
            _contentInsets = self.refreshView.contentInset;
            _contentInsets.top += CGRectGetHeight(self.bounds);
            [UIView animateWithDuration:0.2 animations:^{
                self.refreshView.contentInset = _contentInsets; // trigger refreshViewDidScroll
            }];
        } else {
            _contentInsets.top -= CGRectGetHeight(self.bounds);
            [UIView animateWithDuration:0.2 animations:^{
                self.refreshView.contentInset = _contentInsets;
            }];
        }
    }
    super.refreshing = refreshing;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (_refreshing) {
        [self.layer addAnimation:anim forKey:@"test"];
    }
}

- (void)refreshViewDidEndDragging:(UIScrollView *)refreshView contentOffset:(CGPoint)contentOffset
{
    if (!self.refreshing && !self.hidden && self.enabled && contentOffset.y + refreshView.contentInset.top < - CGRectGetHeight(self.bounds)) {
        [self beginRefreshing];
    }
}

@end
