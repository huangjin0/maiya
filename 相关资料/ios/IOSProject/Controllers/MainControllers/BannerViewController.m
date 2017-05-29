//
//  BannerViewController.m
//  IOSProject
//
//  Created by IOS002 on 15/6/3.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BannerViewController.h"

@interface BannerViewController ()

@end

@implementation BannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    UIImageView * bannerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.width)];
    bannerImage.image = [UIImage imageNamed:@""];
    [self.view addSubview:bannerImage];
}

@end
