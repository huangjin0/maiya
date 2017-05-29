//
//  BasicTableViewController.m
//  DoctorFixBao
//
//  Created by Kiwi on 11/25/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import "BasicTableViewController.h"

@interface BasicTableViewController ()

@end

@implementation BasicTableViewController

- (id)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_tableView.style == UITableViewStyleGrouped) {
        UIView * bkg = [UIView new];
        bkg.backgroundColor = RGBCOLOR(243, 243, 243);
        _tableView.backgroundView = bkg;
    }
}


//默认的黑色（UIStatusBarStyleDefault）
//白色（UIStatusBarStyleLightContent）
#pragma mark - UIStatusBarStyle
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}
- (BOOL)prefersStatusBarHidden {
    return NO;
}

@end
