//
//  AllOrdersViewController.m
//  IOSProject
//
//  Created by IOS004 on 15/6/9.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//
//我的订单

#import "AllOrdersViewController.h"
#import "OrderDetailsViewController.h"
#import "MyOrderCell.h"
#import "OderModel.h"
#import "PullTableView.h"
//#import "HXLRefreshTableView.h"
#import "EvaluateViewController.h"
#import "AlipayConfig.h"

#define statusH ([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.height)
@interface AllOrdersViewController ()<UITableViewDataSource,UITableViewDelegate,everyStautsDelegate,PullTableViewDelegate,UIAlertViewDelegate,backToMyOrderDelegate>{
    PullTableView * _tableview;
    //    全部的
    UIButton *_allOrder;
    //    待付款
    UIButton *_obliOrder;
    //    待收货
    UIButton *_waitGoods;
    //    待评价
    UIButton *_waitAppraise;
    //    已完成
    UIButton *_finishOrder;
    //    退款中
    UIButton *_refundOrder;
    
    UIView *_lineBackView;
    //    订单数组
    NSMutableArray *_orderListArr;
//    订单Id
    NSString *_orderId;
//    订单号
    NSString *_orderNum;
//    请求订单页数
    int _applyPage;
//    订单总页数
    NSString *_allPageNum;
    NSIndexPath *_selectIndex;
    NSArray *_selectGoodData;
//    失效时间
    NSString *_loseTime;
//    是否第一次发送请求
    BOOL _isfirstRequest;
//    是否为刷新
    BOOL _isRefresh;
//    订单为空页面
    UIView *_emptyView;
}
@property (strong, nonatomic) AlipayOrder * alipayOrder;

@end

@implementation AllOrdersViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refund) name:@"shenqing" object:nil];
    [self addOderStatesToView];
    [self startRequest:10];
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _applyPage = 1;
    // Do any additional setup after loading the view.
    [self addBackButtonToNavigation];
    _orderListArr = [NSMutableArray array];
    self.navigationItem.title = @"我的订单";
    
    _tableview = [[PullTableView alloc] initWithFrame:CGRectMake(0, 50, self.view.width, self.view.height - statusH - 50) style:UITableViewStylePlain];
    _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.pullDelegate = self;
    [self.view addSubview:_tableview];
    [self addEmptyView];
}

/**
 * 添加订单为空页面
 */
-(void)addEmptyView{
    _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, self.view.width, self.view.height - statusH - 50)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width / 2 - 50, 100, 100, 100)];
    imageView.image = [UIImage imageNamed:@"dingdan_pic"];
    [_emptyView addSubview:imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 210, self.view.width, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"暂无订单";
    label.textColor = [UIColor colorFromHexCode:@"#dededd"];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    [_emptyView addSubview:label];
    [self.view addSubview:_emptyView];
    _emptyView.hidden = YES;
}


/*
 **添加订单状态背景
 */
-(void)addOderStatesToView {
    CGFloat viewW = self.view.width;
    NSArray *btnTitleArr = @[@"全部的",@"待付款",@"待收货",@"待评价",@"已完成",@"退款中"];
    UIView *oderStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewW, 50)];
    oderStateView.backgroundColor = [UIColor whiteColor];
    
    _allOrder = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, viewW / 6, 50)];
    _allOrder.tag = 0;
    [_allOrder setTitle:[btnTitleArr objectAtIndex:0] forState:UIControlStateNormal];
    _allOrder.titleLabel.font = [UIFont systemFontOfSize:14];
    [_allOrder addTarget:self action:@selector(oderStateBtnRequestWithSender:) forControlEvents:UIControlEventTouchUpInside];
    [_allOrder setTitleColor: [UIColor colorFromHexCode:@"#999999"] forState:UIControlStateNormal];
    [_allOrder setTitleColor: [UIColor colorFromHexCode:@"#333333"] forState:UIControlStateSelected];
    [oderStateView addSubview:_allOrder];
    
    _obliOrder = [[UIButton alloc] initWithFrame:CGRectMake(viewW / 6, 0, viewW / 6, 50)];
    _obliOrder.tag = 1;
    [_obliOrder setTitle:[btnTitleArr objectAtIndex:1] forState:UIControlStateNormal];
    _obliOrder.titleLabel.font = [UIFont systemFontOfSize:14];
    [_obliOrder addTarget:self action:@selector(oderStateBtnRequestWithSender:) forControlEvents:UIControlEventTouchUpInside];
    [_obliOrder setTitleColor: [UIColor colorFromHexCode:@"#999999"] forState:UIControlStateNormal];
    [_obliOrder setTitleColor: [UIColor colorFromHexCode:@"#333333"] forState:UIControlStateSelected];
    [oderStateView addSubview:_obliOrder];
    
    _waitGoods = [[UIButton alloc] initWithFrame:CGRectMake(viewW / 3, 0, viewW / 6, 50)];
    _waitGoods.tag = 2;
    [_waitGoods setTitle:[btnTitleArr objectAtIndex:2] forState:UIControlStateNormal];
    _waitGoods.titleLabel.font = [UIFont systemFontOfSize:14];
    [_waitGoods addTarget:self action:@selector(oderStateBtnRequestWithSender:) forControlEvents:UIControlEventTouchUpInside];
    [_waitGoods setTitleColor: [UIColor colorFromHexCode:@"#999999"] forState:UIControlStateNormal];
    [_waitGoods setTitleColor: [UIColor colorFromHexCode:@"#333333"] forState:UIControlStateSelected];
    [oderStateView addSubview:_waitGoods];
    
    _waitAppraise = [[UIButton alloc] initWithFrame:CGRectMake(viewW / 2, 0, viewW / 6, 50)];
    _waitAppraise.tag = 3;
    [_waitAppraise setTitle:[btnTitleArr objectAtIndex:3] forState:UIControlStateNormal];
    _waitAppraise.titleLabel.font = [UIFont systemFontOfSize:14];
    [_waitAppraise addTarget:self action:@selector(oderStateBtnRequestWithSender:) forControlEvents:UIControlEventTouchUpInside];
    [_waitAppraise setTitleColor: [UIColor colorFromHexCode:@"#999999"] forState:UIControlStateNormal];
    [_waitAppraise setTitleColor: [UIColor colorFromHexCode:@"#333333"] forState:UIControlStateSelected];
    [oderStateView addSubview:_waitAppraise];
    
    _finishOrder = [[UIButton alloc] initWithFrame:CGRectMake(viewW / 3 * 2, 0, viewW / 6, 50)];
    _finishOrder.tag = 4;
    [_finishOrder setTitle:[btnTitleArr objectAtIndex:4] forState:UIControlStateNormal];
    _finishOrder.titleLabel.font = [UIFont systemFontOfSize:14];
    [_finishOrder addTarget:self action:@selector(oderStateBtnRequestWithSender:) forControlEvents:UIControlEventTouchUpInside];
    [_finishOrder setTitleColor: [UIColor colorFromHexCode:@"#999999"] forState:UIControlStateNormal];
    [_finishOrder setTitleColor: [UIColor colorFromHexCode:@"#333333"] forState:UIControlStateSelected];
    [oderStateView addSubview:_finishOrder];
    
    _refundOrder = [[UIButton alloc] initWithFrame:CGRectMake(viewW / 6 * 5, 0, viewW / 6, 50)];
    _refundOrder.tag = 5;
    [_refundOrder setTitle:[btnTitleArr objectAtIndex:5] forState:UIControlStateNormal];
    _refundOrder.titleLabel.font = [UIFont systemFontOfSize:14];
    [_refundOrder addTarget:self action:@selector(oderStateBtnRequestWithSender:) forControlEvents:UIControlEventTouchUpInside];
    [_refundOrder setTitleColor: [UIColor colorFromHexCode:@"#999999"] forState:UIControlStateNormal];
    [_refundOrder setTitleColor: [UIColor colorFromHexCode:@"#333333"] forState:UIControlStateSelected];
    [oderStateView addSubview:_refundOrder];
    _lineBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 48, viewW / 6, 2)];
    _lineBackView.backgroundColor = RGBCOLOR(255, 95, 5);
    [self.view addSubview:oderStateView];
}

/**
 * 点击不同状态
 */
-(void)oderStateBtnRequestWithSender:(UIButton *)sender {
    [_orderListArr removeAllObjects];
    _emptyView.hidden = YES;
    _applyPage = 1;
    _isfirstRequest = NO;
    switch (sender.tag) {
        case 0:
            _allOrder.selected = YES;
            [_allOrder addSubview:_lineBackView];
            _obliOrder.selected = NO;
            _waitGoods.selected = NO;
            _waitAppraise.selected = NO;
            _finishOrder.selected = NO;
            _refundOrder.selected = NO;
            self.selectedTag = @"0";
            [self startRequest:0];
            break;
        case 1:
            _obliOrder.selected = YES;
            [_obliOrder addSubview:_lineBackView];
            _allOrder.selected = NO;
            _waitGoods.selected = NO;
            _waitAppraise.selected = NO;
            _finishOrder.selected = NO;
            _refundOrder.selected = NO;
            self.selectedTag = @"1";
            [self startRequest:1];
            break;
        case 2:
            _waitGoods.selected = YES;
            [_waitGoods addSubview:_lineBackView];
            _allOrder.selected = NO;
            _obliOrder.selected = NO;
            _waitAppraise.selected = NO;
            _finishOrder.selected = NO;
            _refundOrder.selected = NO;
            self.selectedTag = @"2";
            [self startRequest:2];
            break;
        case 3:
            _waitAppraise.selected = YES;
            [_waitAppraise addSubview:_lineBackView];
            _allOrder.selected = NO;
            _obliOrder.selected = NO;
            _waitGoods.selected = NO;
            _finishOrder.selected = NO;
            _refundOrder.selected = NO;
            self.selectedTag = @"3";
            [self startRequest:3];
            break;
        case 4:
            _finishOrder.selected = YES;
            [_finishOrder addSubview:_lineBackView];
            _allOrder.selected = NO;
            _obliOrder.selected = NO;
            _waitGoods.selected = NO;
            _waitAppraise.selected = NO;
            _refundOrder.selected = NO;
            self.selectedTag = @"4";
            [self startRequest:4];
            break;
        default:
            _refundOrder.selected = YES;
            [_refundOrder addSubview:_lineBackView];
            _allOrder.selected = NO;
            _obliOrder.selected = NO;
            _waitGoods.selected = NO;
            _waitAppraise.selected = NO;
            _finishOrder.selected = NO;
            self.selectedTag = @"5";
            [self startRequest:5];
            break;
    }
}

//设置section数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _orderListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"identifier";
        MyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
        cell = [[MyOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    OderModel *model = [_orderListArr objectAtIndex:indexPath.row];
    cell.item = model;
    return cell;
}

//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView {
    _applyPage = 1;
    _isRefresh = YES;
    switch ([self.selectedTag intValue]) {
        case 0:
            [self startRequest:0];
            break;
        case 1:
            [self startRequest:1];
            break;
        case 2:
            [self startRequest:2];
            break;
        case 3:
            [self startRequest:3];
            break;
        case 4:
            [self startRequest:4];
            break;
        case 5:
            [self startRequest:5];
            break;
        default:
            break;
    }

}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView {
    _applyPage++;
    if (_applyPage <= [_allPageNum integerValue]) {
        switch ([self.selectedTag intValue]) {
            case 0:
                [self startRequest:0];
                break;
            case 1:
                [self startRequest:1];
                break;
            case 2:
                [self startRequest:2];
                break;
            case 3:
                [self startRequest:3];
                break;
            case 4:
                [self startRequest:4];
                break;
            case 5:
                [self startRequest:5];
                break;
            default:
                break;
        }
    } else {
        [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:1.0f];
    }
}

- (void) loadMoreDataToTable
{
    _tableview.pullTableIsLoadingMore = NO;
    [CCAlertView showText:@"没有更多内容" life:1];
}


#pragma mark - EveryStatusDelegate 

/**
 * 点击商品进入订单详情
 */

-(void)tapToDetaileOrderWithCell:(MyOrderCell *)cell {
    NSIndexPath *indexPath = [_tableview indexPathForCell:cell];
    OderModel *model = [_orderListArr objectAtIndex:indexPath.row];
    OrderDetailsViewController * order = [[OrderDetailsViewController alloc] init];
    order.delegate = self;
    order.oderId = model.orderId;
    [self.navigationController pushViewController:order animated:YES];
}

#pragma mark - BackToMyOrderDelegate
-(void)backToMyOrderWithOrderId:(NSString *)orderId sender:(NSInteger)sender {
        _orderId = orderId;
        [self startRequest:9];
}

-(void)backToMyOrderWithStatus:(NSString *)status {
     _applyPage = 1;
    switch ([status integerValue]) {
        case 0:
        case 1:
            _selectedTag = @"1";
            break;
        case 2:
        case 3:
            _selectedTag = @"2";
            break;
        case 4:
            _selectedTag = @"3";
            break;
        case 5:
            _selectedTag = @"4";
            break;
        case 6:
            _selectedTag = @"5";
            break;
        default:
            _selectedTag = @"0";
            break;
    }
}

-(void)backTomyOrderToPayWithOrderId:(NSString *)orderId {
//    OrderDetailsViewController *orderDtailVC = [[OrderDetailsViewController alloc] init];
//    orderDtailVC.oderId = orderId;
//    orderDtailVC.delegate = self;
//    [self.navigationController pushViewController:orderDtailVC animated:YES];
}

-(void)backToRefundOrder {
    [self oderStateBtnRequestWithSender:_refundOrder];
}

/**
 * 弹出评价界面
 */
-(void)pushEvaluateViewController {
    EvaluateViewController *evaluVC = [[EvaluateViewController alloc] init];
    evaluVC.orderId = _orderId;
    evaluVC.goodsData = _selectGoodData;
    [self.navigationController pushViewController:evaluVC animated:YES];
}

-(void)everyStautsBtnWithCell:(MyOrderCell *)cell status:(NSInteger)status {
    NSIndexPath *index = [_tableview indexPathForCell:cell];
    OderModel *model = [_orderListArr objectAtIndex:index.row];
    _orderId = model.orderId;
    _orderNum = model.orderNum;
    _selectGoodData = model.goodsInfo;
    if (status == 0) {
        [self startRequest:11];
        [_orderListArr removeObjectAtIndex:index.row];
        [_tableview reloadData];
        if (_orderListArr.count == 0) {
            _emptyView.hidden = NO;
        }
    } else if (status == 1) {
        [self startRequest:8];
    } else if (status == 2) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认收货" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alertView.tag = 1;
        [alertView show];
    } else if (status == 3) {
        [self pushEvaluateViewController];
    } else if (status == 7) {
        OrderDetailsViewController * order = [[OrderDetailsViewController alloc] init];
        order.delegate = self;
        order.oderId = model.orderId;
        [self.navigationController pushViewController:order animated:YES];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定再次购物，我们将按照原订单的内容进行配送" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alertView.tag = 2;
        [alertView show];
//        [self startRequest:9];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        if (alertView.tag == 1) {
            [self startRequest:7];
        } else {
            [self startRequest:9];
        }
        
//        [self pushEvaluateViewController];
    }
}

/**
 * 删除订单
 */
-(void)deleteOrderWithCell:(MyOrderCell *)cell {
    NSIndexPath *indexPath = [_tableview indexPathForCell:cell];
    OderModel *model = [_orderListArr objectAtIndex:indexPath.row];
    _orderId = model.orderId;
    [_orderListArr removeObjectAtIndex:indexPath.row];
    [self startRequest:6];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CCRequest
-(BOOL)startRequest:(NSInteger)requestID {
    if ([super startRequest:requestID]) {
        if (requestID == 0) {
            [_client getUserAllOrderListWithPage:_applyPage];
        }
        if (requestID == 1) {
            [_client getUserNoPayOrderListWithPage:_applyPage];
        }
        if (requestID == 2) {
            [_client getUserNoGetOrderListWithPage:_applyPage];
        }
        if (requestID == 3) {
            [_client getUserNoContentOrderListWithPage:_applyPage];
        }
        if (requestID == 4) {
            [_client getUserIsOverOrderListWithPage:_applyPage];
        }
        if (requestID == 5) {
             [_client getUserrefundOrderListWithPage:_applyPage];
        }
        if (requestID == 6) {
            [_client deleteOrderWithOrderId:[_orderId intValue]];
        }
        if (requestID == 7) {
            [_client takeOverGoodsWithOrderId:[_orderId intValue]];
        }
        if (requestID == 8) {
            [_client payOrderWithOrderNum:_orderNum];
        }
        if (requestID == 9) {
            [_client orderOfBuyAgainWithOrderId:[_orderId intValue]];
        }
        if (requestID == 10) {
            [_client getTheTimeOfLoseTime];
        }
        if (requestID == 11) {
            [_client cancelOrderWithOrderId:[_orderId intValue]];
        }
        return YES;
    }
    return NO;
}

-(BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result {
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 6) {
            [_tableview reloadData];
        } else if (sender.requestID == 7) {
            [self pushEvaluateViewController];
        } else if (sender.requestID == 8) {
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
                        OrderDetailsViewController *orderDtailVC = [[OrderDetailsViewController alloc] init];
                        orderDtailVC.oderId = _orderId;
                        [self.navigationController pushViewController:orderDtailVC animated:YES];
                    } else if (resultStatus == 6001) {
                        POST_NTF(NTF_Alipay_Cancel, nil);
                        [CCAlertView showText:@"支付取消" life:1];
                    } else {
                        [CCAlertView showText:@"支付失败" life:1];
                        POST_NTF(NTF_Alipay_Failed, nil);
                    }
                }];
            }
        } else if (sender.requestID == 9) {
            NSDictionary *dataDic = [result getDictionaryForKey:@"data"];
            OrderDetailsViewController *orderDetailVC = [[OrderDetailsViewController alloc] init];
            orderDetailVC.delegate = self;
            orderDetailVC.oderId = [dataDic getStringValueForKey:@"order_id" defaultValue:nil];
            [self.navigationController pushViewController:orderDetailVC animated:YES];
        } else if (sender.requestID == 10) {
            NSDictionary *dataDic = [result getDictionaryForKey:@"data"];
            _loseTime = [dataDic getStringValueForKey:@"lose_time" defaultValue:nil];
            switch (self.selectedTag.intValue) {
                case 0:
                    [self oderStateBtnRequestWithSender:_allOrder];
                    break;
                case 1:
                    [self oderStateBtnRequestWithSender:_obliOrder];
                    break;
                case 2:
                    [self oderStateBtnRequestWithSender:_waitGoods];
                    break;
                case 3:
                    [self oderStateBtnRequestWithSender:_waitAppraise];
                    break;
                case 4:
                    [self oderStateBtnRequestWithSender:_finishOrder];
                    break;
                default:
                    [self oderStateBtnRequestWithSender:_refundOrder];
                    break;
            }
        } else if (sender.requestID == 11) {
//            [self startRequest:1];
        }
        else {
            NSArray *dataArr = [result objectForKey:@"data"];
            if (!_isfirstRequest) {
                _isfirstRequest = YES;
                NSDictionary *paging = [result getDictionaryForKey:@"paging"];
                NSString *tatalcout = [paging getStringValueForKey:@"totalcount" defaultValue:nil];
                NSString *numOfPag = [paging getStringValueForKey:@"numberofpage" defaultValue:nil];
                NSInteger pageCount = [tatalcout integerValue] / [numOfPag integerValue];
                NSInteger cout = [tatalcout integerValue] % [numOfPag integerValue];
                if (cout == 0) {
                    _allPageNum = [NSString stringWithFormat:@"%ld",(long)pageCount];
                } else {
                    _allPageNum = [NSString stringWithFormat:@"%ld",(long)pageCount + 1];
                }
            }
            if (_isRefresh) {
                [_orderListArr removeAllObjects];
                _isRefresh = NO;
            }
            [self getOrderListInfoWithArr:dataArr];
            _tableview.pullTableIsRefreshing = NO;
            _tableview.pullTableIsLoadingMore = NO;
            [_tableview reloadData];
        }
        return YES;
    }
    return NO;
}

/**
 * 获取订单列表信息
 */
-(void)getOrderListInfoWithArr:(NSArray *)arr {
    for (NSDictionary *dic in arr) {
        OderModel *model = [[OderModel alloc] initWithDic:dic loseTime:_loseTime];
        [_orderListArr addObject:model];
    }
    if (_orderListArr.count == 0) {
        _emptyView.hidden = NO;
    }
}

@end
