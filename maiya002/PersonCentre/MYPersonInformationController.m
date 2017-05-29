//
//  MYPersonInformationController.m
//  maiya002
//
//  Created by HuangJin on 16/9/17.
//  Copyright © 2016年 com. All rights reserved.
//

#import "MYPersonInformationController.h"
#import "D5BarItem.h"

@interface MYPersonInformationController ()

@end
@implementation MYPersonInformationController

-(void)viewDidLoad
{
    [super viewDidLoad];
//    [self setNavigation];
    self.navigationItem.title=@"个人中心";
//    [D5BarItem setLeftBarItemWithImage:IMAGE(@"back2_ic_normal.png") target:self action:@selector(back)];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [D5BarItem setLeftBarItemWithImage:IMAGE(@"back2_ic_normal.png") target:self action:@selector(back)];
  

}

//- (void)setNavigation {
//    self.navigationItem.rightBarButtonItem.enabled = NO;
//    [self setNavigationBarHidden:NO];
//    [self setNavigationBarColor:[UIColor whiteColor]];
//    [self setNavigationTitleColor:[UIColor whiteColor]];
//    [self setStatusBarStyle:UIBarStyleBlack];
//}

@end
