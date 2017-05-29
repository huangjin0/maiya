//
//  AddAdressViewController.m
//  IOSProject
//
//  Created by IOS004 on 15/6/15.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//
/**
 *  地址管理，添加地址
 */


#import "AddAdressViewController.h"
#import "HasAdressManagementViewController.h"
#import "AreaTableViewCell.h"

@interface AddAdressViewController () <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,AreaDelegate> {
//    收货人
    UITextField * _consignee;
//    联系电话
    UITextField *_connectPhone;
//    派送区域
    SearchTextField *_area;
//    详细地址
    UITextField *_address;
//    保存按钮
    UIButton *_loadbtn;
//    派送区域搜索
    UITableView *_areaTableView;
//    区域列表
    NSMutableArray *_allAreaArr;
    
    NSMutableArray *_areaListArr;
    
    CCClient *_areaClient;
//    详细地址
    UILabel *_detailAddressLab;
}

@end

@implementation AddAdressViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    监听文本框改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChangeInfo) name:UITextFieldTextDidChangeNotification object:nil];
    
    //    监听键盘遮挡
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShowWithNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHidenWithNotification:) name:UIKeyboardWillHideNotification object:nil];
//    [self startRequest:2];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


//设置键盘弹出监听
-(void)keyBoardWillShowWithNotification:(NSNotification *)notification {
    if (_address.isEditing || _area.isEditing) {
        NSValue *keyBoardRectAsObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardRect = [keyBoardRectAsObject CGRectValue];
        CGFloat keyBoardHight = keyboardRect.size.height;
        [UIView beginAnimations:@"curl" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        if (keyBoardHight > self.view.height - _area.origin.y - 120) {
            CGPoint point = CGPointMake(0, self.view.height -keyBoardHight - _area.origin.y - 120);
            self.view.origin = point;
        }
        [UIView commitAnimations];
        
    }

}

//设置键盘隐藏监听
-(void)keyBoardWillHidenWithNotification:(NSNotification *)notification {
    [UIView beginAnimations:@"curl" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    self.view.origin = CGPointMake(0, self.navigationController.navigationBar.height + [UIApplication sharedApplication].statusBarFrame.size.height);
    [UIView commitAnimations];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _areaListArr = [NSMutableArray array];
    // Do any additional setup after loading the view.
    [self addBackButtonToNavigation];
    self.navigationItem.title = @"地址管理";
    
    NSArray * arrchoice = @[@"收货人",@"联系电话",@"小区名称"];
    NSArray * addarr = @[@"请输入",@"请输入",@"请输入小区或街道名称"];
    
    for (NSInteger i = 0; i < 2; i ++) {
        UIImageView * imageLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44 + (i * 44), self.view.width, 1)];
        imageLine.backgroundColor = [UIColor colorFromHexCode:@"#dededd"];
        [self.view addSubview:imageLine];
        
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 15 + (i * 44), 100, 20)];
        lab.text = arrchoice[i];
        lab.textColor = [UIColor colorFromHexCode:@"#333333"];
        lab.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:lab];
        
    }
    _consignee = [[UITextField alloc] initWithFrame:CGRectMake(100, 15, ViewWidth - 100, 20)];
    _consignee.textColor = [UIColor colorFromHexCode:@"#999999"];
    _consignee.tag = 1;
    if (self.cossigneNam) {
        _consignee.text = _cossigneNam;
    } else {
        _consignee.placeholder = addarr[0];
    }
    _consignee.font = [UIFont systemFontOfSize:15];
    _consignee.delegate = self;
    [self.view addSubview:_consignee];
    
    _connectPhone = [[UITextField alloc] initWithFrame:CGRectMake(100, 59, ViewWidth - 100, 20)];
    _connectPhone.textColor = [UIColor colorFromHexCode:@"#999999"];
    _connectPhone.tag = 2;
    _connectPhone.keyboardType = UIKeyboardTypeNumberPad;
    if (_linkPhone) {
        _connectPhone.text = _linkPhone;
    } else {
        _connectPhone.placeholder = addarr[1];
    }
    _connectPhone.font = [UIFont systemFontOfSize:15];
    _connectPhone.delegate = self;
    [self.view addSubview:_connectPhone];
    
    CGFloat pointY = 103.0;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, pointY, 120, 20)];
    lab.textColor = [UIColor colorFromHexCode:@"#333333"];
    lab.font = [UIFont systemFontOfSize:17];
    lab.text = @"查找地址";
    [self.view addSubview:lab];
    pointY += lab.height + 10;
    
    _area = [[SearchTextField alloc] initWithFrame:CGRectMake(15, pointY, ViewWidth - 110, 30)];
    _area.textColor = [UIColor colorFromHexCode:@"#999999"];
    _area.layer.cornerRadius = 6.0;
    _area.layer.masksToBounds = YES;
    _area.layer.borderColor = RGBHex(@"#dededd").CGColor;
    _area.layer.borderWidth = 1.0;
    _area.tag = 3;
    if (_sendArea) {
        _area.text = _sendArea;
    } else {
        _area.placeholder = addarr[2];
    }
    _area.font = [UIFont systemFontOfSize:15];
    _area.delegate = self;
    [self.view addSubview:_area];
    UIButton *seachBtn = [[UIButton alloc] initWithFrame:CGRectMake(ViewWidth - 90, pointY, 80, 30)];
//    [seachBtn setImage:[UIImage imageNamed:@"search_ic"] forState:UIControlStateNormal];
//    [seachBtn setImage:[UIImage imageNamed:@"search_pic"] forState:uicontrolstate]
    [seachBtn setTitle:@"点击搜索" forState:UIControlStateNormal];
    seachBtn.layer.cornerRadius = 10.0;
    seachBtn.layer.masksToBounds = YES;
    seachBtn.backgroundColor = RGBCOLOR(255, 95, 5);
    seachBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [seachBtn addTarget:self action:@selector(getTheSearhAreaList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seachBtn];
    pointY += seachBtn.height + 20;
    
    _areaTableView = [[UITableView alloc] initWithFrame:CGRectMake(15, pointY - 10, ViewWidth - 110, 200)];
//    _areaTableView.separatorInset = UIEdgeInsetsMake(0, -5, 0, 7);
    _areaTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _areaTableView.delegate = self;
    _areaTableView.dataSource = self;
    _areaTableView.layer.cornerRadius = 5.0;
    _areaTableView.layer.masksToBounds = YES;
    _areaTableView.layer.borderWidth = 1.0;
    _areaTableView.layer.borderColor = RGBHex(@"#dededd").CGColor;
    _areaTableView.backgroundColor = [UIColor whiteColor];
    _areaTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //    _areaTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_areaTableView];
    NSLog(@"%f",pointY + 200);
    [self.view bringSubviewToFront:_areaTableView];
    _areaTableView.hidden = YES;
    
    UILabel * lab11 = [[UILabel alloc] initWithFrame:CGRectMake(10, pointY, 100, 20)];
    lab11.text = @"详细地址";
    lab11.textColor = [UIColor colorFromHexCode:@"#333333"];
    lab11.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:lab11];
    if (_type == 2) {
        lab11.hidden = YES;
    }
    _detailAddressLab = lab11;
    
    _address = [[UITextField alloc] initWithFrame:CGRectMake(100, pointY, ViewWidth - 100, 20)];
    _address.textColor = [UIColor colorFromHexCode:@"#999999"];
    _address.tag = 4;
    if (_type == 2) {
        _address.hidden = YES;
    }
    if (_detailAddress) {
        _address.text = _detailAddress;
    } else {
        _address.placeholder = @"XX栋XX单元XXXX号XXXX";
        _address.userInteractionEnabled = NO;
    }
    _address.font = [UIFont systemFontOfSize:15];
    _address.delegate = self;
//    _address.hidden = YES;
    [self.view addSubview:_address];
    
    pointY += _address.height + 7;
    
    UIImageView * imageLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, pointY, self.view.width, 1)];
    imageLine.backgroundColor = [UIColor colorFromHexCode:@"#dededd"];
    [self.view addSubview:imageLine];
    [self.view insertSubview:imageLine belowSubview:_areaTableView];

    
    _loadbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loadbtn setTitle:@"确定地址" forState:UIControlStateNormal];
    _loadbtn.layer.cornerRadius = 5.0;
    _loadbtn.userInteractionEnabled = NO;
    _loadbtn.backgroundColor = [UIColor colorFromHexCode:@"#dededd"];
    _loadbtn.frame = CGRectMake(16, self.view.height - 64 - 65, ViewWidth - 32, 45);
    [_loadbtn addTarget:self action:@selector(backAdressmanagement) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loadbtn];
    
    
    
   
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
    [_consignee resignFirstResponder];
    [_connectPhone resignFirstResponder];
    [_address resignFirstResponder];
    [_area resignFirstResponder];
    _areaTableView.hidden = YES;
//   _areaTableView.hidden = YES;
}


/**
 * 点击return键盘隐藏
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_consignee resignFirstResponder];
    [_connectPhone resignFirstResponder];
    [_address resignFirstResponder];
    [_area resignFirstResponder];
    _areaTableView.hidden = YES;
    return YES;
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    AreaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[AreaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
//    cell.backgroundColor = Color_bkg_lightGray;
    cell.delegate = self;
//    cell.backgroundColor = [UIColor clearColor];
    cell.areaLable.text = _areaListArr[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_areaListArr count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

#pragma mark - AreaDelegate
-(void)tapTableViewWithCell:(AreaTableViewCell *)cell {
    NSIndexPath *indexPath = [_areaTableView indexPathForCell:cell];
    _area.text = _areaListArr[indexPath.row];
    _address.userInteractionEnabled = YES;
    _address.hidden = NO;
    _detailAddressLab.hidden = NO;
    _areaTableView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backAdressmanagement{
    if (self.type == 1) {
        [self startRequest:1];
    } else {
       [self startRequest:0];
    }
    
//    HasAdressManagementViewController * hasAdress = [[HasAdressManagementViewController alloc] init];
//    [self.navigationController pushViewController:hasAdress animated:YES];
}

//监听文本框
-(void)textChangeInfo {
    if ( _connectPhone.text.isPhone && _area.text.length != 0 && _address.text.length != 0 && _consignee.text.length != 0) {
        _loadbtn.backgroundColor = RGBCOLOR(255, 95, 5);
        _loadbtn.userInteractionEnabled = YES;
    } else {
        _loadbtn.backgroundColor = [UIColor colorFromHexCode:@"#dededd"];
        _loadbtn.userInteractionEnabled = NO;
    }
//    if (_area.isFirstResponder && _area.text.length != 0) {
//        [self getTheSearhAreaList];
//        } else {
//        _areaTableView.hidden = YES;
//    }
    if (_area.text.length == 0) {
        _areaTableView.hidden = YES;
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (textField.tag == 1) {
        if (_consignee.text.length >= 6) {
            return NO;
        } else {
            return YES;
        }
    } else if (textField.tag == 2) {
        if (_connectPhone.text.length >= 11) {
            return NO;
        } else {
            return YES;
        }
    } else if (textField.tag == 4) {
        if (_address.text.length >= 16) {
            return NO;
        } else {
            return YES;
        }
    } else {
        return YES;
    }
}

#pragma mark - CCRequest
-(BOOL)startRequest:(NSInteger)requestID {
    if ([super startRequest:requestID]) {
        if (requestID == 0) {
            [_client addAddressWithUcode:self.ucode userName:_consignee.text tel:_connectPhone.text area:_area.text address:_address.text];
        }
        if (requestID == 1) {
            [_client editAddressWithAddrId:[self.addrid intValue] area:_area.text linkName:_consignee.text tel:_connectPhone.text adress:_address.text];
        }
        if ( requestID == 2) {
            [_client getTheListWithArea:_area.text];
        }
        return YES;
    }
    return NO;
}

-(BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result {
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 0) {
            NSDictionary *dic = [result objectForKey:@"data"];
            if (_delegate != nil && [_delegate respondsToSelector:@selector(backAddressViewControllerWithDic:)]) {
                [_delegate backAddressViewControllerWithDic:dic];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        if (sender.requestID == 1) {
            if (_delegate != nil && [_delegate respondsToSelector:@selector(backaddressForEdit)]) {
                [_delegate backaddressForEdit];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        if (sender.requestID == 2) {
            NSArray *dataArr = [result getArrayForKey:@"data"];
//            if (dataArr.count != 0) {
//                _allAreaArr = [NSMutableArray array];
//                [self getTheAreaListWithArr:dataArr];
//            }
            [self getTheAreaListWithArr:dataArr];
            if (_areaListArr.count !=0) {
                _areaTableView.hidden = NO;
                _detailAddressLab.hidden = YES;
                _address.hidden = YES;
                [_areaTableView reloadData];
            } else {
                [CCAlertView showText:@"对不起，输入错误或不在派送范围内。请正确输入，例如：摩卡筑" life:3.0];
                _address.userInteractionEnabled = NO;
                _areaTableView.hidden = YES;
            }
        }
        return YES;
    }
    return NO;
}

-(void)getTheAreaListWithArr:(NSArray *)arr {
    for (NSDictionary *areaDic in arr) {
        NSString *areaStr = [areaDic getStringValueForKey:@"area" defaultValue:nil];
        [_areaListArr addObject:areaStr];
        
    }
}

-(void)getTheSearhAreaList {
    if (_area.text.length != 0) {
        [_areaListArr removeAllObjects];
        [self startRequest:2];
    } else {
        [CCAlertView showText:@"请输入小区或街道名称" life:1.0];
    }
    
//    for (NSString *areaStr in _allAreaArr) {
//        if ([areaStr rangeOfString:_area.text].location != NSNotFound) {
//            [_areaListArr addObject:areaStr];
//        }
//    }
//    if (_areaListArr.count != 0) {
//        _areaTableView.hidden = NO;
//        [_areaTableView reloadData];
//    } else {
//        [CCAlertView showText:@"对不起，输入错误或不在派送范围内。请正确输入，例如：摩卡筑" life:1.0];
//        _address.userInteractionEnabled = NO;
//        _areaTableView.hidden = YES;
//    }
}

@end

@implementation SearchTextField

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 0);
}

@end
