//
//  CCWebViewController.h
//  CCFramework
//
//  Created by Kiwi on 12/9/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import "CCViewController.h"

@interface CCWebViewController : CCViewController

@property (strong, nonatomic) UIWebView * webView;
@property (assign, nonatomic) BOOL postMethod;

+ (id)controllerWithNavigation:(Class)class URL:(NSString*)url title:(NSString*)title parameters:(NSDictionary*)params;

- (id)initWithURL:(NSString*)url title:(NSString*)title;
- (id)initWithURL:(NSString*)url title:(NSString*)title parameters:(NSDictionary*)params;

@end
