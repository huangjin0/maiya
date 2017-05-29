//
//  loadingViewController.m
//  IOSProject
//
//  Created by wkfImac on 15/7/6.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "loadingViewController.h"
#import "LoadingPageCell.h"
#import "CommodityViewController.h"

@interface LoadingViewController ()<UIWebViewDelegate>{
    UIWebView * _webview;
}

@property(nonatomic, strong)NSMutableArray *dataListOne;
@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载在webview
    NSString * webviewhtml = [NSString stringWithFormat:@"http://%@",strDescription];
//    NSString * webviewhtml = [NSString stringWithFormat:@"http:www.baidu.com"];
    CGRect frame = self.view.bounds;
    frame.size.height -= 84;
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(2, 10, ScreenWidth - 4, ScreenHeight - 100)];
    view1.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:view1];
    
    UIScrollView * scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, ScreenHeight)];
    scrollview.backgroundColor = [UIColor blueColor];
    scrollview.contentOffset = CGPointMake(0, 100);
//    [self.view addSubview:scrollview];
    _webview = [[UIWebView alloc] initWithFrame:frame];
    _webview.scrollView.bounces = NO;
//    _webview.scrollView.scrollsToTop = NO;
//    _webview.scrollView.alwaysBounceVertical = NO;
    [self.view addSubview:_webview];
//    _webview.scalesPageToFit = NO;
    _webview.delegate = self;
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:webviewhtml]];
    [_webview loadRequest:request];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}

@end
