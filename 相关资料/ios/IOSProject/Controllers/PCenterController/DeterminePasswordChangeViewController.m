//
//  DeterminePasswordChangeViewController.m
//  IOSProject
//
//  Created by IOS004 on 15/6/9.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//
/**
 密码修改,设置新密码
 */

#import "DeterminePasswordChangeViewController.h"
#import "PersonalCenterMainPage.h"

@interface DeterminePasswordChangeViewController ()

@end

@implementation DeterminePasswordChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButtonToNavigation];
    self.navigationItem.title = @"修改密码";
    
    /**
     添加背景色；
     */
    UIImageView * screenImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    screenImage.backgroundColor = [UIColor colorFromHexCode:@"Color_bkg_green"];
    [self.view addSubview:screenImage];
    /**
     新密码输入框
     */
    NSArray * arr = @[@"重置密码",@"确认密码"];
    for (NSInteger i = 0; i < 2; i ++) {
        UIImageView * lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width/2 - 145, 85 + (50 * i), 290, 10)];
        lineImage.image = [UIImage imageNamed:@"denglu_bt_press@2x"];
        [self.view addSubview:lineImage];
        
        UIImageView * iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width/2 - 135, 60 + (50 * i), 25, 25)];
        iconImage.image = [UIImage imageNamed:@"grcenter_pic_mima@3x"];
        [self.view addSubview:iconImage];
        
        UILabel * promptLable = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width/2 - 100, 57.5 + (50 * i), 80, 30)];
        promptLable.text = arr[i];
        [self.view addSubview:promptLable];
    }
    /**
     新密码输入提示框
     */
    UITextField * nameText = [[UITextField alloc] initWithFrame:CGRectMake(self.view.width/2 - 20, 57.5, 175, 30)];
    nameText.placeholder = @"请设置秘密";
    nameText.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:nameText];
    
    UITextField * codeText = [[UITextField alloc] initWithFrame:CGRectMake(self.view.width/2 - 20, 107.5, 175, 30)];
    codeText.placeholder = @"请再次输入密码";
    codeText.clearButtonMode = UITextFieldViewModeAlways;
    codeText.secureTextEntry = YES;
    [self.view addSubview:codeText];
    
    /**
     确认按钮
     */
    UIButton * nextbtn = [UIButton roundedRectButtonWithTitle:@"确认" color:[UIColor colorFromHexCode:@"#dededd"] raduis:5.0];
    nextbtn.frame = CGRectMake(self.view.width/2 - 145, 215, 290, 45);
    [nextbtn addTarget:self action:@selector(backToCenter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextbtn];
}

/**
 跳转到个人中心
 */
- (void)backToCenter{
    PersonalCenterMainPage * personalcenter = [[PersonalCenterMainPage alloc] init];
    [self.navigationController pushViewController:personalcenter animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
