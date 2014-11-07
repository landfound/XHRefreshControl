//
//  XHWeakObjectAssociator.m
//  XHRefreshControl
//
//  Created by 辉 薛 on 11/7/14.
//  Copyright (c) 2014 tupiance. All rights reserved.
//

#import "XHWeakObjectAssociator.h"

@implementation XHWeakObjectAssociator

- (instancetype)init
{
    self = [super init];
    if (self) {
        _owners = [NSHashTable weakObjectsHashTable];
    }
    return self;
}

- (void)dealloc
{
    for (id<XHWeakObjectOwner> owner in _owners.allObjects) {
        if ([owner respondsToSelector:@selector(willLoseWeakObject:)]) {
            [owner willLoseWeakObject:_weakObject];
        }
    }
}

@end