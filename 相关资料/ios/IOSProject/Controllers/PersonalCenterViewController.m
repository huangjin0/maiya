//
//  PersonalCenterViewController.m
//  IOSProject
//
//  Created by IOS002 on 15/5/30.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "RegisteringViewController.h"
#import "SetUpViewController.h"
#import "loginingViewController.h"
#import "MsgCenViewController.h"

@interface PersonalCenterViewController () {
//添加scrollView
    UIScrollView *_scrollView;
}

@end

@implementation PersonalCenterViewController

- (id)init{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /**
     设置navigationItem；
     */
    self.navigationItem.title = @"个人中心";
  
//    UIButton * leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftbtn setBackgroundImage:[UIImage imageNamed:@"grcenter_ic_setting_normal"] forState:UIControlStateNormal];
//    [leftbtn addTarget:self action:@selector(setUp) forControlEvents:UIControlEventTouchUpInside];
//    leftbtn.frame = CGRectMake(10, 10, 20, 20);
//    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
//    self.navigationItem.leftBarButtonItem = leftButton;
//    
//    UIButton * rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightbtn setBackgroundImage:[UIImage imageNamed:@"mynews_ic_normal"] forState:UIControlStateNormal];
//    [rightbtn addTarget:self action:@selector(messageCenter) forControlEvents:UIControlEventTouchUpInside];
//    rightbtn.frame = CGRectMake(10, 10, 20, 20);
//    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
//    self.navigationItem.rightBarButtonItem = rightButton;
//    self.view.backgroundColor = Color_bkg_lightGray;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    [self.view addSubview:_scrollView];
    CGFloat scrollSize = self.view.height > 560 ? self.view.height : 560;
    _scrollView.contentSize = CGSizeMake(self.view.width, scrollSize);
    
    [self unLogInViewLoad];
}

//  若未登录，加载
-(void)unLogInViewLoad {
    /**
     添加背景色；
     */
//    UIImageView * self.view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
//    self.view.backgroundColor = [UIColor colorFromHexCode:@"Color_bkg_green"];
//    [self.view addSubview:self.view];
    
    /**
     添加按钮及图标；
     */
    UIImageView * personalImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width/2 - 70, 65, 140, 140)];
    
    personalImage.image = [UIImage imageNamed:@"grcenter_pic"];
    [_scrollView addSubview:personalImage];
    
    UILabel * personalLable = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width/2 - 45, 245, 90, 15)];
    personalLable.text = @"您还未登录";
    personalLable.textColor = [UIColor grayColor];
    [_scrollView addSubview:personalLable];
    
    UIButton * loginbtn = [UIButton roundedRectButtonWithTitle:@"登陆" color:[UIColor colorFromHexCode:@"#60b63c"] raduis:5.0];
    loginbtn.frame = CGRectMake(16, 290, ViewWidth - 32, 45);
    [loginbtn addTarget:self action:@selector(loginPage) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:loginbtn];
    UIButton * registerbtn = [UIButton roundedRectButtonWithTitle:@"注册" color:[UIColor colorFromHexCode:@"#dfdfdd"] raduis:5.0];
    registerbtn.frame = CGRectMake(16, 350, ViewWidth - 32, 45);
    [registerbtn addTarget:self action:@selector(registerPage) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:registerbtn];
}

/**
 跳转到设置页面
 */
- (void)setUp{
    SetUpViewController * setup = [[SetUpViewController alloc] init];
//    setup.delegate = self;
    [self.navigationController pushViewController:setup animated:NO];
}
/**
 跳转到消息中心
 */
- (void)messageCenter {
    if ([IEngine engine].isSignedIn) {
        MsgCenViewController *msgCenVC = [[MsgCenViewController alloc] init];
        [self.navigationController pushViewController:msgCenVC animated:YES];
    } else {
//        [CCAlertView showText:@"请先登陆登陆" life:2];
    }
}

/**
 跳转到登陆页面
 */
- (void)loginPage{
    LoginingViewController * login = [[LoginingViewController alloc] init];
//    login.delegate = self;
    [self.navigationController pushViewController:login animated:YES];
}

/**
 跳转到注册页面
 */
- (void)registerPage{
    RegisteringViewController * registerViewController = [[RegisteringViewController alloc] init];
    [self.navigationController pushViewController:registerViewController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
