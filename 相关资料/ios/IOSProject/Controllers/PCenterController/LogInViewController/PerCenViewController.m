//
//  PerCenViewController.m
//  IOSProject
//
//  Created by IOS002 on 15/6/26.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "PerCenViewController.h"
#import "PersonalCenterViewController.h"
#import "RetrievePasswordViewController.h"
#import "RegisteringViewController.h"
#import "SetUpViewController.h"
#import "loginingViewController.h"
#import "ImprovePersonalDataViewController.h"
#import "ShoppingCartViewController.h"
#import "CollectionManagementViewController.h"
#import "PasswordChangeViewController.h"
#import "AddressManagementViewController.h"
#import "AllOrdersViewController.h"
#import "CropAvatarController.h"
#import "UIButton+WebCache.h"

#import "HasAdressManagementViewController.h"
#import "MsgCenViewController.h"

#define ViewH [[UIScreen mainScreen] bounds].size.height
//#define statusH (self.navigationController.navigationBar.height + [[UIApplication sharedApplication] statusBarFrame].size.height + self.tabBarController.tabBar.height)
#define statusH (self.navigationController.navigationBar.height + [[UIApplication sharedApplication] statusBarFrame].size.height)

@interface PerCenViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate ,CropAvatarControllerDelegate,logInDelegate,logOutDelegate,BackPCDelegate,LogOrRegisterDelegate>

{
    UIButton * _handbtn;
    UIButton * _imagebutton;
    UILabel  * _labcount;
    UILabel  * _labcount1;
    NSString * _logIn;
//    个人中心列表
    UITableView * _personInfo;
//    头像
    UIImageView *_headImgView;
    
//    会员类型
    NSString * _VIP;
//    积分
    NSString * _integral;
//    头像
    NSString * _headImg;
//    呢称
    NSString * _nickNam;
//    性别
    NSString * _sex;
//    出生日期
    NSString * _brithdate;
//    联系电话
    NSString * _phoneNum;
//    用户密码
    NSString * _passWord;
//    选中的图片
    UIImage *_selectedImg;
//    个人中心图片
    NSArray *_personInfoImg;
//    个人中心明细
    NSArray *_personInfoTit;
    BOOL _hasRedPoint;
    UIImageView *_pointImageView;
    
    UIScrollView *_scrollView;
    NSArray * _arr;
    NSArray * _arrImage;
}

@end

@implementation PerCenViewController

- (id)init{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = NO;
//    添加消息监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasRecivedNewMessageWithnotification:) name:@"heartBeat" object:nil];
//        添加退款监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refundGoods) name:@"shenqingtuikuan" object:nil];
//
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToMyOrderWithNotifiction:) name:@"backToMyOrderStatus" object:nil];
//    添加注册完毕监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedRegisterWithNotification:) name:@"finish" object:nil];
//    添加再次购买监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shoppingAgainToShopCart) name:@"shopagain" object:nil];
//    取消红点监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasReadMessage) name:@"hasRedPoint" object:nil];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    if ([IEngine engine].isSignedIn) {
        _scrollView.hidden = YES;
        [self startRequest:3];
        [self logInViewLoad];
//        _VIP = [self getUserLvWithDic:[IEngine engine].userintegral];
    } else{
        _scrollView.hidden = NO;
        [self logInViewLoad];
        [self unLogInViewDidLoad];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_personInfo removeFromSuperview];
    [_scrollView removeFromSuperview];
}

/**
 * 申请退款
 */
-(void)refundGoods {
    AllOrdersViewController * allorders = [[AllOrdersViewController alloc] init];
    allorders.selectedTag = @"5";
    [self.navigationController pushViewController:allorders animated:YES];
}

/**
 * 结算返回相应状态
 */
-(void)pushToMyOrderWithNotifiction:(NSNotification *)notification {
    NSString *stusts = [notification.userInfo getStringValueForKey:@"status" defaultValue:nil];
    AllOrdersViewController *myOrderVC = [[AllOrdersViewController alloc] init];
    switch ([stusts integerValue]) {
        case 0:
        case 1:
            myOrderVC.selectedTag = @"1";
            break;
        case 2:
        case 3:
            myOrderVC.selectedTag = @"2";
            break;
        case 4:
            myOrderVC.selectedTag = @"3";
            break;
        case 5:
            myOrderVC.selectedTag = @"4";
            break;
        case 6:
            myOrderVC.selectedTag = @"5";
            break;
        default:
            myOrderVC.selectedTag = @"0";
            break;
    }
    [self.navigationController pushViewController:myOrderVC animated:YES];
    
}

/**
 * 再次购买
 */
-(void)shoppingAgainToShopCart {
    self.tabBarController.selectedIndex = 3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
//    添加navigationBar
//    UIButton * leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftbtn setBackgroundImage:[UIImage imageNamed:@"grcenter_ic_setting_normal"] forState:UIControlStateNormal];
//    [leftbtn addTarget:self action:@selector(setUpAction) forControlEvents:UIControlEventTouchUpInside];
//    leftbtn.frame = CGRectMake(10, 10, 20, 20);
//    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
//    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.leftBarButtonItem = [self addItemWithImg:@"grcenter_ic_setting_normal" action:@selector(setUpAction)];
    UIButton * rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setBackgroundImage:[UIImage imageNamed:@"iSH_Message"] forState:UIControlStateNormal];
    _pointImageView = [[UIImageView alloc] initWithFrame:CGRectMake(22.5, 0, 5, 5)];
    _pointImageView.backgroundColor = [UIColor redColor];
    _pointImageView.layer.cornerRadius = 2.5;
    _pointImageView.layer.masksToBounds = YES;
    if (_hasRedPoint) {
        _pointImageView.hidden = NO;
    } else {
        _pointImageView.hidden = YES;
    }
    [rightbtn addSubview:_pointImageView];
    [rightbtn addTarget:self action:@selector(messageCenter) forControlEvents:UIControlEventTouchUpInside];
    rightbtn.frame = CGRectMake(10, 10, 25, 25);
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    _personInfoImg = @[@"wsgrzl",@"scgl",@"xxzx",@"wdgwc",@"mmxg",@"dzgl"];
    _personInfoTit = @[@"完善个人资料",@"收藏管理",@"消息中心",@"我的购物车",@"密码修改",@"地址管理"];
    _arr = @[@"待付款",@"待收货",@"待评价",@"已完成",@"退款中"];
    _arrImage = @[@"fukuan",@"shouhuo",@"pingjia",@"grcenter_ic_done_normal",@"tuikuan"];
}



//若未登录，加载
-(void)unLogInViewDidLoad {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, self.view.height)];
    _scrollView.backgroundColor = [UIColor redColor];
    CGFloat scrollSize = self.view.height > 520 ? self.view.height : 520;
    _scrollView.backgroundColor = Color_bkg_lightGray;
    _scrollView.contentSize = CGSizeMake(ViewWidth, scrollSize);
    _scrollView.scrollEnabled = YES;
    [self.view addSubview:_scrollView];
    _logInView = [[LogInView alloc] initWithFrame:self.view.bounds];
    _logInView.delegate = self;
    [_scrollView addSubview:_logInView];
    [_logInView unlogInviewDidLoad];
}

// 若登陆，加载
-(void)logInViewLoad {
    _personInfo = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, ViewH - statusH) style:UITableViewStylePlain];
    _personInfo.dataSource = self;
    _personInfo.delegate = self;
    _personInfo.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_personInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    
}

/**
 跳转到设置页面
 */
- (void)setUpAction{
    SetUpViewController * setup = [[SetUpViewController alloc] init];
    setup.delegate = self;
    [self.navigationController pushViewController:setup animated:YES];
}

/**
 跳转到消息中心
 */
- (void)messageCenter {
    if ([IEngine engine].isSignedIn) {
        MsgCenViewController *msgCenVC = [[MsgCenViewController alloc] init];
        msgCenVC.headImg = _headImg;
        [self.navigationController pushViewController:msgCenVC animated:YES];
    } else {
        [CCAlertView showText:@"请先登录" life:2];
    }
}

/**
 *  表格中的sections
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

/**
 *  每个sections有多少个cell
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

/**
 *  定制单元格内容
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier0 = @"identifier0";
    static NSString * identifier1 = @"identifier1";
    static NSString * identifier2 = @"identifier2";
    static NSString * identifier3 = @"identifier3";
    static NSString * identifier4 = @"identifier4";
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier0];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton * imagelogobtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
        [imagelogobtn setBackgroundImage:[UIImage imageNamed:@"iSH_PersonBack"] forState:UIControlStateNormal];
        [imagelogobtn addTarget:self action:@selector(personalData) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:imagelogobtn];
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, ViewWidth - 90, 30)];
        if ([IEngine engine].nickName.hasValue) {
            lab.text = [IEngine engine].nickName;
        } else {
            lab.text = [IEngine engine].account;
        }
        lab.textColor = [UIColor colorFromHexCode:@"#ffffff"];
        lab.font = [UIFont systemFontOfSize:18];
        [imagelogobtn addSubview:lab];
        for (NSInteger i = 0; i < 2; i ++) {
            NSArray * arr;
            if (_VIP) {
                NSString *integral = [NSString stringWithFormat:@"积分:%@",[IEngine engine].userintegral];
                arr = @[_VIP,integral];
            } else {
                arr = @[@"V0会员",@"积分：0"];
            }
            _labcount = [[UILabel alloc] initWithFrame:CGRectMake(90 + ((ViewWidth - 250 ) / 1.5 + 80) * i, 55, 80 + 20 * i, 25)];
            _labcount.backgroundColor = [UIColor colorFromHexCode:@"#000000"];
            _labcount.alpha = 0.3;

            _labcount1 = [[UILabel alloc] initWithFrame:CGRectMake(110 , 55, 60, 25)];
            _labcount1.backgroundColor = [UIColor clearColor];
            _labcount1.alpha = 0.3;

            if (i == 0) {
                _labcount1.text = arr[i];
                _labcount1.textAlignment = NSTextAlignmentCenter;
            } else {
                _labcount.text = arr[i];
                _labcount.textAlignment = NSTextAlignmentCenter;
            }
            _labcount.textColor = [UIColor colorFromHexCode:@"#ffffff"];
            _labcount.font = [UIFont systemFontOfSize:14];
            _labcount.layer.cornerRadius = 12.5;
            _labcount.layer.masksToBounds = YES;
            [imagelogobtn addSubview:_labcount];
            _labcount1.textColor = [UIColor colorFromHexCode:@"#ffffff"];
            _labcount1.font = [UIFont systemFontOfSize:14];
            _labcount1.layer.cornerRadius = 12.5;
            _labcount1.layer.masksToBounds = YES;
            [imagelogobtn addSubview:_labcount1];
        }
        
        UILabel * viplab = [[UILabel alloc] initWithFrame:CGRectMake(90, 55, 25, 25)];
        viplab.layer.cornerRadius = viplab.height / 2.0;
        viplab.layer.masksToBounds = YES;
        viplab.textColor = [UIColor colorFromHexCode:@"#227600"];
        viplab.backgroundColor = RGBCOLOR(255, 95, 5);
        UIImageView *vipView = [[UIImageView alloc] initWithFrame:CGRectMake(2.5, 7.5, 20, 10)];
        vipView.image = [UIImage imageNamed:@"vip_pic"];
        [viplab addSubview:vipView];
        [imagelogobtn addSubview:viplab];
        
        _handbtn= [[UIButton alloc] initWithFrame:CGRectMake(15, 15, 70, 70)];
        if ([IEngine engine].headImage.hasValue && ![[IEngine engine].headImage  isEqual: DeFaultURL]) {
            NSLog(@"%@",[IEngine engine].headImage);
            NSURL *url = [NSURL URLWithString:[IEngine engine].headImage];
//            [_handbtn setImageWithURL:url forState:UIControlStateNormal];
            [_handbtn setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"iSH_HomeLogo"]];
        } else {
            [_handbtn setBackgroundImage:[UIImage imageNamed:@"iSH_HomeLogo"] forState:UIControlStateNormal];
        }
        [_handbtn addTarget:self action:@selector(handbtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        _handbtn.backgroundColor = [UIColor clearColor];
        _handbtn.layer.masksToBounds = YES;
        [_handbtn.layer setCornerRadius:_handbtn.height / 2.0];
        _handbtn.layer.borderColor = [UIColor colorFromHexCode:@"#ffffff"].CGColor;
        _handbtn.layer.borderWidth = 3.0;
        [imagelogobtn addSubview:_handbtn];
        return cell;
    } else if (indexPath.row == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView removeAllSubviews];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 100, 20)];
        lab.text = @"我的订单";
        lab.textColor = [UIColor colorFromHexCode:@"#333333"];
        lab.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:lab];
        UIButton * allOrders = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width - 120, 5, 100, 20)];
        [allOrders setTitle:@"查看所有订单" forState:UIControlStateNormal];
        [allOrders setTitleColor:RGBCOLOR(255, 95, 5) forState:UIControlStateNormal];
        allOrders.tag = 0;
        [allOrders addTarget:self action:@selector(difrentOrederWithSender:) forControlEvents:UIControlEventTouchUpInside];
        allOrders.titleLabel.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:allOrders];
        cell.backgroundColor = [UIColor colorFromHexCode:@"dededd"];
        UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width - 20, 7.5, 10, 15)];
        imageview.image = [UIImage imageNamed:@"iSH_More"];
        cell.backgroundColor = Color_bkg_lightGray;
        [cell.contentView addSubview:imageview];
        return cell;
    } else if (indexPath.row == 2) {
        CGFloat x = self.view.width / 5;
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
        }
        [cell.contentView removeAllSubviews];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        for (NSInteger i = 0; i < 5; i ++) {
            UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(i * x, 0, x, 59)];
            [cell.contentView addSubview:btn];
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(5, 36, 50, 20)];
            lab.text = _arr[i];
            lab.textColor = [UIColor colorFromHexCode:@"#999999"];
            lab.font = [UIFont systemFontOfSize:12];
            lab.textAlignment = NSTextAlignmentCenter;
            [btn addSubview:lab];
            
            UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 30, 30)];
            imageview.image = [UIImage imageNamed:_arrImage[i]];
            [btn addSubview:imageview];
            btn.tag = i + 1;
            [btn addTarget:self action:@selector(difrentOrederWithSender:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    } else if (indexPath.row == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier3];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier3];
        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = Color_bkg_lightGray;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier4];
        [cell.contentView removeAllSubviews];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier4];
        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 100, 20)];
        lab.text = [_personInfoTit objectAtIndex:indexPath.row - 4];
        lab.textColor = [UIColor colorFromHexCode:@"#333333"];
        lab.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:lab];
        UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7.5, 30, 30)];
        imageview.image = [UIImage imageNamed:[_personInfoImg objectAtIndex:indexPath.row - 4]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (6 == indexPath.row) {
            UIImageView *redImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth - 40, 17.5, 10, 10)];
            redImageView.backgroundColor = [UIColor redColor];
            redImageView.layer.cornerRadius = 5;
            redImageView.layer.masksToBounds = YES;
            if (_hasRedPoint) {
                redImageView.hidden = NO;
            } else {
                redImageView.hidden = YES;
            }
            [cell.contentView addSubview:redImageView];
        }
        [cell.contentView addSubview:imageview];
        return cell;
    }
}

/**
 *  设置cell高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.row)
        return 100;
    else if (1 == indexPath.row)
        return 30;
    else if (2 == indexPath.row)
        return 59;
    else if (3 == indexPath.row)
        return 15;
    else
        return 44;
}

/**
 *  点击cell跳转页面
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_personInfo deselectRowAtIndexPath:indexPath animated:YES];
//点击tableviewcell时颜色一闪而过
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (4 == indexPath.row) {
//完善个人信息
        [self personalData];
    }else if (5 == indexPath.row){
//收藏管理
        CollectionManagementViewController * collection = [[CollectionManagementViewController alloc] init];
        [self.navigationController pushViewController:collection animated:YES];
    }else if (6 == indexPath.row){
//消息中心
        MsgCenViewController *msgCenVC = [[MsgCenViewController alloc] init];
        [self.navigationController pushViewController:msgCenVC animated:YES];
    }else if (7 == indexPath.row){
//我的购物车
        ShoppingCartViewController * shoppingcart = [[ShoppingCartViewController alloc] init];
        shoppingcart.type = 2;
        shoppingcart.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:shoppingcart animated:YES];
    }else if (8 == indexPath.row){
//密码修改
        RetrievePasswordViewController * retrievePassword = [[RetrievePasswordViewController alloc] init];
        retrievePassword.type = 1;
        [self.navigationController pushViewController:retrievePassword animated:YES];
    }else if (9 == indexPath.row){
//地址管理
        AddressManagementViewController * addressmanagement = [[AddressManagementViewController alloc] init];
        [self.navigationController pushViewController:addressmanagement animated:YES];
    }
}

//点击背景跳转到完善个人资料
- (void)personalData{
    ImprovePersonalDataViewController * personaldata = [[ImprovePersonalDataViewController alloc] init];
    personaldata.delegate  = self;
    personaldata.nickNam   = [IEngine engine].nickName;
    personaldata.headImg   = [IEngine engine].headImage;
    personaldata.sex       = [IEngine engine].sex;
    personaldata.brithDate = [IEngine engine].birthDay;
    personaldata.phoneNum  = [IEngine engine].linkTel;
    [self.navigationController pushViewController:personaldata animated:YES];
}

//查看所有订单
- (void)difrentOrederWithSender:(UIButton *)sender {
    AllOrdersViewController * allorders = [[AllOrdersViewController alloc] init];
    switch (sender.tag) {
        case 0:
            allorders.selectedTag = @"0";
            break;
        case 1:
            allorders.selectedTag = @"1";
            break;
        case 2:
            allorders.selectedTag = @"2";
            break;
        case 3:
            allorders.selectedTag = @"3";
            break;
        case 4:
            allorders.selectedTag = @"4";
            break;
        default:
            allorders.selectedTag = @"5";
            break;
    }
    [self.navigationController pushViewController:allorders animated:YES];
}

/**
 *  更换头像
 */
- (void)handbtnPressed:(id)sender {
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
    [_handbtn setBackgroundImage:image forState:UIControlStateNormal];
    _selectedImg = image;
    [self startRequest:2];
}

#pragma mark - logInDelegate
-(void)backToPerCenVCWithInfo:(NSDictionary *)info {
    _scrollView.hidden = YES;
    [self startRequest:3];
//    _VIP = [self getUserLvWithDic:[IEngine engine].userintegral];
}

#pragma mark - logOutDelegate
-(void)logOutToRootVC {
    _isLogIn = NO;
    _pointImageView.hidden = YES;
    _scrollView.hidden = NO;
}

#pragma mark - BackPCDelegate
-(void)backToPCViewController {
    _scrollView.hidden = YES;
    [_personInfo reloadData];
}

#pragma mark - LogInOrRegisterDelegate
-(void)clickLogInOrRegistertag:(NSInteger)tag {
    if (tag == 1) {
        LoginingViewController *logInVC = [[LoginingViewController alloc] init];
        logInVC.delegate = self;
        [self.navigationController pushViewController:logInVC animated:YES];
    } else if (tag == 2) {
        RegisteringViewController * registerViewController = [[RegisteringViewController alloc] init];
        [self.navigationController pushViewController:registerViewController animated:YES];
    }
}

/*
 ** 注册完毕后回调
 */
-(void)finishedRegisterWithNotification:(NSNotification *)notification {
//    _scrollView.hidden = YES;
    _phoneNum = [notification.userInfo objectForKey:@"phone"];
    _passWord = [notification.userInfo objectForKey:@"password"];
    [self startRequest:1];
}

/**
 * 消息监听
 */
-(void)hasRecivedNewMessageWithnotification:(NSNotification *)notification {
    if (!_hasRedPoint) {
        _pointImageView.hidden = NO;
        _hasRedPoint = YES;
        NSIndexPath *index = [NSIndexPath indexPathForRow:6 inSection:0];
        [_personInfo reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}

/**
 * 取消红点
 */
-(void)hasReadMessage {
    if (_hasRedPoint) {
        _pointImageView.hidden = YES;
        _hasRedPoint = NO;
        NSIndexPath *index = [NSIndexPath indexPathForRow:6 inSection:0];
        [_personInfo reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - CCRequest
-(BOOL)startRequest:(NSInteger)requestID {
    if ([super startRequest:requestID]) {
        if (requestID == 1) {
            [_client loginWithAccount:_phoneNum password:_passWord];
        }
        if (requestID == 2) {
            NSArray *arr = @[_selectedImg];
            [_client saveOrChangeInfoWithUcode:nil headImg:arr[0] nickName:[IEngine engine].nickName sex:[[IEngine engine].sex intValue] birthdate:[[IEngine engine].birthDay intValue] phone:[IEngine engine].linkTel];
        }
        if (requestID == 3) {
            [_client getTheNumOfOverOrder];
        }
        return YES;
    }
    return NO;
}

-(BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result {
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 1) {
            NSDictionary *dic = [result objectForKey:@"data"];
            [[IEngine engine] loginWithDictionary:dic];
//            _VIP = [self getUserLvWithDic:[IEngine engine].userintegral];
            [self startRequest:3];
            _scrollView.hidden = YES;
//            [_personInfo reloadData];
        }
        if (sender.requestID == 2) {
            NSDictionary *data = [result getDictionaryForKey:@"data"];
            [[IEngine engine] chageWithDic:data];
            [_personInfo reloadData];
        }
        if (sender.requestID == 3) {
            NSDictionary *dic = [result getDictionaryForKey:@"data"];
            NSString *overOrderNum = [dic getStringValueForKey:@"over_number" defaultValue:nil];
            _VIP = [self getUserLvWithDic:overOrderNum];
            [_personInfo reloadData];
            
        }
        return YES;
    }
    return NO;
}

-(NSString *)getUserLvWithDic:(NSString *)numStr {
    NSInteger lv = [numStr integerValue];
    _isLogIn = YES;
    if (lv == 0) {
        return @"V0会员";
    } else if (lv == 1) {
        return @"V1会员";
    } else if (lv < 4) {
        return @"V2会员";
    } else if (lv < 10) {
        return @"V3会员";
    } else if (lv < 20) {
        return @"V4会员";
    } else if (lv < 30) {
        return @"V6会员";
    } else if (lv < 50) {
        return @"V7会员";
    } else if (lv < 70) {
        return @"V8会员";
    } else if (lv < 90) {
        return @"V9会员";
    } else if (lv < 110) {
        return @"V10会员";
    } else if (lv < 140) {
        return @"V11会员";
    } else if (lv < 170) {
        return @"V12会员";
    } else if (lv < 200) {
        return @"V13会员";
    } else if (lv < 230) {
        return @"V14会员";
    } else if (lv < 260) {
        return @"V15会员";
    } else if (lv < 290) {
        return @"V16会员";
    } else if (lv < 350) {
        return @"V17会员";
    } else if (lv < 400) {
        return @"V18会员";
    } else if (lv < 450) {
        return @"V19会员";
    } else if (lv < 500) {
        return @"V20会员";
    } else {
        return @"V21会员";
    }
}

@end
