//
//  ResetPasswordViewController.m
//  IOSProject
//
//  Created by IOS002 on 15/6/4.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "PersonalCenterMainPage.h"

@interface ResetPasswordViewController () <UITextFieldDelegate> {
//    重置密码文本框
    UITextField * _nameText;
//    确认密码文本框
    UITextField * _codeText;
//    确认按钮
    UIButton * _affirmBtn;
    
}

@property (strong, nonatomic) NSString * password;

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButtonToNavigation];
    if (self.type == 1) {
        self.navigationItem.title =@"修改密码";
    } else {
        self.navigationItem.title = @"找回密码";
    }
/**
* 添加背景色；
*/
    UIImageView * screenImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    screenImage.backgroundColor = [UIColor colorFromHexCode:@"Color_bkg_green"];
    [self.view addSubview:screenImage];
/**
* 新密码输入框
*/
    NSArray * arr = @[@"重置密码",@"确认密码"];
    for (NSInteger i = 0; i < 2; i ++) {
        UIImageView * lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(16, 85 + (50 * i),ViewWidth - 32, 10)];
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
     新密码输入提示框
     */
    _nameText = [[UITextField alloc] initWithFrame:CGRectMake(140, 57.5, ViewWidth - 156, 30)];
    _nameText.placeholder = @"请设置秘码";
    _nameText.clearButtonMode = UITextFieldViewModeAlways;
    _nameText.secureTextEntry = YES;
    _nameText.delegate = self;
    _nameText.tag = 1;
    [self.view addSubview:_nameText];
    
    _codeText = [[UITextField alloc] initWithFrame:CGRectMake(140, 107.5, ViewWidth - 156, 30)];
    _codeText.placeholder = @"请再次输入密码";
    _codeText.clearButtonMode = UITextFieldViewModeAlways;
    _codeText.secureTextEntry = YES;
    _codeText.delegate = self;
    _codeText.tag = 2;
    [self.view addSubview:_codeText];

    /**
     确认按钮
     */
    _affirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_affirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_affirmBtn setBackgroundColor:[UIColor colorFromHexCode:@"#dededd"]];
    _affirmBtn.userInteractionEnabled = NO;
    _affirmBtn.layer.cornerRadius = 5.0;
    _affirmBtn.frame = CGRectMake(16, 215, ViewWidth - 32, 45);
    [_affirmBtn addTarget:self action:@selector(backToCenter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_affirmBtn];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
//    添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldHasValue) name:UITextFieldTextDidChangeNotification object:nil];
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
 * 输入字符限制及长度限制
 */
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    NSCharacterSet *charSet = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:charSet] componentsJoinedByString:@""];
    if (textField.tag == 1) {
        if (_nameText.text.length < 16 && [string isEqualToString:filtered]) {
            return YES;
        } else {
            return NO;
        }
    }
    if (textField.tag == 2) {
        if (_codeText.text.length < 16 && [string isEqualToString:filtered]) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return YES;
    }
}


/**
 跳转到个人中心
 */
- (void)backToCenter{
    if ([_nameText.text isEqualToString:_codeText.text]) {
        [self startRequest:0];
    } else {
        [CCAlertView showText:@"两次密码不一致" life:2];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *添加文本框监听
 */
-(void)textFieldHasValue {
    if (_nameText.text.length >= 6 && _nameText.text.length <= 16 && _codeText.text.length >= 6 && _codeText.text.length <= 16) {
        _affirmBtn.backgroundColor = RGBCOLOR(255, 95, 5);
        _affirmBtn.userInteractionEnabled = YES;
    } else {
        [_affirmBtn setBackgroundColor:[UIColor colorFromHexCode:@"#dededd"]];
        _affirmBtn.userInteractionEnabled = NO;
    }
}

#pragma mark - Requests
- (BOOL)startRequest:(NSInteger)requestID{
    if ([super startRequest:requestID]) {
        if (requestID == 0) {
            [_client changePassWordWithPhone:self.phone code:self.codeStr passWord:_nameText.text];
        }
        return YES;
    }
    return NO;
}

- (BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result{
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 0) {
            if (self.type == 1) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            } else {
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
            }
        }
        return YES;
    }
    return NO;
}

@end
