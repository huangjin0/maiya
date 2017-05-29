//
//  CommodityBannerViewController.m
//  IOSProject
//
//  Created by wkfImac on 15/7/6.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "CommodityBannerViewController.h"

@interface CommodityBannerViewController ()

@end

@implementation CommodityBannerViewController

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
