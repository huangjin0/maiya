//
//  PasswordChangeViewController.m
//  IOSProject
//
//  Created by IOS004 on 15/6/9.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//
/**
 密码修改
 */

#import "PasswordChangeViewController.h"
#import "DeterminePasswordChangeViewController.h"

@interface PasswordChangeViewController ()

{
//    获取验证码
    UIButton * _codebtn;
}

@end

@implementation PasswordChangeViewController

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
     用户名和验证码
     */
    NSArray * arr = @[@"用户名",@"验证码"];
    NSArray * iconarr = @[@"grcenter_pic_yonghuming",@"grcenter_ic_yanzhengma"];
//    NSArray * linearr = @[@"denglu_bt_press",@""];
    
    for (NSInteger i = 0; i < 2; i ++) {
        UIImageView * lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width/2 - 145, 85 + (50 * i), 290, 10)];
        lineImage.image = [UIImage imageNamed:@"denglu_bt_press"];
        [self.view addSubview:lineImage];
        
        UIImageView * iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width/2 - 135, 60 + (50 * i), 25, 25)];
        iconImage.image = [UIImage imageNamed:iconarr[i]];
        [self.view addSubview:iconImage];
        
        UILabel * promptLable = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width/2 - 100, 57.5 + (50 * i), 80, 30)];
        promptLable.text = arr[i];
        [self.view addSubview:promptLable];
    }
    /**
     用户名和验证码输入框
     */
    UITextField * nameText = [[UITextField alloc] initWithFrame:CGRectMake(self.view.width/2 - 30, 57.5, 175, 30)];
    nameText.placeholder = @"请输入手机号";
    nameText.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:nameText];
    
    UITextField * codeText = [[UITextField alloc] initWithFrame:CGRectMake(self.view.width/2 - 30, 107.5, 175, 30)];
    codeText.placeholder = @"请输入验证码";
    codeText.clearButtonMode = UITextFieldViewModeAlways;
    codeText.secureTextEntry = YES;
    [self.view addSubview:codeText];
    
    _codebtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width/2 - 50, 160, 100, 30)];
    [_codebtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_codebtn setTitleColor:[UIColor colorFromHexCode:@"#489925"] forState:UIControlStateNormal];
    [_codebtn addTarget:self action:@selector(clickCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_codebtn];
    /**
     下一步按钮
     */
    UIButton * nextbtn = [UIButton roundedRectButtonWithTitle:@"下一步" color:[UIColor colorFromHexCode:@"#dededd"] raduis:5.0];
    nextbtn.frame = CGRectMake(self.view.width/2 - 145, 215, 290, 45);
    [nextbtn addTarget:self action:@selector(resetPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextbtn];
}

/**
 点击获取验证码
 */
- (void)clickCode{
    [self startRequest:0];
}
/**
 点击下一步按钮跳转
 */
- (void)resetPassword{
    DeterminePasswordChangeViewController * determinepasswordchange = [[DeterminePasswordChangeViewController alloc] init];
    [self.navigationController pushViewController:determinepasswordchange animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -CCRequest
-(BOOL)startRequest:(NSInteger)requestID {
    if ([super startRequest:requestID]) {
        return YES;
    }
    return NO;
}

-(BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result {
    if ([super client:sender didFinishLoadingWithResult:result]) {
        return YES;
    }
    return NO;
}


@end
