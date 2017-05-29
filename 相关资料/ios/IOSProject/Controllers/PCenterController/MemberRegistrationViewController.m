//
//  MemberRegistrationViewController.m
//  IOSProject
//
//  Created by IOS002 on 15/6/4.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "MemberRegistrationViewController.h"
#import "ServiceAgreementViewController.h"
#import "PersonalCenterMainPage.h"

@interface MemberRegistrationViewController () <UITextFieldDelegate> {
//    第一次输入密码
    UITextField * _psdFristText;
//    第二次输入密码
    UITextField * _psdagainText;
//    同意协议按钮
    UIButton * _choicebtn;
//    立即注册按钮
    UIButton *_loadbtn;
//    是否同意
    BOOL       _choice;
}

@end

@implementation MemberRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButtonToNavigation];
    self.navigationItem.title = @"会员注册";

    /**
     添加背景色；
     */
    UIImageView * screenImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
//    screenImage.backgroundColor = [UIColor colorFromHexCode:@"Color_bkg_green"];
    [self.view addSubview:screenImage];
    /**
     添加登陆框
     */
    NSArray * arr = @[@"密码",@"确认密码"];
    for (NSInteger i = 0; i < 2; i ++) {
        UIImageView * lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(16, 85 + (50 * i), ViewWidth - 32, 10)];
        lineImage.image = [UIImage imageNamed:@"iSH_BottomLine"];
        [self.view addSubview:lineImage];
        
        UIImageView * iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(25, 60 + (50 * i), 25, 25)];
        iconImage.image = [UIImage imageNamed:@"iSH_PassWord"];
        [self.view addSubview:iconImage];
        
        UILabel * promptLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 57.5 + (50 * i), 80, 30)];
        promptLable.text = arr[i];
        [self.view addSubview:promptLable];
    }
    /**
     用户名和密码输入框
     */
    _psdFristText = [[UITextField alloc] initWithFrame:CGRectMake(140, 57.5, ViewWidth - 156, 30)];
    _psdFristText.placeholder = @"请设置密码";
    _psdFristText.clearButtonMode = UITextFieldViewModeAlways;
    _psdFristText.secureTextEntry = YES;
    _psdFristText.delegate = self;
    _psdFristText.tag = 1;
    [self.view addSubview:_psdFristText];
    
    _psdagainText = [[UITextField alloc] initWithFrame:CGRectMake(140, 107.5, ViewWidth - 156, 30)];
    _psdagainText.placeholder = @"请再次输入密码";
    _psdagainText.clearButtonMode = UITextFieldViewModeAlways;
    _psdagainText.secureTextEntry = YES;
    _psdagainText.delegate = self;
    _psdagainText.tag = 2;
    [self.view addSubview:_psdagainText];
    
    _choicebtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 160, 20, 20)];
    [_choicebtn setBackgroundImage:[UIImage imageNamed:@"xuanzhong_no_ic"] forState:UIControlStateNormal];
    [_choicebtn setBackgroundImage:[UIImage imageNamed:@"iSH_XuanZhong"] forState:UIControlStateSelected];
    _choicebtn.selected = YES;
    _choice = YES;
    [_choicebtn addTarget:self action:@selector(choiceConfirmationAgreement) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_choicebtn];
    
    /**
     自动登陆、忘记密码；
     */
    UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(60, 155, 100, 30)];
    lable.text = @"同意";
    lable.textColor = [UIColor colorFromHexCode:@"#757575"];
    [self.view addSubview:lable];
    
    UIButton * agreementbtn = [[UIButton alloc] initWithFrame:CGRectMake(90, 155, 100, 30)];
    [agreementbtn setTitle:@"服务协议" forState:UIControlStateNormal];
    [agreementbtn setTitleColor:RGBCOLOR(255, 95, 5) forState:UIControlStateNormal];
    [agreementbtn addTarget:self action:@selector(confirmationAgreement) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:agreementbtn];
    /**
     立即注册
     */
    
//    UIButton * loadbtn = [UIButton roundedRectButtonWithTitle:@"立即注册" color:[UIColor colorFromHexCode:@"#489925"] raduis:5.0];
    _loadbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loadbtn setBackgroundColor:[UIColor colorFromHexCode:@"#dededd"]];
    _loadbtn.userInteractionEnabled = NO;
    _loadbtn.frame = CGRectMake(16, 215, ViewWidth - 32, 45);
    _loadbtn.layer.cornerRadius = 5.0;
    [_loadbtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [_loadbtn setTitleColor:[UIColor colorFromHexCode:@"#757575"] forState:UIControlStateNormal];
    [_loadbtn addTarget:self action:@selector(backPCenterMainPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loadbtn];
//    添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFildeStateChange) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFildeStateChange) name:@"isChoice" object:nil];
    
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
    [_psdFristText resignFirstResponder];
    [_psdagainText resignFirstResponder];
}

/**
 * 点击return键盘隐藏
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_psdFristText resignFirstResponder];
    [_psdagainText resignFirstResponder];
    return YES;
}

/**
 * 输入字符及长度限制
 */
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    NSCharacterSet *charSet = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:charSet] componentsJoinedByString:@""];
    if (textField.tag == 1) {
        if (_psdFristText.text.length < 16 && [string isEqualToString:filtered]) {
            return YES;
        } else {
            return NO;
        }
    }
    if (textField.tag == 2) {
        if (_psdagainText.text.length < 16 && [string isEqualToString:filtered]) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return YES;
    }
}


/**
 是否同意服务协议
 */
- (void)choiceConfirmationAgreement{
    if (_choice == YES) {
        _choicebtn.selected = NO;
        _choice = NO;
    }else if (_choice == NO){
        _choicebtn.selected = YES;
        _choice = YES;
    }
    NSNotification *notification = [NSNotification notificationWithName:@"isChoice" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}
/**
 立即注册按钮,点击跳转到个人中心
 */
- (void)backPCenterMainPage{
    if (_choice == YES){
        if ([_psdFristText.text isEqualToString:_psdagainText.text]) {
            [self startRequest:1];
        } else {
            [CCAlertView showText:@"密码不一致" life:1];
        }
    }
}
/**
 跳转到服务协议内容
 */
- (void)confirmationAgreement{
    ServiceAgreementViewController * service = [[ServiceAgreementViewController alloc] init];
    [self.navigationController pushViewController:service animated:YES];
}

/**
 * 文本输入框状态改变
 */
-(void)textFildeStateChange {
    
    if (_choice && _psdFristText.text.length >= 6 && _psdFristText.text.length <= 16 && _psdagainText.text.length >= 6 && _psdagainText.text.length <= 16) {
        [_loadbtn setBackgroundColor:RGBCOLOR(255, 95, 5)];
        [_loadbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loadbtn.userInteractionEnabled = YES;
    } else {
        [_loadbtn setBackgroundColor:[UIColor colorFromHexCode:@"#dededd"]];
        [_loadbtn setTitleColor:[UIColor colorFromHexCode:@"#757575"] forState:UIControlStateNormal];
         _loadbtn.userInteractionEnabled = NO;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

-(BOOL)startRequest:(NSInteger)requestID {
    if ([super startRequest:requestID]) {
        if (requestID == 1) {
            [_client registAcountWithPhone:self.phoneNum passWord:_psdFristText.text];
        }
        return YES;
    }
    return NO;
}

-(BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result {
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 1) {
            NSDictionary *dic = [result objectForKey:@"data"];
            NSString *phone = [dic objectForKey:@"phone"];
            NSString *psd = [dic objectForKey:@"password"];
            NSDictionary *userDic = @{@"phone":phone,@"password":psd};
            if (_type == 1) {
                NSInteger integer = self.navigationController.viewControllers.count - 3;
                NSNotification *notification = [NSNotification notificationWithName:@"register1" object:nil userInfo:userDic];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                [self.navigationController popToViewController:[self.navigationController.childViewControllers objectAtIndex:integer] animated:NO];
            } else {
                NSNotification *notifiaction = [NSNotification notificationWithName:@"finish" object:nil userInfo:userDic];
                [[NSNotificationCenter defaultCenter] postNotification:notifiaction];
                ;
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }
        return YES;
    }
    return NO;
}


@end
