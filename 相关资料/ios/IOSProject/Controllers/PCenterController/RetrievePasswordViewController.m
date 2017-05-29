//
//  RetrievePasswordViewController.m
//  IOSProject
//
//  Created by IOS002 on 15/6/4.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "RetrievePasswordViewController.h"
#import "ResetPasswordViewController.h"

@interface RetrievePasswordViewController () <UITextFieldDelegate>

{
    //    获取验证码
    UIButton * _codebtn;
    //    用户名文本框
    UITextField * _nameText;
    //    验证码文本框
    UITextField * _codeText;
//    下一步按钮
    UIButton * _nextbtn;
//    验证码
    NSString *_codeStr;
    dispatch_source_t _timer;
}

@property (strong, nonatomic) NSString * phone;

@end

@implementation RetrievePasswordViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButtonToNavigation];
    if (self.type == 1) {
        self.navigationItem.title  = @"修改密码";
    } else {
        self.navigationItem.title = @"找回密码";
    }
    
    
    
    /**
     添加背景色；
     */
    UIImageView * screenImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    screenImage.backgroundColor = [UIColor colorFromHexCode:@"Color_bkg_green"];
    [self.view addSubview:screenImage];
    /**
     用户名和验证码
     */
    NSArray *imageNameArr = @[@"iSH_UserName",@"iSH_verifyCode"];
    NSArray * arr = @[@"用户名",@"验证码"];
    for (NSInteger i = 0; i < 2; i ++) {
        UIImageView * lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(16, 85 + (50 * i), ViewWidth - 32, 10)];
        lineImage.image = [UIImage imageNamed:@"iSH_BottomLine"];
        [self.view addSubview:lineImage];
        
        UIImageView * iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(25, 60 + (50 * i), 25, 25)];
        iconImage.image = [UIImage imageNamed:imageNameArr[i]];
        [self.view addSubview:iconImage];
        
        UILabel * promptLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 57.5 + (50 * i), 80, 30)];
        promptLable.text = arr[i];
        [self.view addSubview:promptLable];
    }
    /**
     用户名和验证码输入框
     */
    _nameText = [[UITextField alloc] initWithFrame:CGRectMake(140, 57.5, ViewWidth - 156, 30)];
    _nameText.placeholder = @"请输入手机号";
    _nameText.clearButtonMode = UITextFieldViewModeAlways;
    _nameText.keyboardType = UIKeyboardTypeNumberPad;
    _nameText.delegate = self;
    _nameText.tag = 1;
    [self.view addSubview:_nameText];
    
    _codeText = [[UITextField alloc] initWithFrame:CGRectMake(140, 107.5, ViewWidth - 156, 30)];
    _codeText.placeholder = @"请输入验证码";
    _codeText.clearButtonMode = UITextFieldViewModeAlways;
//    _codeText.secureTextEntry = YES;
    _codeText.keyboardType = UIKeyboardTypeNumberPad;
    _codeText.delegate =self;
    _codeText.tag = 2;
    [self.view addSubview:_codeText];
    
    _codebtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width/2 - 100, 160, 200, 30)];
    [_codebtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_codebtn setTitleColor:RGBCOLOR(255, 95, 5) forState:UIControlStateNormal];
    [_codebtn addTarget:self action:@selector(clickCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_codebtn];
    /**
     下一步按钮
     */
    _nextbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextbtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextbtn setBackgroundColor:[UIColor colorFromHexCode:@"#dededd"]];
    _nextbtn.userInteractionEnabled = NO;
    _nextbtn.layer.cornerRadius = 5.0;
    _nextbtn.frame = CGRectMake(16, 215, ViewWidth - 32, 45);
    [_nextbtn addTarget:self action:@selector(resetPasswordAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextbtn];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
//    添加文本框监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChangedIn) name:UITextFieldTextDidChangeNotification object:nil];
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
        if (_nameText.text.length < 11) {
            return YES;
        } else {
            return NO;
        }
    }
    if (textField.tag == 2) {
        if (_codeText.text.length < 6) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return YES;
    }
}

/**
 点击获取验证码
 */
- (void)clickCode{
    if (_nameText.text.isPhone) {
        [self startRequest:0];
        //        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    } else {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alerView show];
    }
}

/**
 * 验证码倒计时
 */
-(void)timeCountDown {
    _codeText.userInteractionEnabled = YES;
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){
            //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            _nameText.userInteractionEnabled = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示
                [_codebtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
                [_codebtn setTitleColor:RGBCOLOR(255, 95, 5) forState:UIControlStateNormal];
                _codebtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout;
            _nameText.userInteractionEnabled = NO;
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
 *点击下一步
 */
- (void)resetPasswordAction{
    NSUserDefaults *defualts = [NSUserDefaults standardUserDefaults];
    NSString *phone = [defualts objectForKey:@"phone"];
    NSString *code = [defualts objectForKey:@"code"];
    if ([_codeText.text isEqualToString:code] && [_nameText.text isEqualToString:phone]) {
        ResetPasswordViewController * resetpassword = [[ResetPasswordViewController alloc] init];
        if (self.type == 1) {
            resetpassword.type = 1;
        }
        resetpassword.phone = _nameText.text;
        resetpassword.codeStr = _codeText.text;
    
        [self.navigationController pushViewController:resetpassword animated:YES];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"验证码输入错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
//    [self startRequest:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 ***文本框监听
 */
-(void)textFieldChangedIn {
    if (_nameText.text.length == 11 && _codeText.text.length == 6) {
        _nextbtn.backgroundColor = RGBCOLOR(255, 95, 5);
        _nextbtn.userInteractionEnabled = YES;
    } else {
        [_nextbtn setBackgroundColor:[UIColor colorFromHexCode:@"#dededd"]];
        _nextbtn.userInteractionEnabled = NO;
    }
}


#pragma mark - Requests
- (BOOL)startRequest:(NSInteger)requestID{
    if ([super startRequest:requestID]) {
        if (requestID == 0) {
            [_client clickGetCodePhone:_nameText.text];
        }
//        if (requestID == 1) {
//            [_client getCode:_codeText.text phone:_nameText.text];
//        }
        return YES;
    }
    return NO;
}

- (BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result{
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 0) {
            NSDictionary * dic = [result getDictionaryForKey:@"data"];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults removeObjectForKey:@"phone"];
            [defaults removeObjectForKey:@"code"];
            [defaults setObject:_nameText.text forKey:@"phone"];
            [defaults setObject:[dic getStringValueForKey:@"code" defaultValue:nil] forKey:@"code"];
            [defaults synchronize];
            _codeStr = [dic getStringValueForKey:@"code" defaultValue:nil];
            [self timeCountDown];
        }
//        if (sender.requestID == 1) {
//            ResetPasswordViewController * resetpassword = [[ResetPasswordViewController alloc] init];
//            if (self.type == 1) {
//                resetpassword.type = 1;
//            }
//            resetpassword.phone = _nameText.text;
//            resetpassword.codeStr = _codeText.text;
//            [self.navigationController pushViewController:resetpassword animated:YES];
//        }
        return YES;
    }
    return NO;
}

@end
