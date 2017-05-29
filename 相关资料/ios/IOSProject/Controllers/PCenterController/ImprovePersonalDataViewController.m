//
//  ImprovePersonalDataViewController.m
//  IOSProject
//
//  Created by IOS004 on 15/6/8.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//
/**
 完善个人资料
 */


#import "ImprovePersonalDataViewController.h"
#import "CropAvatarController.h"
#import "UIButton+WebCache.h"
#import "UIImage+WebP.h"

@interface ImprovePersonalDataViewController ()<CCPickerViewDelegate,UIImagePickerControllerDelegate,CropAvatarControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate> {
    UIImageView * _choiceImage;
    //    性别选择按钮
    UIButton *_boyChoice;
    UIButton *_grilChoice;
    UIButton *_secChoice;
    //    出生日期按钮
    UIButton *_brithButton;
    UILabel *_brithDateLabel;
    //    时间戳
    NSString *_timestamp;
    //    选择头像按钮
    UIButton *_headImgBtn;
    //    头像图片
    UIImage *_selectedImg;
    //    呢称
    UITextField * _nameTextfield;
    //    联系电话
    UITextField * _phoneTextfield;
//    保存按钮
    UIButton * _saveBtn;
    UIImageView *_headImageView;
    
    BOOL isChoice;
    
    NSInteger tam;
    
}

@end

@implementation ImprovePersonalDataViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    //    监听文本框改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChangeInfo) name:UITextFieldTextDidChangeNotification object:nil];
//    监听键盘遮挡
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShowWithNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHidenWithNotification:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButtonToNavigation];
    self.navigationItem.title = @"个人信息";
    NSArray * arr = @[@"头像",@"昵称",@"性别",@"出生日期",@"联系电话"];
    
    for (NSInteger i = 0; i < 5; i ++) {
        UIImageView * imageline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64 + (i * 50), self.view.width, 1)];
        imageline1.backgroundColor = [UIColor colorFromHexCode:@"#cacaca"];
        [self.view addSubview:imageline1];
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 26 + (i * 50), 100, 30)];
        lab.text = arr[i];
        lab.font = [UIFont systemFontOfSize:15];
        lab.textColor = [UIColor colorFromHexCode:@"#333333"];
        [self.view addSubview:lab];
    }
    
    _headImgBtn= [[UIButton alloc] initWithFrame:CGRectMake(95, 7, 50, 50)];
//    [_headImgBtn setImage:[UIImage imageNamed:@"hongzao"] forState:UIControlStateNormal];
    [_headImgBtn addTarget:self action:@selector(handbtnPressed) forControlEvents:UIControlEventTouchUpInside];
    if (_headImg.hasValue && ![_headImg  isEqual: DeFaultURL]) {
        NSURL *url = [NSURL URLWithString:_headImg];
        _selectedImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    } else {
        _selectedImg = [UIImage imageNamed:@"iSH_HomeLogo"];
    }
    [_headImgBtn setBackgroundImage:_selectedImg forState:UIControlStateNormal];
    _headImgBtn.backgroundColor = [UIColor clearColor];
    _headImgBtn.layer.masksToBounds = YES;
    [_headImgBtn.layer setCornerRadius:_headImgBtn.height / 2.0];
    [self.view addSubview:_headImgBtn];
    
    _nameTextfield = [[UITextField alloc] initWithFrame:CGRectMake(95, 76, ViewWidth - 95, 30)];
    _nameTextfield.font = [UIFont systemFontOfSize:15];
    _nameTextfield.textColor = [UIColor colorFromHexCode:@"#999999"];
    _nameTextfield.text = self.nickNam;
    _nameTextfield.delegate = self;
    _nameTextfield.tag = 1;
    _nameTextfield.placeholder = @"请输入昵称";
    [self.view addSubview:_nameTextfield];
    
    //    性别选择
    NSArray *sexArr = @[@"男",@"女",@"保密"];
    for (int i = 0; i <= 2; i ++) {
        UILabel *sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(120 + i * 70, 125, 40, 30)];
        sexLabel.text = [sexArr objectAtIndex:i];
        sexLabel.font = [UIFont systemFontOfSize:15];
        sexLabel.textColor = [UIColor colorFromHexCode:@"#999999"];
        [self.view addSubview:sexLabel];
    }
    _boyChoice = [[UIButton alloc] initWithFrame:CGRectMake(95, 130, 20, 20)];
    [_boyChoice setImage:[UIImage imageNamed:@"xuanzhong_no_ic"] forState:UIControlStateNormal];
    _boyChoice.tag = 1;
    [_boyChoice addTarget:self action:@selector(sexChoiceWithSender:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_boyChoice];
    
    _grilChoice = [[UIButton alloc] initWithFrame:CGRectMake(165, 130, 20, 20)];
    [_grilChoice setImage:[UIImage imageNamed:@"xuanzhong_no_ic"] forState:UIControlStateNormal];
    _grilChoice.tag = 2;
    [_grilChoice addTarget:self action:@selector(sexChoiceWithSender:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_grilChoice];
    
    _secChoice = [[UIButton alloc] initWithFrame:CGRectMake(235, 130, 20, 20)];
    [_secChoice setImage:[UIImage imageNamed:@"xuanzhong_no_ic"] forState:UIControlStateNormal];
    _secChoice.tag = 3;
    [_secChoice addTarget:self action:@selector(sexChoiceWithSender:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_secChoice];
    switch (_sex.integerValue) {
            case 1:
            isChoice = YES;
            [_boyChoice setImage:[UIImage imageNamed:@"iSH_XuanZhong"] forState:UIControlStateNormal];
            break;
        case 2:
            isChoice = YES;
            [_grilChoice setImage:[UIImage imageNamed:@"iSH_XuanZhong"] forState:UIControlStateNormal];
            break;
        case 4:
            isChoice = YES;
            [_secChoice setImage:[UIImage imageNamed:@"iSH_XuanZhong"] forState:UIControlStateNormal];
            break;
        default:
            isChoice = NO;
            break;
    }
    
    
    //    出生日期
    _brithDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 176, self.view.frame.size.width - 95, 30)];
    if ([self.brithDate isEqualToString:@""] || self.brithDate.integerValue == 0) {
        _brithDateLabel.text = @"请选择出生日期";
    } else {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self.brithDate integerValue]];
        NSString *str = [date stringFromDate:@"yyyy-MM-dd"];
        _brithDateLabel.text = str;
    }
    _brithDateLabel.font = [UIFont systemFontOfSize:15];
    _brithDateLabel.textColor = [UIColor colorFromHexCode:@"#999999"];
    _brithDateLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_brithDateLabel];
    _brithButton = [[UIButton alloc] initWithFrame:CGRectMake(95, 176, self.view.frame.size.width - 95, 30)];
    _brithButton.backgroundColor = [UIColor clearColor];
    [_brithButton addTarget:self action:@selector(choiceBrithDate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_brithButton];
    
    //    联系电话
    _phoneTextfield = [[UITextField alloc] initWithFrame:CGRectMake(95, 225, 100, 30)];
    _phoneTextfield.font = [UIFont systemFontOfSize:15];
    _phoneTextfield.textColor = [UIColor colorFromHexCode:@"#999999"];
    _phoneTextfield.text = self.phoneNum;
    _phoneTextfield.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextfield.placeholder = @"请输入电话";
    _phoneTextfield.delegate = self;
    _phoneTextfield.tag = 2;
    [self.view addSubview:_phoneTextfield];
    
    //    保存按钮
    _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    _saveBtn.layer.cornerRadius = 5.0;
    if (_phoneTextfield.text.isPhone) {
        _saveBtn.backgroundColor = RGBCOLOR(255, 95, 5);
        _saveBtn.userInteractionEnabled = YES;
    } else {
        _saveBtn.backgroundColor = RGBHex(@"#dededd");
        _saveBtn.userInteractionEnabled = NO;
    }
    _saveBtn.frame = CGRectMake(16, 314, ViewWidth - 32, 45);
    [_saveBtn addTarget:self action:@selector(saveUserInformation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_saveBtn];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = YES;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)toInPut{
    
}


/**
 * 点击背景键盘隐藏
 */
-(void)keyboardHide:(UITapGestureRecognizer*)tap {
    [_nameTextfield resignFirstResponder];
    [_phoneTextfield resignFirstResponder];
}


/**
 * 点击return键盘隐藏
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_nameTextfield resignFirstResponder];
    [_phoneTextfield resignFirstResponder];
    return YES;
}


/**
 * 限制文本框输入
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (textField.tag == 1) {
        if (_nameTextfield.text.length < 9) {
            return YES;
        } else {
            return NO;
        }
    }
    if (textField.tag == 2) {
        if (_phoneTextfield.text.length < 11) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return YES;
    }
}


//监听文本框
-(void)textChangeInfo {
    if (_phoneTextfield.text.isPhone) {
        _saveBtn.backgroundColor = RGBCOLOR(255, 95, 5);
        _saveBtn.userInteractionEnabled = YES;
    } else {
        _saveBtn.backgroundColor = [UIColor colorFromHexCode:@"#dededd"];
        _saveBtn.userInteractionEnabled = NO;
    }

}
//设置键盘弹出监听
-(void)keyBoardWillShowWithNotification:(NSNotification *)notification {
    NSValue *keyBoardRectAsObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [keyBoardRectAsObject CGRectValue];
    CGFloat keyBoardHight = keyboardRect.size.height;
    if (keyBoardHight > self.view.height - _phoneTextfield.origin.y - 70 && _phoneTextfield.isFirstResponder) {
        [UIView beginAnimations:@"curl" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        CGPoint point = CGPointMake(0, self.view.height -keyBoardHight - _phoneTextfield.origin.y - 70);
        self.view.origin = point;
        [UIView commitAnimations];
    } else {
        self.view.origin = CGPointMake(0, self.navigationController.navigationBar.height + [UIApplication sharedApplication].statusBarFrame.size.height);
    }
}

//设置键盘隐藏监听
-(void)keyBoardWillHidenWithNotification:(NSNotification *)notification {
    [UIView beginAnimations:@"curl" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    self.view.origin = CGPointMake(0, self.navigationController.navigationBar.height + [UIApplication sharedApplication].statusBarFrame.size.height);
    [UIView commitAnimations];
}


/*
 ***性别选择
 */
-(void)sexChoiceWithSender:(id)sender {
    if (isChoice == NO) {
        switch ([sender tag]) {
            case 1:
                [_boyChoice setImage:[UIImage imageNamed:@"iSH_XuanZhong"] forState:UIControlStateNormal];
                isChoice = YES;
                _sex = @"1";
                break;
            case 2:
                [_grilChoice setImage:[UIImage imageNamed:@"iSH_XuanZhong"] forState:UIControlStateNormal];
                isChoice = YES;
                _sex = @"2";
                break;
            case 3:
                [_secChoice setImage:[UIImage imageNamed:@"iSH_XuanZhong"] forState:UIControlStateNormal];
                isChoice = YES;
                _sex = @"4";
                break;
            default:
                break;
        }
    } else {
        switch ([sender tag]) {
            case 1:
                [_boyChoice setImage:[UIImage imageNamed:@"iSH_XuanZhong"] forState:UIControlStateNormal];
                [_grilChoice setImage:[UIImage imageNamed:@"xuanzhong_no_ic"] forState:UIControlStateNormal];
                [_secChoice setImage:[UIImage imageNamed:@"xuanzhong_no_ic"] forState:UIControlStateNormal];
                _sex = @"1";
                break;
            case 2:
                [_grilChoice setImage:[UIImage imageNamed:@"iSH_XuanZhong"] forState:UIControlStateNormal];
                [_boyChoice setImage:[UIImage imageNamed:@"xuanzhong_no_ic"] forState:UIControlStateNormal];
                [_secChoice setImage:[UIImage imageNamed:@"xuanzhong_no_ic"] forState:UIControlStateNormal];
                _sex = @"2";
                break;
            case 3:
                [_secChoice setImage:[UIImage imageNamed:@"iSH_XuanZhong"] forState:UIControlStateNormal];
                [_boyChoice setImage:[UIImage imageNamed:@"xuanzhong_no_ic"] forState:UIControlStateNormal];
                [_grilChoice setImage:[UIImage imageNamed:@"xuanzhong_no_ic"] forState:UIControlStateNormal];
                _sex = @"4";
            default:
                break;
        }
    }
}

/*
 ***弹出日期选择器
 */
-(void)choiceBrithDate {
    [_nameTextfield resignFirstResponder];
    [_phoneTextfield resignFirstResponder];
    CCPickerView *pickerView = [[CCPickerView alloc] initWithDel:self type:CCPickerDate];
    pickerView.maximumDate = [NSDate date];
    [pickerView show];
}

/*
 ***保存用户信息
 */
-(void)saveUserInformation {
    if (_phoneTextfield.text.length == 0 || _phoneTextfield.text.length == 11) {
        [self startRequest:1];
    } else {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:nil message:@"联系电话格式输入不合法" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alerView show];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CCPickerViewDelegate
- (void)pickerViewDidDismiss:(CCPickerView*)sender {
    NSDate *date = sender.selectedDate;
    NSString *dateStr = [date stringFromDate:@"yyyy-MM-dd"];
    _brithDateLabel.text = dateStr;
    _timestamp = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
}

/**
 *  更换头像
 */
- (void)handbtnPressed {
    UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"编辑头像" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
    [sheet showWithCompleteBlock:^(NSInteger buttonIndex) {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        /**检查相机是否可用
         if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
         NSLog(@"sorry, no camera or camera is unavailable.");
         return;
         }
         跳到编辑模式
         picker.allowsEditing = YES;
         设置使用后置摄像头，可以使用前置摄像头
         picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
         */
        if (buttonIndex == 0) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        } else if (buttonIndex == 1) {
            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        } else return;
        [self presentViewController:picker animated:NO completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        }];
    }];
}

#pragma mark - UIImagePickerControllerDelegate 代理方法

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *headImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    headImage = [UIImage rotateImage:headImage];
    headImage = [headImage resizeImageGreaterThan:800];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];

    CropAvatarController * con = [[CropAvatarController alloc] initWithImage:headImage delegate:self];
    [picker pushViewController:con animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)cropAvatarControllerDidFinishWithImage:(UIImage *)image {
    /**
     * 设置状态栏不隐藏
     */
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    _selectedImg = image;
    [_headImgBtn setBackgroundImage:_selectedImg forState:UIControlStateNormal];
}


#pragma mark - CCRequest
-(BOOL)startRequest:(NSInteger)requestID {
    if ([super startRequest:requestID]) {
        if (requestID == 0) {
            [_client getUserBaseInfo];
        } else if (requestID == 1) {
            NSArray * arr = @[_selectedImg];
            [_client saveOrChangeInfoWithUcode:nil headImg:arr[0] nickName:_nameTextfield.text sex:[_sex intValue] birthdate:[_timestamp intValue] phone:_phoneTextfield.text];
        }
        return YES;
    }
    return NO;
}

-(BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result {
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 0) {
            NSDictionary *dataDic = [result objectForKey:@"data"];
            [self reloadViewWithDic:dataDic];
        } else if (sender.requestID == 1) {
            NSDictionary *data = [result getDictionaryForKey:@"data"];
            if (_delegate != nil && [_delegate respondsToSelector:@selector(backToPCViewController)]) {
                [[IEngine engine] chageWithDic:data];
                [_delegate backToPCViewController];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        return YES;
    }
    return NO;
}

-(void)reloadViewWithDic:(NSDictionary *)dataDic {
    _nameTextfield.text = [dataDic objectForKey:@"nack_name"];
    NSString *sex = [dataDic objectForKey:@"sex"];
    switch (sex.intValue) {
        case 1:
            isChoice = YES;
            [_boyChoice setImage:[UIImage imageNamed:@"iSH_XuanZhong"] forState:UIControlStateNormal];
            break;
        case 2:
            isChoice = YES;
            [_grilChoice setImage:[UIImage imageNamed:@"iSH_XuanZhong"] forState:UIControlStateNormal];
            break;
        case 4:
            isChoice = YES;
            [_secChoice setImage:[UIImage imageNamed:@"iSH_XuanZhong"] forState:UIControlStateNormal];
            break;
        default:
            isChoice = NO;
            break;
    }
    _phoneTextfield.text = [dataDic objectForKey:@"tel"];
    //    [_headImgBtn setBackgroundImage:[UIImage imageNamed:[dataDic objectForKey:@"head_img"]] forState:UIControlStateNormal];
    NSString *str = [dataDic getStringValueForKey:@"head_img" defaultValue:nil];
    UIImage *img;
    if (str.hasValue) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://ishenghuo.zgcom.cn%@",str]];
        img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    } else {
        img = [UIImage imageNamed:@"mrtx_pic.png"];
    }
    _selectedImg = img;
    [_headImgBtn setImage:img forState:UIControlStateNormal];
}
@end
