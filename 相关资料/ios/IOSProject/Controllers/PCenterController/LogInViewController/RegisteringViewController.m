//
//  registeringViewController.m
//  IOSProject
//
//  Created by IOS004 on 15/6/17.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "RegisteringViewController.h"
#import "MemberRegistrationViewController.h"

@interface RegisteringViewController ()<UITextFieldDelegate>

{
    UITextField * _nameText;   //用户名
    UITextField * _codeText;   //验证码
    UIButton * _codebtn;       //获取验证码
    UIButton * _nextbtn;        //下一步按钮
//    NSTimer * _timer;           //倒计时时间
    int _countDownTime;
    
}

@property (strong, nonatomic) NSString * code;
@property (strong, nonatomic) NSString * phone;

@end

@implementation RegisteringViewController


/*
 ***点击背景textField退出焦点
 */

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_nameText resignFirstResponder];
    [_codeText resignFirstResponder];
}
    

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view endEditing:YES];
    // Do any additional setup after loading the view.
    [self addBackButtonToNavigation];
    self.navigationItem.title = @"会员注册";
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
    NSArray *imageNameArr = @[@"iSH_UserName",@"iSH_verifyCode"];
    for (NSInteger i = 0; i < 2; i ++) {
        UIImageView * lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(16, 85 + (50 * i), ViewWidth - 32, 10)];
        lineImage.image = [UIImage imageNamed:@"iSH_BottomLine"];
        [self.view addSubview:lineImage];
    
        UIImageView * iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(25, 60 + (50 * i), 25, 25)];
        iconImage.image = [UIImage imageNamed:imageNameArr[i]];
        [self.view addSubview:iconImage];
        
        UILabel * promptLable = [[UILabel alloc] initWithFrame:CGRectMake(50, 57.5 + (50 * i), 80, 30)];
        promptLable.text = arr[i];
        [self.view addSubview:promptLable];
    }
    
    /**
     用户名和验证码输入框
     */
    _nameText = [[UITextField alloc] initWithFrame:CGRectMake(130, 57.5, ViewWidth - 146, 30)];
    _nameText.placeholder = @"请输入手机号";
    _nameText.clearButtonMode = UITextFieldViewModeAlways;
    _nameText.keyboardType = UIKeyboardTypeNumberPad;
    _nameText.delegate = self;
    _nameText.tag = 1;
    [self.view addSubview:_nameText];
    
    _codeText = [[UITextField alloc] initWithFrame:CGRectMake(130, 107.5, ViewWidth - 146, 30)];
    _codeText.placeholder = @"请输入验证码";
    _codeText.clearButtonMode = UITextFieldViewModeAlways;
    _codeText.keyboardType = UIKeyboardTypeNumberPad;
    _codeText.delegate = self;
    _codeText.tag = 2;
    [self.view addSubview:_codeText];
    
    
    _codebtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width/2 - 100, 160, 200, 30)];
    [_codebtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_codebtn setTitleColor:RGBCOLOR(255, 95, 5) forState:UIControlStateNormal];
    [_codebtn addTarget:self action:@selector(clickCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_codebtn];
//    _codebtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width/2 - 150, 160, 300, 30)];
    /**
     下一步按钮
     */
//    _nextbtn = [UIButton roundedRectButtonWithTitle:@"下一步" color:[UIColor colorFromHexCode:@"#dededd"] raduis:5.0];
    _nextbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextbtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextbtn setBackgroundColor:[UIColor colorFromHexCode:@"#dededd"]];
    _nextbtn.userInteractionEnabled = NO;
    _nextbtn.layer.cornerRadius = 5.0;
    _nextbtn.frame = CGRectMake(16, 215, ViewWidth - 32, 45);
    [_nextbtn addTarget:self action:@selector(memberRegistration) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextbtn];
    
//    添加用户名密码文本框输入监听，改变下一步按钮状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChangedInfo) name:UITextFieldTextDidChangeNotification object:nil];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

/**
 * 点击背景键盘隐藏
 */
-(void)keyboardHide:(UITapGestureRecognizer*)tap {
    [_nameText resignFirstResponder];
    [_codeText resignFirstResponder];
}

/**
 * 点击return键盘隐藏
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_nameText resignFirstResponder];
    [_codeText resignFirstResponder];
    return YES;
}

/**
 * 限制输入字符长度
 */
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (textField.tag == 1) {
        if (_nameText.text.length >= 11) {
            return NO;
        } else {
            return YES;
        }
    }
    if (textField.tag == 2) {
        if (_codeText.text.length >= 6) {
            return NO;
        } else {
            return YES;
        }
    } else {
        return YES;
    }
}

/**
 ***获取验证码
 */
- (void)clickCode{
    if (_nameText.text.isPhone) {
        [self startRequest:1];
        //        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    } else {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alerView show];
    }
}

/**
 * 获取验证码倒计时
 */
-(void)timeCountDown {
    _codeText.userInteractionEnabled = YES;
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){
            //倒计时结束，关闭
            dispatch_source_cancel(_timer);
//            _nameText.userInteractionEnabled = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示
                [_codebtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
                [_codebtn setTitleColor:RGBCOLOR(255, 95, 5) forState:UIControlStateNormal];
                _codebtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout;
//            _nameText.userInteractionEnabled = NO;
            NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示
                [_codebtn setTitle:[NSString stringWithFormat:@"重新获取验证码(%@s)",strTime] forState:UIControlStateNormal];
                [_codebtn setTitleColor:[UIColor colorFromHexCode:@"#b3b3b3"] forState:UIControlStateNormal];
                _codebtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

/**
 会员注册
 */
- (void)memberRegistration{
    [self startRequest:2];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Requests
- (BOOL)startRequest:(NSInteger)requestID{
    if ([super startRequest:requestID]) {
        if (requestID == 1) {
            [_client getRegisterVerifyCodeWithPhone:_nameText.text];
        } else {
            [_client getCode:_codeText.text phone:_nameText.text];
        }
        return YES;
    }
    return NO;
}

- (BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result{
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 1) {
            [self timeCountDown];
        } else {
            MemberRegistrationViewController *memberRigisVC = [[MemberRegistrationViewController alloc] init];
            if (_type == 1) {
                memberRigisVC.type = 1;
            }
            memberRigisVC.phoneNum = _nameText.text;
            [self.navigationController pushViewController:memberRigisVC animated:YES];
        }
        return YES;
    }
    return NO;
}

#pragma mark - UITextFieldDelegate



/*
 ***文本框监听
 */
-(void)textFieldChangedInfo {
    if (_nameText.text.length == 11 && _codeText.text.length == 6) {
         _nextbtn.backgroundColor = RGBCOLOR(255, 95, 5);
        _nextbtn.userInteractionEnabled = YES;
    } else {
        [_nextbtn setBackgroundColor:[UIColor colorFromHexCode:@"#dededd"]];
        _nextbtn.userInteractionEnabled = NO;
    }
}

@end
