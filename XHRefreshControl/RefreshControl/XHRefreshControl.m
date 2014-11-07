//
//  XHRefreshControl.m
//  XHRefreshControl
//
//  Created by 辉 薛 on 11/7/14.
//  Copyright (c) 2014 tupiance. All rights reserved.
//

#import "XHRefreshControl.h"

static char XHRefreshControlObserverContext = '\0';

@interface XHRefreshControl () 
@end

@implementation XHRefreshControl

- (void)dealloc
{
    [_refreshView removeObserver:self forKeyPath:@"contentOffset" context:&XHRefreshControlObserverContext];
}

- (UIScrollView *)refreshView
{
    return _refreshView;
}

- (void)setRefreshing:(BOOL)refreshing
{
    if (_refreshing != refreshing) {
        _refreshing = refreshing;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

// maybe we should use weak object associator
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    _refreshView = nil;
    if([self.superview isKindOfClass:[UIScrollView class]]){
        [self.superview removeObserver:self forKeyPath:@"contentOffset" context:&XHRefreshControlObserverContext];
    }
    if ([newSuperview isKindOfClass:[UIScrollView class]]) {
        _refreshView = (UIScrollView *)newSuperview;
        [newSuperview addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:&XHRefreshControlObserverContext];
    }
    [super willMoveToSuperview:newSuperview];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(UIScrollView *)object change:(NSDictionary *)change context:(void *)context
{
    if (context == &XHRefreshControlObserverContext) {
        CGPoint contentOffset = _contentOffset;
        _contentOffset = object.contentOffset;
        if (!CGPointEqualToPoint(contentOffset, _contentOffset)) {
            [self refreshViewDidScroll:object];
        }
        if (_lastDragging && !object.dragging) {
            _lastDragging = NO;
            [self refreshViewDidEndDragging:object contentOffset:contentOffset];
        }
        _lastDragging = object.dragging;

    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)beginRefreshing
{
    self.refreshing = YES;
}

- (void)endRefreshing
{
    self.refreshing = NO;
}

- (void)refreshViewDidScroll:(UIScrollView *)refreshView
{
    
}

- (void)refreshViewDidEndDragging:(UIScrollView *)refreshView contentOffset:(CGPoint)contentOffset
{
    
}

@end
