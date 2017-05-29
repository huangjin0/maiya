//
//  SettleViewController.m
//  IOSProject
//
//  Created by IOS002 on 15/7/11.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "SettleViewController.h"
//地址cell
#import "OrderAdressAddCell.h"
#import "OrderAddressCell.h"
//商品cell
#import "OrderGoodsCell.h"
//支付cell
#import "OrderPayStateCell.h"
#import "OrderSendStateCell.h"
#import "OrderTextCell.h"
//提交订单
#import "OrderFooterView.h"

#import "AddressModel.h"

#import "OrderDetailsViewController.h"
#import "ShoppingCartModel.h"

#import "AddAdressViewController.h"
#import "AddressManagementViewController.h"

@interface SettleViewController ()<UITableViewDataSource,UITableViewDelegate,sendStateSelectedDelegate,CCPickerViewDelegate,referOrderDelegate,payStateDelegate,SaveAddressDelegate,backtoSettleVCDelegate> {
//    获取购买商品列表
    UITableView *_payCartList;
//    获取地址列表
    NSMutableArray *_adressArr;
//    派送方式
    NSMutableString *_sendStateStr;

//    支付方式
    NSString *_payState;
//    运营开始时间
    NSString *_beginTime;
//    运营结束时间
    NSString *_endTime;
//    运营时间段
    NSString *_bussinissTime;
//    系统时间
    NSString *_severiceTime;
//    最佳配送时间
    NSTimeInterval _bestStartTime;
    
    OrderFooterView *_footerView;
}
@end

@implementation SettleViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    BasicNavigationController *navigationController =(BasicNavigationController *) self.navigationController;
    navigationController.canDragBack = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(referOrderBtnState) name:@"referBtnState" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    BasicNavigationController *navigationController =(BasicNavigationController *) self.navigationController;
    navigationController.canDragBack = YES;
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackButtonToNavigation];
    _sendStateStr = [NSMutableString string];
    [_sendStateStr appendString:@"即时派送"];
    
    self.navigationItem.title = @"结算";
    _adressArr = [NSMutableArray array];
    _payCartList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64 - 70)];
    _payCartList.dataSource = self;
    _payCartList.delegate = self;
    _payCartList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _payCartList.backgroundColor = Color_bkg_lightGray;
    [self.view addSubview:_payCartList];
    [self addFooterView];
    [self startRequest:2];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier1 = @"cell1";
    static NSString *identifier2 = @"cell2";
    static NSString *identifier3 = @"cell3";
    static NSString *identifier4 = @"cell4";
//    static NSString *identifier5 = @"cell5";
    static NSString *identifier6 = @"cell6";
    switch (indexPath.section) {
        case 0:{
            if (_adressArr.count == 0) {
                OrderAdressAddCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
                if (!cell) {
                    cell = [[OrderAdressAddCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
                }
                [cell.addAddressBtn addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            } else {
                OrderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier6];
                if (!cell) {
                    cell = [[OrderAddressCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:identifier6];
                }
                [cell.otherAdress addTarget:self action:@selector(otherAddressAction) forControlEvents:UIControlEventTouchUpInside];
                AddressModel *model = [_adressArr objectAtIndex:0];
                cell.item = model;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
            break;
        case 1:{
            OrderGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
            if (!cell) {
                cell = [[OrderGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
            }
            cell.item = self.goodsInfo[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        default:{
            switch (indexPath.row) {
                case 0: {
                    OrderSendStateCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier3];
                    if (!cell) {
                        cell = [[OrderSendStateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier3];
                    }
                    cell.sendStateLabel.text = _sendStateStr;
                    cell.bussinissTime.text = _bussinissTime;
                    cell.delegate = self;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }
                    break;
                case 1: {
                    OrderPayStateCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier4];
                    if (!cell) {
                        cell = [[OrderPayStateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier4];
                    }
                    cell.delegate = self;
                    if ([_sendStateStr isEqualToString:@"上门自提"]) {
                        cell.cashOD.hidden = YES;
                        cell.cashODText.hidden = YES;
                    } else {
                        cell.cashOD.hidden = NO;
                        cell.cashODText.hidden = NO;
                    }
                    if ([_payState integerValue] == 1) {
                        cell.alipay.selected = YES;
                        cell.cashOD.selected = NO;
                    } else if ([_payState integerValue] == 2) {
                        cell.cashOD.selected = YES;
                        cell.alipay.selected = NO;
                    } else {
                        cell.cashOD.selected = NO;
                        cell.alipay.selected = NO;
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }
                    break;
                default: {
                    return nil;
                }
                    break;
            }
            
        }
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return self.goodsInfo.count;
        default:
            return 2;
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = Color_bkg_lightGray;
    return backView;
}

- (void) addFooterView {
    _footerView = [[OrderFooterView alloc] initWithFrame:CGRectMake(0, self.view.height - 134, [UIScreen mainScreen].bounds.size.width, 70)];
    _footerView.totalPrice.text = self.totalPrice;
    _footerView.sendMoney.text = self.shipfee;
    _footerView.maxPrice.text = [NSString stringWithFormat:@"(即时配送需配送费)"] ;
    _footerView.delegate = self;
    _footerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_footerView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 69;
            break;
        case 1:
            return 90;
            break;
        default:
            return 60;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 5;
            break;
        case 1:
            return 15;
            break;
        default:
            return 0;
            break;
    }
}

/**
 * 弹出到添加地址界面
 */
-(void)addAddress {
    AddressManagementViewController *addressManageVC = [[AddressManagementViewController alloc] init];
    addressManageVC.delegate = self;
    addressManageVC.type = 1;
    [self.navigationController pushViewController:addressManageVC animated:YES];
}

/**
 * 其他地址
 */
-(void)otherAddressAction {
    AddressManagementViewController *addressManageVC = [[AddressManagementViewController alloc] init];
    addressManageVC.delegate = self;
    addressManageVC.type = 1;
    [self.navigationController pushViewController:addressManageVC animated:YES];
}

#pragma mark - BackToSettleVCDelegate
-(void)backToSettleVCWithDic:(NSDictionary *)dic {
    [self getAddressListWithdic:dic];
    [_adressArr removeAllObjects];
    AddressModel *moel = [[AddressModel alloc] init];
    moel.name = [dic getStringValueForKey:@"consignee" defaultValue:nil];
    moel.area = [dic getStringValueForKey:@"area" defaultValue:nil];
    moel.address = [dic getStringValueForKey:@"address" defaultValue:nil];
    moel.phone = [dic getStringValueForKey:@"connetNum" defaultValue:nil];
    [_adressArr addObject:moel];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //刷新当前行
    [_payCartList reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

#pragma mark - SendStateSelectedDelegate
-(void)sendStateSelect {
    CCPickerView *sendPickerView = [[CCPickerView alloc] initWithDel:self type:CCPickerDefault];
    sendPickerView.identifier = @"sendState";
    NSArray *contentArray;
    if ([_payState integerValue] != 2) {
        contentArray = @[@"免费配送",@"即时派送",@"上门自提"];
    } else {
        contentArray = @[@"免费配送",@"即时派送"];
    }
    [sendPickerView addContentArray:contentArray];
    sendPickerView.delegate = self;
    [sendPickerView show];
}

#pragma mark - payStateDelegate
-(void)payStateWithState:(NSString *)state {
    _payState = state;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"referBtnState" object:nil];
}

#pragma mark - referOrderDelegate
-(void)referOrder {
    if ([_payState intValue] != 1 && [_payState intValue] != 2) {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:nil message:@"请选择支付方式" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alerView show];
    } else if ([_sendStateStr isEqualToString:@"即时派送"]) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_severiceTime integerValue]];
        NSString *nowHour = [date stringFromDate:@"HH"];
        NSString *nowMini = [date stringFromDate:@"mm"];
        NSInteger nowTime = [nowHour integerValue] * 3600 + [nowMini integerValue] * 60;
        if ([_beginTime integerValue] > nowTime || [_endTime integerValue] < nowTime) {
            [CCAlertView showText:@"抱歉，尚不支持本时间段派送" life:1];
        } else {
            [self startRequest:1];
        }
    } else {
        [self startRequest:1];
    }
}

#pragma mark - SaveAddressDelegate
-(void)backAddressViewControllerWithDic:(NSDictionary *)dic {
    AddressModel *model = [[AddressModel alloc] initWithDictionary:dic];
    [_adressArr addObject:model];
    [_payCartList reloadData];
}

#pragma mark - CCPickerViewDelegate
- (void)pickerViewDidDismiss:(CCPickerView*)sender {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_severiceTime integerValue] + 24 * 3600];
//    NSString *datestr = [date stringFromDate:@"yyyy.MM.dd HH:mm"];
    if ([sender.identifier isEqualToString:@"sendState"]) {
        [_sendStateStr deleteCharactersInRange:[_sendStateStr rangeOfString:_sendStateStr]];
        KNumber *num = [sender.selections objectAtIndex:0];
        NSArray * selections = [sender.content objectAtIndex:0];
        NSString *str = [selections objectAtIndex:num.value];
        [_sendStateStr appendString:str];
        if ([str isEqualToString:@"免费配送"]) {
            CCPickerView *datePicker = [[CCPickerView alloc] initWithDel:self type:CCPickerDate];
//            NSDate *lateDate = [NSDate dateWithTimeInterval:1800 * 24 sinceDate:date];
            datePicker.identifier = @"sendDate";
            datePicker.minimumDate = date;
            [datePicker show];
        }
        if ([str isEqualToString:@"即时派送"]) {
            NSString *nowHour = [date stringFromDate:@"HH"];
            NSString *nowMini = [date stringFromDate:@"mm"];
            NSInteger nowTime = [nowHour integerValue] * 3600 + [nowMini integerValue] * 60;
            NSDate *date = [NSDate date];
            _bestStartTime = [date timeIntervalSince1970];
            if ([_beginTime integerValue] > nowTime || [_endTime integerValue] < nowTime) {
                [CCAlertView showText:@"抱歉，尚不支持本时间段派送" life:1];
            }
        }
     } else if ([sender.identifier isEqualToString:@"sendDate"]) {
        NSDate *selecteDate = sender.selectedDate;
        NSString *dateStr = [selecteDate stringFromDate:@"yyyy.MM.dd"];
        NSInteger startDate = [selecteDate timeIntervalSince1970];
        NSInteger otherTime = startDate % (3600 * 24);
        _bestStartTime = startDate - otherTime - (3600 * 8);
        [_sendStateStr appendFormat:@"%@",dateStr];
        CCPickerView *beginTimePick = [[CCPickerView alloc] initWithDel:self type:CCPickerTime];
        beginTimePick.identifier = @"beginTime";
        [beginTimePick show];
     } else  {
         NSDate *selecteDate = sender.selectedDate;
         NSInteger selectTime = [selecteDate timeIntervalSince1970];
         NSString *dateStr = [selecteDate stringFromDate:@"HH:mm"];
         NSString *hourStr = [selecteDate stringFromDate:@"HH"];
         NSString *miniStr = [selecteDate stringFromDate:@"mm"];
         NSInteger seleteTime = [hourStr integerValue] * 3600 + [miniStr integerValue] * 60;
         _bestStartTime += seleteTime;
         NSInteger endSelteTime = selectTime + 1800;
         NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:endSelteTime];
         NSString *endDateStr = [endDate stringFromDate:@"HH:mm"];
         if ([_beginTime integerValue] > seleteTime || [_endTime integerValue] < seleteTime) {
             [CCAlertView showText:@"抱歉，尚不支持本时间段派送" life:1];
             CCPickerView *beginTimePick = [[CCPickerView alloc] initWithDel:self type:CCPickerTime];
             beginTimePick.identifier = @"beginTime";
             [beginTimePick show];
         } else {
             [_sendStateStr appendFormat:@" %@-%@",dateStr,endDateStr];
         }
     }
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:2];
    [_payCartList reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"referBtnState" object:nil];
}

- (void)pickerViewDidCancel:(CCPickerView*)sender {
    [_sendStateStr deleteCharactersInRange:[_sendStateStr rangeOfString:_sendStateStr]];
    [_sendStateStr appendString:@"即时派送"];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    [_payCartList reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"referBtnState" object:nil];
}

/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - CCRequest
-(BOOL)startRequest:(NSInteger)requestID {
    if ([super startRequest:requestID]) {
        if (requestID == 0) {
            [_client getDefaultsDetail];
        } else if (requestID == 1) {
            NSMutableString *cartId = [NSMutableString string];
            for (int i = 0; i < self.goodsInfo.count; i ++) {
                ShoppingCartModel *model = [self.goodsInfo objectAtIndex:i];
                NSString *str = model.cartId;
                if (i == 0) {
                    [cartId appendString:str];
                } else {
                    [cartId appendFormat:@",%@",str];
                }
            }
            int deliverType;
            if ([_sendStateStr isEqualToString:@"即时派送"]) {
                deliverType = 2;
            } else if ([_sendStateStr isEqualToString:@"上门自提"]) {
                deliverType = 3;
            } else {
                deliverType = 1;
            }
            AddressModel *model = [_adressArr objectAtIndex:0];
            [_client addOrderWithcartId:cartId payWay:[_payState intValue] deliverType:deliverType mack:nil linkName:model.name tel:model.phone address:model.address area:model.area bestStartTime:_bestStartTime bestEndTime:_bestStartTime + 1800];
            } else if (requestID == 2) {
            [_client getTheTimeOfShopOpen];
        } else if (requestID == 3) {
            [_client userGetCartNum];
        }
        return YES;
    }
    return NO;
}

-(BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result {
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 0) {
            NSDictionary *dataDic = [result getDictionaryForKey:@"data"];
            [self getAddressListWithdic:dataDic];
            [_payCartList reloadData];
        } else if (sender.requestID == 1) {
            [self startRequest:3];
            NSDictionary *dic = [result getDictionaryForKey:@"data"];
            OrderDetailsViewController *orderDetailVC = [[OrderDetailsViewController alloc] init];
            orderDetailVC.oderId = [dic getStringValueForKey:@"order_id" defaultValue:nil];
            if (_type == 2) {
                orderDetailVC.type = 2;
            } else {
                orderDetailVC.type = 1;
            }
            [self.navigationController pushViewController:orderDetailVC animated:YES];
        } else if (sender.requestID == 2) {
            NSDictionary *dataDic = [result getDictionaryForKey:@"data"];
            _severiceTime = [dataDic getStringValueForKey:@"server_time" defaultValue:nil];
            _bussinissTime = [self getTheTimeShopBussinissWithDictionary:dataDic];
            [_payCartList reloadData];
            [self startRequest:0];
        } else if (sender.requestID == 3) {
            NSDictionary *data = [result getDictionaryForKey:@"data"];
            NSString *cartNum = [data getStringValueForKey:@"cart_number" defaultValue:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cartNum" object:nil userInfo:@{@"cartNum":cartNum}];
        }
        return YES;
    }
       return NO;
}

//获取商家运营时间
-(NSString *)getTheTimeShopBussinissWithDictionary:(NSDictionary *)dic {
    NSString *beginTime = [dic getStringValueForKey:@"expend1" defaultValue:nil];
    NSInteger beginHour = [beginTime integerValue] / 3600;
    NSInteger beginMinue = ([beginTime integerValue] / 60) % 60;
    _beginTime = beginTime;
    NSString *endTime = [dic getStringValueForKey:@"value" defaultValue:nil];
    NSInteger endHour = [endTime integerValue] / 3600;
    NSInteger endMinue = ([endTime integerValue] / 60) % 60;
    _endTime = endTime;
    NSString *shopStr = [NSString stringWithFormat:@"运营时间 %ld:%.2ld—%ld:%.2ld",beginHour,beginMinue,endHour,endMinue];
    return shopStr;
}

//获取地址列表
-(void)getAddressListWithdic:(NSDictionary *)dic {
    [_adressArr removeAllObjects];
    AddressModel *model = [[AddressModel alloc] initWithDictionary:dic];
    [_adressArr addObject:model];
}

//监听提交订单状态
-(void)referOrderBtnState {
    if ([_sendStateStr isEqualToString:@"即时派送"]) {
        _footerView.sendMoney.text = self.shipfee;
        _footerView.contreinLab.text = @"(含运费)";
    } else {
        _footerView.sendMoney.text = @"0.00";
        _footerView.contreinLab.text = @"(免运费)";
    }
    if ([_payState intValue] == 1 || [_payState intValue] == 2) {
        _footerView.referOrder.backgroundColor = RGBCOLOR(255, 95, 5);
        _footerView.referOrder.userInteractionEnabled = YES;
    } else {
        _footerView.referOrder.backgroundColor = [UIColor colorFromHexCode:@"#dededd"];
        _footerView.referOrder.userInteractionEnabled = NO;
    }
}

@end
