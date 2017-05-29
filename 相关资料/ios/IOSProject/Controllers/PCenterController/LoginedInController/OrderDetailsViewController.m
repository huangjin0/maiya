//
//  OrderDetailsViewController.m
//  IOSProject
//
//  Created by IOS004 on 15/6/16.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//
/**
 *  订单详情
 */


#import "OrderDetailsViewController.h"
#import "OrderInfoCell.h"
#import "ConsigeenCell.h"
#import "GoodsInfoCell.h"
#import "GoldCell.h"
#import "OrderDtaileModel.h"
#import "GoodsInfoModel.h"
#import "RefundViewController.h"
#import "EvaluateViewController.h"
#import "AlipayConfig.h"
#import "SFAlipay.h"
#import "CommodityViewController.h"

#define statusH [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height

@interface OrderDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIScrollViewDelegate,refundDelegate>
{
    UITableView *_orderDetailTab;
//    订单信息条目
    NSMutableArray *_orderInfo;
    NSMutableArray *_orderArr;
    BOOL _isfirstloadGoods;
    
//    是否可加载更多
    BOOL _isMore;
    
    OrderDtaileModel *_model;
//    失效时间
    NSString *_loseTime;
    
    UIView *_backView;
    BOOL _isSuccessPay;
}@property (strong, nonatomic) AlipayOrder * alipayOrder;


@end

@implementation OrderDetailsViewController

- (id)init {
    self = [super init];
    if (self) {
        ADD_NTF(NTF_Alipay_Suc, @selector(notificationAlipayDone:));
        ADD_NTF(NTF_Alipay_Failed, @selector(notificationAlipayFailed:));
        ADD_NTF(NTF_Alipay_Cancel, @selector(notificationAlipayCancel:));
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    BasicNavigationController *navigationController =(BasicNavigationController *) self.navigationController;
    navigationController.canDragBack = NO;
    [self startRequest:5];
}

-(void)viewWillDisappear:(BOOL)animated {
    BasicNavigationController *navigationController =(BasicNavigationController *) self.navigationController;
    navigationController.canDragBack = YES;
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addbackButtonWithTypeToNavigation];
    _orderArr = [NSMutableArray array];
//    获取订单详情
    self.navigationItem.title = @"订单详情";
    _orderInfo = [NSMutableArray arrayWithArray:@[@"订单编号",@"下单时间",@"支付方式",@"订单状态",@"派送方式",@"派送时间"]];
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - self.navigationController.navigationBar.height - [UIApplication sharedApplication].statusBarFrame.size.height - 80, ViewWidth, 80)];
    _backView.backgroundColor = Color_bkg_lightGray;
    [self.view addSubview:_backView];
}

/**
 * 添加返回按钮
 */
-(void)addbackButtonWithTypeToNavigation {
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 20, 31);
    [btn setImage:[UIImage imageNamed:@"iSH_Back"] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"btn_back_d"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(popViewControllerWithType) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
}

-(void)popViewControllerWithType {
    if (self.type == 1) {
        NSNotification *notification = [NSNotification notificationWithName:@"backToMyOrderStatus" object:nil userInfo:@{@"status":_orderStatus}];
        [[NSNotificationCenter defaultCenter]postNotification:notification];
        [self.navigationController popToRootViewControllerAnimated:NO];
    } else if (self.type == 2) {
        /**
         * 个人中心进入购物车、结算、进入订单详情
         * 有需要则改
         */
        [self.navigationController popToRootViewControllerAnimated:NO];
        NSNotification *notification = [NSNotification notificationWithName:@"backToMyOrderStatus" object:nil userInfo:@{@"status":_orderStatus}];
        [[NSNotificationCenter defaultCenter]postNotification:notification];
    }
    else {
        if (_delegate != nil && [_delegate respondsToSelector:@selector(backToMyOrderWithStatus:)]) {
            [_delegate backToMyOrderWithStatus:_orderStatus];
            [self.navigationController popViewControllerAnimated:YES];
        }

    }
}

/**
 * 添加底部视图
 */
-(void)addFooterViewToView {
    [_backView removeAllSubviews];
    switch ([self.orderStatus intValue]) {
        case 0: {
            UIButton *payBtn = [[UIButton alloc] initWithFrame:CGRectMake((ViewWidth - 220) / 3, 20, 140, 40)];
            payBtn.backgroundColor = [UIColor colorFromHexCode:@"#757575"];
            [payBtn setTitle:@"订单失效" forState:UIControlStateNormal];
//            [payBtn addTarget:self action:@selector(payMoneyAction) forControlEvents:UIControlEventTouchUpInside];
            [_backView addSubview:payBtn];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((ViewWidth - 220) / 3 * 2 + 140 , 20, 80, 40)];
            imageView.backgroundColor = RGBCOLOR(255, 95, 5);
            [_backView addSubview:imageView];
            UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake((ViewWidth - 220) / 3 * 2 + 140.5 , 20.5, 79, 39)];
            cancleBtn.backgroundColor = [UIColor whiteColor];
            [cancleBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [cancleBtn addTarget:self action:@selector(cancalOreder) forControlEvents:UIControlEventTouchUpInside];
            [cancleBtn setTitleColor:RGBCOLOR(255, 95, 5) forState:UIControlStateNormal];
            [_backView addSubview:cancleBtn];
        }
            break;
        case 1: {
            UIButton *payBtn = [[UIButton alloc] initWithFrame:CGRectMake((ViewWidth - 220) / 3, 20, 140, 40)];
            payBtn.backgroundColor = RGBCOLOR(255, 95, 5);
            [payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
            [payBtn addTarget:self action:@selector(payMoneyAction) forControlEvents:UIControlEventTouchUpInside];
            [_backView addSubview:payBtn];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((ViewWidth - 220) / 3 * 2 + 140 , 20, 80, 40)];
            imageView.backgroundColor = RGBCOLOR(255, 95, 5);
            [_backView addSubview:imageView];
            UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake((ViewWidth - 220) / 3 * 2 + 140.5 , 20.5, 79, 39)];
            cancleBtn.backgroundColor = [UIColor whiteColor];
            [cancleBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [cancleBtn addTarget:self action:@selector(cancalOreder) forControlEvents:UIControlEventTouchUpInside];
            [cancleBtn setTitleColor:RGBCOLOR(255, 95, 5) forState:UIControlStateNormal];
            [_backView addSubview:cancleBtn];
        }
            break;
        case 2: {
            UIButton *payBtn = [[UIButton alloc] initWithFrame:CGRectMake(ViewWidth / 2 - 70, 20, 140, 40)];
            payBtn.backgroundColor = [UIColor colorFromHexCode:@"#dededd"];
            [payBtn setTitle:@"派送中.." forState:UIControlStateNormal];
//            [payBtn addTarget:self action:@selector(confirmCosigine) forControlEvents:UIControlEventTouchUpInside];
            [_backView addSubview:payBtn];
        }
            break;
        case 3: {
            UIButton *payBtn = [[UIButton alloc] initWithFrame:CGRectMake((ViewWidth - 220) / 3, 20, 140, 40)];
            payBtn.backgroundColor = RGBCOLOR(255, 95, 5);
            [payBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            [payBtn addTarget:self action:@selector(confirmCosigine) forControlEvents:UIControlEventTouchUpInside];
            [_backView addSubview:payBtn];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((ViewWidth - 220) / 3 * 2 + 140 , 20, 80, 40)];
            imageView.backgroundColor = RGBCOLOR(255, 95, 5);
            [_backView addSubview:imageView];
            UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake((ViewWidth - 220) / 3 * 2 + 140.5 , 20.5, 79, 39)];
            cancleBtn.backgroundColor = [UIColor whiteColor];
            [cancleBtn setTitle:@"申请退款" forState:UIControlStateNormal];
            [cancleBtn addTarget:self action:@selector(refundAction) forControlEvents:UIControlEventTouchUpInside];
            [cancleBtn setTitleColor:RGBCOLOR(255, 95, 5) forState:UIControlStateNormal];
            [_backView addSubview:cancleBtn];
        }
            break;
        case 4: {
            UIButton *payBtn = [[UIButton alloc] initWithFrame:CGRectMake(ViewWidth / 2 - 70, 20, 140, 40)];
            payBtn.backgroundColor = RGBCOLOR(255, 95, 5);
            [payBtn setTitle:@"马上评价" forState:UIControlStateNormal];
            [payBtn addTarget:self action:@selector(commtentAction) forControlEvents:UIControlEventTouchUpInside];
            [_backView addSubview:payBtn];
        }
            break;
        case 5: {
            UIButton *payBtn = [[UIButton alloc] initWithFrame:CGRectMake((ViewWidth - 220) / 3, 20, 140, 40)];
            payBtn.backgroundColor = RGBCOLOR(255, 95, 5);
            [payBtn setTitle:@"再次购买" forState:UIControlStateNormal];
            [payBtn addTarget:self action:@selector(shopAgain) forControlEvents:UIControlEventTouchUpInside];
            [_backView addSubview:payBtn];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((ViewWidth - 220) / 3 * 2 + 140 , 20, 80, 40)];
            imageView.backgroundColor = RGBCOLOR(255, 95, 5);
            [_backView addSubview:imageView];
            UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake((ViewWidth - 220) / 3 * 2 + 140.5 , 20.5, 79, 39)];
            cancleBtn.backgroundColor = [UIColor whiteColor];
            [cancleBtn setTitle:@"删除" forState:UIControlStateNormal];
            [cancleBtn addTarget:self action:@selector(deleteOrder) forControlEvents:UIControlEventTouchUpInside];
            [cancleBtn setTitleColor:RGBCOLOR(255, 95, 5) forState:UIControlStateNormal];
            [_backView addSubview:cancleBtn];
        }
            break;
        default: {
            UIButton *payBtn = [[UIButton alloc] initWithFrame:CGRectMake(ViewWidth / 2 - 70, 20, 140, 40)];
            payBtn.backgroundColor = RGBCOLOR(255, 95, 5);
            [payBtn setTitle:@"取消退款" forState:UIControlStateNormal];
            [payBtn addTarget:self action:@selector(cancelRefund) forControlEvents:UIControlEventTouchUpInside];
            [_backView addSubview:payBtn];
        }
            break;
    }
}

/**
 * 立即支付界面
 */
-(void)payMoneyAction {
    [self startRequest:4];
}

/**
 * 取消订单
 */
-(void)cancalOreder {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认取消订单" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alertView.tag = 1;
    [alertView show];
}

/**
 * 申请退款
 */
-(void)refundAction {
    RefundViewController *refundVC = [[RefundViewController alloc] init];
    refundVC.model = _model;
    if (_type == 1) {
        refundVC.type = 1;
    } else {
        refundVC.delegate = self;
    }
    [self.navigationController pushViewController:refundVC animated:YES];
}


#pragma -mark RefundDelegate
-(void)overRefundWithPopView {
    if (_delegate != nil && [_delegate respondsToSelector:@selector(backToRefundOrder)]) {
        [_delegate backToRefundOrder];
        [self.navigationController popViewControllerAnimated:NO];
    }
}
/**
 * 马上评价
 */
-(void)commtentAction {
    EvaluateViewController *evaluteVC = [[EvaluateViewController alloc] init];
    evaluteVC.orderId = self.oderId;
    evaluteVC.goodsData = _model.goodsData;
    [self.navigationController pushViewController:evaluteVC animated:YES];
}
/**
 * 确认收货
 */
-(void)confirmCosigine {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认收货" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alertView.tag = 2;
    [alertView show];
}
/**
 * 删除订单
 */
-(void)deleteOrder {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认删除订单" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alertView.tag = 3;
    [alertView show];
}
/**
 * 再次购买
 */
-(void)shopAgain {
//    [self startRequest:7];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定再次购物，我们将按照原订单的内容进行配送" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alertView.tag = 4;
    [alertView show];
}
/**
 * 取消退款
 */
-(void)cancelRefund {
    [self startRequest:6];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
            [self startRequest:1];
        }
    }
    if (alertView.tag == 2) {
        if (buttonIndex == 0) {
            [self startRequest:2];
        }

    }
    if (alertView.tag == 3) {
        if (buttonIndex == 0) {
            [self startRequest:3];
        }
    }
    if (alertView.tag == 4) {
        if (buttonIndex == 0) {
            [self startRequest:7];
        }
    }
}

#pragma mark - UITableViewDelegate,UItableViewDataSource
//表单返回部分数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([_orderStatus intValue] == 6) {
        return 5;
    } else {
        return 4;
    }
}

//每个部分返回格数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return _model.orderInfo.count;
            break;
        case 1:
            return 1;
            break;
        case 2:
        {
            if (!_isMore) {
                if (_model.goodsData.count > 3) {
                    return 3;
                } else {
                    return  _model.goodsData.count;
                }
            } else {
                return _model.goodsData.count;
            }
        }
            break;
        case 4:
            return 1;
            break;
        default:
            return 3;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * identifier1 = @"identifier1";
    static NSString * identifier2 = @"identifier2";
    static NSString * identifier3 = @"identifier3";
    static NSString * identifier4 = @"identifier4";
    static NSString * identifier5 = @"identifier5";
//    OrderDtaileModel *model = [_orderArr objectAtIndex:0];
    switch (indexPath.section) {
        case 0:
        {
            OrderInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
            if (!cell) {
                cell = [[OrderInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
            }
            cell.cellName.text = [_orderInfo objectAtIndex:indexPath.row];
            cell.cellInfo.text = [_model.orderInfo objectAtIndex:indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
//            break;
        case 1:
        {
            ConsigeenCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
            if (!cell) {
                cell = [[ConsigeenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
            }
            cell.item = _model;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
//            break;
        case 2:
        {
            GoodsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier3];
            if (!cell) {
                cell = [[GoodsInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier3];
            }
            GoodsInfoModel *goodsInfo = [_model.goodsData objectAtIndex:indexPath.row];
            cell.item = goodsInfo;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case 4: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier5];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier5];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView removeAllSubviews];
            UILabel *applyLab = [UILabel linesText:_model.content font:[UIFont systemFontOfSize:16] wid:ViewWidth - 20 lines:3 color:[UIColor colorFromHexCode:@"#757575"]];
            applyLab.origin = CGPointMake(20, 0);
            [cell.contentView addSubview:applyLab];
            return cell;
        }
//            break;
        default:
        {
            GoldCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier4];
            if (!cell) {
                cell = [[GoldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier4];
            }
            NSArray *arr = @[@"商品总金额",@"运费",@"应付金额"];
            cell.goldsNam.text = [arr objectAtIndex:indexPath.row];
            cell.goldsPri.text = [NSString stringWithFormat:@"￥%@",[_model.goldArr objectAtIndex:indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
//            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 3 && !_isMore && _model.goodsData.count > 3) {
        return 60;
    } else {
        return 30;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 34;
            break;
        case 1:
            return 90;
            break;
        case 2:
            return 100;
            break;
        case 4:
            return 60;
            break;
        default:
            return 34;
            break;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        CommodityViewController *commodityVC = [[CommodityViewController alloc] init];
        GoodsInfoModel * model = [_model.goodsData objectAtIndex:indexPath.row];
        commodityVC.strgoods_id = model.goodsId;
        [self.navigationController pushViewController:commodityVC animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView;
    switch (section) {
        case 3: {
            if (_model.goodsData.count > 3 && !_isMore) {
                headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 60)];
                headerView.backgroundColor = Color_bkg_lightGray;
                UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                moreBtn.frame = CGRectMake(self.view.width / 2 - 90, 0, 180, 30);
                moreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
                [moreBtn addTarget:self action:@selector(clickReloadMoreGoods) forControlEvents:UIControlEventTouchUpInside];
                [moreBtn setTitleColor:RGBCOLOR(255, 95, 5) forState:UIControlStateNormal];
                [moreBtn setTitle:@"点击加载更多商品" forState:UIControlStateNormal];
                [headerView addSubview:moreBtn];
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, 50, 20)];
                label.font = [UIFont systemFontOfSize:12];
                label.textColor = [UIColor colorFromHexCode:@"#757575"];
                label.text = @"订单金额";
                [headerView addSubview:label];
            } else {
                headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
                headerView.backgroundColor = Color_bkg_lightGray;
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 50, 20)];
                label.font = [UIFont systemFontOfSize:12];
                label.textColor = [UIColor colorFromHexCode:@"#757575"];
                label.text = @"商品金额";
                [headerView addSubview:label];
            }
        }
            break;
        default: {
            headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
            headerView.backgroundColor = Color_bkg_lightGray;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 50, 20)];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor colorFromHexCode:@"#757575"];
            switch (section) {
                case 0:
                    label.text = @"订单信息";
                    break;
                case 1:
                    label.text = @"收货信息";
                    break;
                case 2:
                    label.text = @"商品信息";
                    break;
                default:
                    label.text = @"申请退款";
                    break;
            }
            [headerView addSubview:label];
        }
            break;
            
    }
    return headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat sectionHeaderHeight = 30;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }else if (scrollView.contentOffset.y >= sectionHeaderHeight){
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

/**
 * 点击加载更多
 */
-(void)clickReloadMoreGoods {
        _isMore = YES;
        [_orderDetailTab reloadData];
}
#pragma mark - CCRequest
-(BOOL)startRequest:(NSInteger)requestID {
    if ([super startRequest:requestID]) {
//        获取订单详情
        if (requestID == 0) {
            [_client getOrderDetailsWithOrderId:[self.oderId intValue]];
        }
//        取消订单
        if (requestID == 1) {
            [_client cancelOrderWithOrderId:[self.oderId intValue]];
        }
//        确认收货
        if (requestID == 2) {
            [_client takeOverGoodsWithOrderId:[self.oderId intValue]];
        }
//        删除订单
        if (requestID == 3) {
            [_client deleteOrderWithOrderId:[self.oderId intValue]];
        }
//        支付
        if (requestID == 4) {
            [_client payOrderWithOrderNum:_model.orderNum];
        }
//        获取失效时间
        if (requestID == 5) {
            [_client getTheTimeOfLoseTime];
        }
//        取消申请退款
        if (requestID == 6) {
            [_client cancelRefundOrderWithOrderId:[self.oderId intValue]];
        }
//        再次购买
        if (requestID == 7) {
            [_client orderOfBuyAgainWithOrderId:[self.oderId intValue]];
        }
        return YES;
    }
    return NO;
}

-(BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result {
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 0) {
            NSDictionary *dataDic = [result getDictionaryForKey:@"data"];
            _model = [[OrderDtaileModel alloc] initWithDic:dataDic loseTime:_loseTime];
            [self getThePayStautsWithDictionary:dataDic];
            if (_isSuccessPay) {
                [self popViewControllerWithType];
            } else {
                _orderDetailTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 80) style:UITableViewStylePlain];
                _orderDetailTab.delegate = self;
                _orderDetailTab.dataSource = self;
                [self.view addSubview:_orderDetailTab];
                [self addFooterViewToView];
            }
        }
        if (sender.requestID == 1) {
            [self popViewControllerWithType];
//            [self.navigationController popViewControllerAnimated:YES];
        }
        if (sender.requestID == 2) {
            [self commtentAction];
        }
        if (sender.requestID == 3) {
            [self.navigationController popViewControllerAnimated:YES];
        } if (sender.requestID == 4) {
            NSDictionary *data = [result getDictionaryForKey:@"data"];
            if (data.count > 0) {
                SFAlipay * item = [SFAlipay objectWithDictionary:data];
                self.alipayOrder = [AlipayOrder orderWithPartner:item.partner seller:item.seller_id tradeNO:item.out_trade_no name:item.subject description:item.body amount:item.total_fee url:item.notify_url];
                NSString * orderInfo = _alipayOrder.description;
                NSString * signedStr = item.sign;
                signedStr = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)signedStr, NULL, CFSTR("￼=,!$&'()*+;@?\n\"<>#\t :/"), kCFStringEncodingUTF8));
                NSString * orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"", orderInfo, signedStr, @"RSA"];
                NSString * appScheme = @"iSHalipay";
                [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                    DeviceLogPrint(YES, @"alipay completed with result:\n%@", resultDic);
                    NSInteger resultStatus = [resultDic getIntegerValueForKey:@"resultStatus" defaultValue:0];
                    if (resultStatus == 9000) {
                        POST_NTF(NTF_Alipay_Suc, nil);
                        [CCAlertView showText:@"支付成功" life:1];
                        _isSuccessPay = YES;
                        [self startRequest:0];
//                        _orderStatus = @"3";
//                        [self popViewControllerWithType];
                    } else if (resultStatus == 6001) {
                        POST_NTF(NTF_Alipay_Cancel, nil);
                        [CCAlertView showText:@"支付取消" life:1];
                     } else {
                        [CCAlertView showText:@"支付失败" life:1];
                        POST_NTF(NTF_Alipay_Failed, nil);
                    }
                }];
            }
        }
        if (sender.requestID == 5) {
            NSDictionary *dataDic = [result getDictionaryForKey:@"data"];
            _loseTime = [dataDic getStringValueForKey:@"lose_time" defaultValue:nil];
            [self startRequest:0];
        }
        if (sender.requestID == 6) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        if (sender.requestID == 7) {
            NSDictionary *dataDic = [result getDictionaryForKey:@"data"];
            _oderId = nil;
            _oderId = [dataDic getStringValueForKey:@"order_id" defaultValue:nil];
            [self startRequest:0];
        }
        return YES;
    }
    return NO;
}

-(void)getThePayStautsWithDictionary:(NSDictionary *)dic {
//        支付方式
    NSString *payWay         = [dic getStringValueForKey:@"pay_way" defaultValue:nil];
//        支付状态
    NSString *payStatus      = [dic getStringValueForKey:@"pay_status" defaultValue:nil];
//        完成状态
    NSString *overStatus     = [dic getStringValueForKey:@"is_over" defaultValue:nil];
//        评论状态
    NSString *contentsStatus = [dic getStringValueForKey:@"is_contents" defaultValue:nil];
//        申请状态
    NSString *applyStatus    = [dic getStringValueForKey:@"apply_status" defaultValue:nil];
//        申请时间
    NSString *creatTime      = [dic getStringValueForKey:@"create_time" defaultValue:nil];
    if (([payWay intValue] == 1) && ([payStatus intValue] == 1) && ([overStatus intValue] == 2)) {
        NSDate *nowDate = [NSDate date];
        NSInteger tampTime = [nowDate timeIntervalSince1970];
        if (tampTime - [_loseTime integerValue] >= [creatTime integerValue]) {
            _orderStatus = @"0";
        } else {
            _orderStatus = @"1";
        }
    }
    if ([payWay intValue] == 2  && [overStatus intValue] == 2) {
        _orderStatus = @"2";
    }
    if (([payWay intValue] == 1 && [payStatus intValue] == 3) && [overStatus intValue] == 2) {
        _orderStatus = @"3";
    }
    if ([overStatus intValue] == 1 && [contentsStatus intValue] == 2) {
        _orderStatus = @"4";
    }
    if (([overStatus intValue] == 1 && [contentsStatus intValue] == 1) || ([overStatus intValue] == 1 && [applyStatus intValue] == 3)) {
        _orderStatus = @"5";
    }
    if ([applyStatus intValue] == 2 && [overStatus intValue] == 2 && [payStatus intValue] == 3) {
        _orderStatus = @"6";
    }
}

#pragma mark - Notifications
- (void)notificationAlipayDone:(NSNotification*)sender {
    [CCAlertView showText:@"支付成功" life:1];
    //    [self.navigationController popToRootViewControllerAnimated:YES];
    _isSuccessPay = YES;
    [self startRequest:0];
}
- (void)notificationAlipayFailed:(NSNotification*)sender {
    [CCAlertView showText:@"支付失败" life:1];
}
- (void)notificationAlipayCancel:(NSNotification*)sender {
    [CCAlertView showText:@"支付取消" life:1];
}


@end
