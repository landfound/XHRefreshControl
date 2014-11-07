//
//  XHRefreshControl.h
//  XHRefreshControl
//
//  Created by 辉 薛 on 11/7/14.
//  Copyright (c) 2014 tupiance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHWeakObjectAssociator.h"

@interface XHRefreshControl : UIControl
{
    BOOL _refreshing;
    __weak UIScrollView *_refreshView;
    CGPoint _contentOffset;
    BOOL _lastDragging;
}

@property (nonatomic, assign) BOOL refreshing; // subclass
@property (nonatomic, weak) UIScrollView *refreshView;

- (void)beginRefreshing;
- (void)endRefreshing;

- (void)refreshViewDidScroll:(UIScrollView *)refreshView;
- (void)refreshViewDidEndDragging:(UIScrollView *)refreshView contentOffset:(CGPoint)contentOffset;

@end
