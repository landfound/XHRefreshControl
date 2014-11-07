//
//  XHWeakObjectAssociator.h
//  XHRefreshControl
//
//  Created by 辉 薛 on 11/7/14.
//  Copyright (c) 2014 tupiance. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XHWeakObjectAssociator;
@protocol XHWeakObjectOwner <NSObject>
- (void)willLoseWeakObject:(__unsafe_unretained id)object;
@end

@interface XHWeakObjectAssociator : NSObject
@property (nonatomic, unsafe_unretained) id weakObject;
@property (nonatomic, strong, readonly) NSHashTable *owners;
@end