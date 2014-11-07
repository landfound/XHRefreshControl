//
//  ViewController.m
//  XHRefreshControl
//
//  Created by 辉 薛 on 11/7/14.
//  Copyright (c) 2014 tupiance. All rights reserved.
//

#import "ViewController.h"
#import "XHWeakObjectAssociator.h"
#import <objc/runtime.h>

#import "XHDemoRefreshControl.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 80, 200, 300)];
    scrollView.alwaysBounceVertical = YES;
    scrollView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:scrollView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [scrollView removeFromSuperview];
    });
    
    XHDemoRefreshControl *refreshControl = [[XHDemoRefreshControl alloc] initWithFrame:CGRectMake(0, -40, 200, 40)];
    [refreshControl addTarget:self action:@selector(didRefreshControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    [scrollView addSubview:refreshControl];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didRefreshControlValueChanged:(XHDemoRefreshControl *)sender
{
    if (sender.refreshing) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [sender endRefreshing];
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
