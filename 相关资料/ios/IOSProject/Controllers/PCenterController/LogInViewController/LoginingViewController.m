//
//  loginingViewController.m
//  IOSProject
//
//  Created by IOS004 on 15/6/17.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "LoginingViewController.h"
#import "PersonalCenterMainPage.h"
#import "RetrievePasswordViewController.h"
#import "RegisteringViewController.h"
//#import "IEngine.h"

@interface LoginingViewController()<UITextFieldDelegate>{
    BOOL       _choice;
    UIButton * _choicebtn;
    UITextField * _nameText;
    UITextField * _passwordText;
    UIButton * _loadbtn;
}

@end

@implementation LoginingViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isLogin) {
        BasicNavigationController *navigationController =(BasicNavigationController *) self.navigationController;
        navigationController.canDragBack = NO;
    }
/**
 * 添加监听
 */
//    监听注册完毕
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishResetWithNotifiacation:) name:@"finishReset" object:nil];
//    监听文本框改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChangeInfo) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishRegister2WithNotification:) name:@"register1" object:nil];
//    监听键盘弹出及隐藏
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyBoardWillHiden:) name:UIKeyboardWillHideNotification object:nil];
    if ([IEngine engine].isSignedIn && !_statusToLogin) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_isLogin) {
        BasicNavigationController *navigationController =(BasicNavigationController *) self.navigationController;
        navigationController.canDragBack = YES;
    }
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"finish" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

/**
 * 注册完毕
 */
-(void)finishRegister2WithNotification:(NSNotification *)notification {
    _nameText.text = [notification.userInfo getStringValueForKey:@"phone" defaultValue:nil];
    _passwordText.text = [notification.userInfo getStringValueForKey:@"password" defaultValue:nil];
    [CCAlertView showText:@"注册成功" life:1.0];
    [self startRequest:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!self.isLogin) {
        [self addBackButtonToNavigation];
    } else {
        [self addBackToHomeVCButton];
    }
        self.navigationItem.title = @"会员登录";
      /**
     添加登陆框
     */
    NSArray *imageNameArr = @[@"iSH_UserName",@"iSH_PassWord"];
    NSArray * arr = @[@"用户名",@"密码"];
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
     用户名和密码输入框
     */
    _nameText = [[UITextField alloc] initWithFrame:CGRectMake(140, 57.5, ViewWidth - 156, 30)];
    _nameText.placeholder = @"请输入手机号";
    _nameText.clearButtonMode = UITextFieldViewModeAlways;
    _nameText.delegate = self;
    _nameText.tag = 1;
    _nameText.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_nameText];
    
    _passwordText = [[UITextField alloc] initWithFrame:CGRectMake(140, 107.5, ViewWidth - 156, 30)];
    _passwordText.placeholder = @"请输入密码";
    _passwordText.clearButtonMode = UITextFieldViewModeAlways;
    _passwordText.secureTextEntry = YES;
    _passwordText.delegate = self;
    _passwordText.tag = 2;
    _passwordText.keyboardType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:_passwordText];
    
    _choicebtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 160, 20, 20)];
    [_choicebtn setBackgroundImage:[UIImage imageNamed:@"xuanzhong_no_ic"] forState:UIControlStateNormal];
    [_choicebtn setBackgroundImage:[UIImage imageNamed:@"iSH_XuanZhong"] forState:UIControlStateSelected];
    [_choicebtn addTarget:self action:@selector(choiceLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_choicebtn];
    
    /**
     自动登陆、忘记密码；
     */
    
    UIButton *autoLogBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    autoLogBtn.frame = CGRectMake(50, 155, 80, 30);
    [autoLogBtn setTitle:@"自动登录" forState:UIControlStateNormal];
    [autoLogBtn setTitleColor:[UIColor colorFromHexCode:@"#757575"] forState:UIControlStateNormal];
    [autoLogBtn addTarget:self action:@selector(choiceLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:autoLogBtn];
    
//    UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(50, 155, 100, 30)];
//    lable.text = @"自动登陆";
//    lable.textColor = [UIColor colorFromHexCode:@"#757575"];
//    [self.view addSubview:lable];
    
    UIButton * forgetPasswordbtn = [[UIButton alloc] initWithFrame:CGRectMake(ViewWidth - 110, 155, 100, 30)];
    [forgetPasswordbtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetPasswordbtn setTitleColor:[UIColor colorFromHexCode:@"#757575"] forState:UIControlStateNormal];
    [forgetPasswordbtn addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPasswordbtn];
    
    /**
     登陆按钮
     */
    _loadbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loadbtn setTitle:@"登录" forState:UIControlStateNormal];
    _loadbtn.layer.cornerRadius = 5.0;
    _loadbtn.userInteractionEnabled = NO;
    _loadbtn.backgroundColor = [UIColor colorFromHexCode:@"#dededd"];
    _loadbtn.frame = CGRectMake(16, 215, ViewWidth - 32, 45);
    [_loadbtn addTarget:self action:@selector(backPCenterMainPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loadbtn];
    
    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(ViewWidth - 100, 270, 70, 20)];
    [registerBtn setTitle:@"立即注册>" forState:UIControlStateNormal];
    [registerBtn setTitleColor:RGBCOLOR(255, 95, 5) forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [registerBtn addTarget:self action:@selector(registerVCAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(void)registerVCAction {
    RegisteringViewController * registerViewController = [[RegisteringViewController alloc] init];
    registerViewController.type = 1;
    [self.navigationController pushViewController:registerViewController animated:YES];
}

-(void)addBackToHomeVCButton {
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 20, 31);
    [btn setImage:[UIImage imageNamed:@"iSH_Back"] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"btn_back_d"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(backToHomeVCAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
}

-(void)backToHomeVCAction {
    self.tabBarController.selectedIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

/**
 * 点击背景键盘隐藏
 */
-(void)keyboardHide:(UITapGestureRecognizer*)tap {
    [_nameText resignFirstResponder];
    [_passwordText resignFirstResponder];
}

/**
 * 点击return键盘隐藏
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_nameText resignFirstResponder];
    [_passwordText resignFirstResponder];
    return YES;
}

/**
 * 特殊字符及输入长度限制
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
        NSCharacterSet *charSet = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:charSet] componentsJoinedByString:@""];
        if (_passwordText.text.length < 16 && [string isEqualToString:filtered]) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return YES;
    }
}


/**
 忘记密码跳转页面;
 */
- (void)forgetPassword{
    RetrievePasswordViewController * retrievePassword = [[RetrievePasswordViewController alloc] init];
    [self.navigationController pushViewController:retrievePassword animated:YES];
}

/**
 * 登陆
 */
- (void)backPCenterMainPage{
    if (verifyText(_passwordText.text, @"密码")) {
        [self startRequest:0];
    }
}

/**
 选择是否自动登陆;
 */
- (void)choiceLogin{
    if (_choice == YES) {
        _choicebtn.selected = NO;
        _choice = NO;
    }else if (_choice == NO){
        _choicebtn.selected = YES;
        _choice = YES;
    }
}

#pragma mark - Requests
- (BOOL)startRequest:(NSInteger)requestID{
    if ([super startRequest:requestID]) {
        if (requestID == 0) {
            [_client loginWithAccount:_nameText.text password:_passwordText.text];
        }else if (requestID == 1){
            [_client getUserInfo];
        }else if (requestID == 2) {
            [_client userGetCartNum];
        }
        return YES;
    }
    return NO;
}

- (BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result{
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 0) {
            NSDictionary *dic = [result objectForKey:@"data"];
            [[IEngine engine] loginWithDictionary:dic];
            [IEngine engine].password = _passwordText.text;
            if (_choice) {
                [[IEngine engine] saveToFile];
            }
            if (_type == 1) {
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            }
            if (_delegate != nil && [_delegate respondsToSelector:@selector(backToPerCenVCWithInfo:)]) {
                [_delegate backToPerCenVCWithInfo:dic];
                [self.navigationController popViewControllerAnimated:YES];
            }
            [self startRequest:2];
        }
        if (sender.requestID == 2) {
            NSDictionary *data = [result getDictionaryForKey:@"data"];
            NSString *cartNum = [data getStringValueForKey:@"cart_number" defaultValue:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cartNum" object:nil userInfo:@{@"cartNum":cartNum}];
        }
        return YES;
    }
    return NO;
}

//设置监听
-(void)finishResetWithNotifiacation:(NSNotification *)notification {
    _nameText.text = [notification.userInfo getStringValueForKey:@"phone" defaultValue:nil];
    _passwordText.text = [notification.userInfo getStringValueForKey:@"password" defaultValue:nil];
    _loadbtn.backgroundColor = RGBCOLOR(255, 95, 5);
    _loadbtn.userInteractionEnabled = YES;
    [self startRequest:0];
}

//监听文本框
-(void)textChangeInfo {
    if (_nameText.text.length == 11 && _passwordText.text.length >= 6 && _passwordText.text.length <= 16) {
        _loadbtn.backgroundColor = RGBCOLOR(255, 95, 5);
        _loadbtn.userInteractionEnabled = YES;
    } else {
        _loadbtn.backgroundColor = [UIColor colorFromHexCode:@"#dededd"];
        _loadbtn.userInteractionEnabled = NO;
    }
}

@end
