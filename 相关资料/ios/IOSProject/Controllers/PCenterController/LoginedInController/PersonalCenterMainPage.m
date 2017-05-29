//
//  PersonalCenterMainPage.m
//  IOSProject
//
//  Created by IOS004 on 15/6/12.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "PersonalCenterMainPage.h"
#import "ImprovePersonalDataViewController.h"
#import "SetUpViewController.h"
#import "ShoppingCartViewController.h"
#import "CollectionManagementViewController.h"
#import "PasswordChangeViewController.h"
#import "AddressManagementViewController.h"
#import "AllOrdersViewController.h"
#import "CropAvatarController.h"
#import "UIButton+WebCache.h"

@interface PersonalCenterMainPage ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate ,CropAvatarControllerDelegate,logOutDelegate>{
    UIButton * _handbtn;
    UIButton * _imagebutton;
    UILabel  * _labcount;
}

@end

@implementation PersonalCenterMainPage

- (id)init{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人中心";
    UIButton * leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"grcenter_ic_setting_normal"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(setUp) forControlEvents:UIControlEventTouchUpInside];
    leftbtn.frame = CGRectMake(10, 10, 20, 20);
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIButton * rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setBackgroundImage:[UIImage imageNamed:@"mynews_ic_normal"] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(messageCenter) forControlEvents:UIControlEventTouchUpInside];
    rightbtn.frame = CGRectMake(10, 10, 20, 20);
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightButton;
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
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        //cell右边加上小箭头
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        CGFloat x = self.view.width / 5;
        
        if (0 == indexPath.row) {
            UIButton * imagelogobtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 90)];
            [imagelogobtn setImage:[UIImage imageNamed:@"grcenter_pic_xinxibg"] forState:UIControlStateNormal];
            [imagelogobtn addTarget:self action:@selector(personalData) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:imagelogobtn];
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, 120, 30)];
            lab.text = @"15881080208";
            lab.textColor = [UIColor colorFromHexCode:@"#ffffff"];
            lab.font = [UIFont systemFontOfSize:18];
            [imagelogobtn addSubview:lab];
            for (NSInteger i = 0; i < 2; i ++) {
                NSArray * arr = @[@"V0会员",@"积分：55"];
                _labcount = [[UILabel alloc] initWithFrame:CGRectMake(90 + (100 * i), 50, 80 - (i * 20), 30)];
                _labcount.backgroundColor = [UIColor colorFromHexCode:@"#000000"];
                _labcount.alpha = 0.3;
                _labcount.text = arr[i];
                _labcount.textAlignment = NSTextAlignmentRight;
                _labcount.textColor = [UIColor colorFromHexCode:@"#ffffff"];
                _labcount.font = [UIFont systemFontOfSize:14];
                _labcount.layer.cornerRadius = 15;
                _labcount.layer.masksToBounds = YES;
                [imagelogobtn addSubview:_labcount];
            }
            UILabel * viplab = [[UILabel alloc] initWithFrame:CGRectMake(90, 50, 30, 30)];
            viplab.layer.cornerRadius = viplab.height / 2.0;
            viplab.layer.masksToBounds = YES;
            viplab.text = @"VIP";
            viplab.textColor = [UIColor colorFromHexCode:@"#227600"];
            viplab.backgroundColor = [UIColor colorFromHexCode:@"#489925"];
            [imagelogobtn addSubview:viplab];
            
            _handbtn= [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 70, 70)];
            [_handbtn setImage:[UIImage imageNamed:@"hongzao"] forState:UIControlStateNormal];
            [_handbtn addTarget:self action:@selector(handbtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            _handbtn.backgroundColor = [UIColor clearColor];
            _handbtn.layer.masksToBounds = YES;
            [_handbtn.layer setCornerRadius:_handbtn.height / 2.0];
            [imagelogobtn addSubview:_handbtn];
            
        }else if (1 == indexPath.row){
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 100, 20)];
            lab.text = @"我的订单";
            lab.textColor = [UIColor colorFromHexCode:@"#333333"];
            lab.font = [UIFont systemFontOfSize:14];
            [cell addSubview:lab];
            UIButton * allOrders = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width - 120, 5, 100, 20)];
            [allOrders setTitle:@"查看所有订单" forState:UIControlStateNormal];
            [allOrders setTitleColor:[UIColor colorFromHexCode:@"#489925"] forState:UIControlStateNormal];
            allOrders.tag = 0;
            [allOrders addTarget:self action:@selector(difrentOrederWithSender:) forControlEvents:UIControlEventTouchUpInside];
            allOrders.titleLabel.font = [UIFont systemFontOfSize:14];
            [cell addSubview:allOrders];
            cell.backgroundColor = [UIColor colorFromHexCode:@"dededd"];
            UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width - 20, 7.5, 10, 15)];
            imageview.image = [UIImage imageNamed:@"grcenter_ic_ckdd_normal"];
            [cell addSubview:imageview];
        }else if (2 == indexPath.row){
            
            for (NSInteger i = 0; i < 5; i ++) {
                NSArray * arr = @[@"代付款",@"待收货",@"待评价",@"已完成",@"退款中"];
                NSArray * arrImage = @[@"fukuan",@"shouhuo",@"pingjia",@"wancheng",@"tuikuan"];
                UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(i * x, 0, x, 59)];
                [cell addSubview:btn];
                
                UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(5, 36, 50, 20)];
                lab.text = arr[i];
                lab.textColor = [UIColor colorFromHexCode:@"#999999"];
                lab.font = [UIFont systemFontOfSize:12];
                lab.textAlignment = NSTextAlignmentCenter;
                [btn addSubview:lab];
                
                UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 30, 30)];
                imageview.image = [UIImage imageNamed:arrImage[i]];
                [btn addSubview:imageview];
                btn.tag = i + 1;
                [btn addTarget:self action:@selector(difrentOrederWithSender:) forControlEvents:UIControlEventTouchUpInside];
            }
        }else if (3 == indexPath.row){
            cell.backgroundColor = [UIColor colorFromHexCode:@"#dededd"];
        }else if (4 == indexPath.row){
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 100, 20)];
            lab.text = @"完善个人资料";
            lab.textColor = [UIColor colorFromHexCode:@"#333333"];
            lab.font = [UIFont systemFontOfSize:15];
            [cell addSubview:lab];
            UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7.5, 30, 30)];
            imageview.image = [UIImage imageNamed:@"wsgrzl"];
            [cell addSubview:imageview];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (5 == indexPath.row){
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 100, 20)];
            lab.text = @"收藏管理";
            lab.textColor = [UIColor colorFromHexCode:@"#333333"];
            lab.font = [UIFont systemFontOfSize:15];
            [cell addSubview:lab];
            UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7.5, 30, 30)];
            imageview.image = [UIImage imageNamed:@"scgl"];
            [cell addSubview:imageview];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (6 == indexPath.row){
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 100, 20)];
            lab.text = @"消息中心";
            lab.textColor = [UIColor colorFromHexCode:@"#333333"];
            lab.font = [UIFont systemFontOfSize:15];
            [cell addSubview:lab];
            UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7.5, 30, 30)];
            imageview.image = [UIImage imageNamed:@"xxzx"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell addSubview:imageview];
        }else if (7 == indexPath.row){
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 100, 20)];
            lab.text = @"我的购物车";
            lab.textColor = [UIColor colorFromHexCode:@"#333333"];
            lab.font = [UIFont systemFontOfSize:15];
            [cell addSubview:lab];
            UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7.5, 30, 30)];
            imageview.image = [UIImage imageNamed:@"wdgwc"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell addSubview:imageview];
        }else if (8 == indexPath.row){
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 100, 20)];
            lab.text = @"密码修改";
            lab.textColor = [UIColor colorFromHexCode:@"#333333"];
            lab.font = [UIFont systemFontOfSize:15];
            [cell addSubview:lab];
            UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7.5, 30, 30)];
            imageview.image = [UIImage imageNamed:@"mmxg"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell addSubview:imageview];
        }else if (9 == indexPath.row){
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 100, 20)];
            lab.text = @"地址管理";
            lab.textColor = [UIColor colorFromHexCode:@"#333333"];
            lab.font = [UIFont systemFontOfSize:15];
            [cell addSubview:lab];
            UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7.5, 30, 30)];
            imageview.image = [UIImage imageNamed:@"dzgl"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell addSubview:imageview];
        }
    }
    return cell;
}

/**
 *  设置cell高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.row)
        return 90;
    else if (1 == indexPath.row)
        return 30;
    else if (2 == indexPath.row)
        return 59;
    else if (3 == indexPath.row)
        return 15;
    else if (4 == indexPath.row)
        return 44;
    else if (5 == indexPath.row)
        return 44;
    else if (6 == indexPath.row)
        return 44;
    else if (7 == indexPath.row)
        return 44;
    else if (8 == indexPath.row)
        return 44;
    else if (9 == indexPath.row)
        return 44;
    else
        return 100;
}

/**
 *  点击cell跳转页面
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击tableviewcell时颜色一闪而过
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (4 == indexPath.row) {
        //完善个人信息
        ImprovePersonalDataViewController * improve = [[ImprovePersonalDataViewController alloc] init];
        [self.navigationController pushViewController:improve animated:YES];
    }else if (5 == indexPath.row){
        //收藏管理
        CollectionManagementViewController * collection = [[CollectionManagementViewController alloc] init];
        [self.navigationController pushViewController:collection animated:YES];
    }else if (6 == indexPath.row){
        //消息中心
        UIAlertView *alart = [[UIAlertView alloc] initWithTitle:@"消息中心暂未开通" message:@"敬请期待" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alart show];
    }else if (7 == indexPath.row){
        //我的购物车
        ShoppingCartViewController * shoppingcart = [[ShoppingCartViewController alloc] init];
        [self.navigationController pushViewController:shoppingcart animated:YES];
    }else if (8 == indexPath.row){
        //密码修改
        PasswordChangeViewController * passwordchange = [[PasswordChangeViewController alloc] init];
        [self.navigationController pushViewController:passwordchange animated:YES];
    }else if (9 == indexPath.row){
        //地址管理
        AddressManagementViewController * addressmanagement = [[AddressManagementViewController alloc] init];
        [self.navigationController pushViewController:addressmanagement animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击背景跳转到完善个人资料
- (void)personalData{
    ImprovePersonalDataViewController * personaldata = [[ImprovePersonalDataViewController alloc] init];
    [self.navigationController pushViewController:personaldata animated:YES];
}

//跳转到设置界面
- (void)setUp{
    SetUpViewController * setupviewcontroller = [[SetUpViewController alloc] init];
    setupviewcontroller.delegate = self;
    [self.navigationController pushViewController:setupviewcontroller animated:YES];
}

//跳转到消息中心
- (void)messageCenter{
    UIAlertView *alart = [[UIAlertView alloc] initWithTitle:@"消息中心暂未开通" message:@"敬请期待" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alart show];
}

//查看所有订单
- (void)difrentOrederWithSender:(UIButton *)sender {
    AllOrdersViewController * allorders = [[AllOrdersViewController alloc] init];
    
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
        [self presentViewController:picker animated:YES completion:nil];
    }];
}

#pragma mark - UIImagePickerControllerDelegate 代理方法


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *headImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    headImage = [UIImage rotateImage:headImage];
    headImage = [headImage resizeImageGreaterThan:800];
    CropAvatarController * con = [[CropAvatarController alloc] initWithImage:headImage delegate:self];
    [picker pushViewController:con animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)cropAvatarControllerDidFinishWithImage:(UIImage *)image {
    [_handbtn setImage:image forState:UIControlStateNormal];
}
- (void)logOutToRootVC{
}
@end
