//
//  RefundViewController.m
//  IOSProject
//
//  Created by IOS002 on 15/7/28.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "RefundViewController.h"
#import "OrderInfoCell.h"
#import "ConsigeenCell.h"
#import "GoodsInfoCell.h"
#import "GoldCell.h"
#import "OrderTextCell.h"
#import "RefundTableViewCell.h"
#define statusH ([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height)
@interface RefundViewController () <UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
//    订单详情界面
    UITableView *_tableview;
//    订单信息条目
    NSArray *_orderInfo;
    BOOL _isfirstloadGoods;
    BOOL _isMore;
}

@end

@implementation RefundViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTheKeyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTheKeyBoardWillHiden) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackButtonToNavigation];
    self.navigationItem.title = @"订单详情";
    _orderInfo = @[@"订单编号",@"下单时间",@"支付方式",@"订单状态",@"派送方式"];
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, self.view.height - 80 - statusH)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    [self addFooterViewToView];
    // Do any additional setup after loading the view.
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
    [self.view endEditing:YES];
}



/**
 * 添加尾部视图
 */
-(void)addFooterViewToView {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - statusH - 80, ViewWidth, 80)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(ViewWidth - 100, 20, 80, 40)];
    button.backgroundColor = RGBCOLOR(255, 95, 5);
    [button addTarget:self action:@selector(refundOrder) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [backView addSubview:button];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 申请退款
 */
-(void)refundOrder {
    [self startRequest:0];
}

#pragma mark - UITableViewDelegate,UItableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 5;
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
        case 3:
            return 3;
            break;
        default:
            return 1;
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
        case 0: {
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
        case 1: {
            ConsigeenCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
            if (!cell) {
                cell = [[ConsigeenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
            }
            cell.item = _model;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            //            break;
        case 2: {
            GoodsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier3];
            if (!cell) {
                cell = [[GoodsInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier3];
            }
            GoodsInfoModel *goodsInfo = [_model.goodsData objectAtIndex:indexPath.row];
            cell.item = goodsInfo;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            //            break;
        case 3: {
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
        default:
        {
            RefundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier5];
            if (!cell) {
                cell = [[RefundTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier5];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
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
        case 3:
            return 34;
            break;
        default:
            return 60;
            break;
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
    _isfirstloadGoods = YES;
    _isMore = YES;
    [_tableview reloadData];
}

#pragma mark - CCRequest
-(BOOL)startRequest:(NSInteger)requestID {
    if ([super startRequest:requestID]) {
        if (requestID == 0) {
            RefundTableViewCell *cell = (RefundTableViewCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4]];
            [_client refundOrderWithOrderId:[_model.orderId intValue] content:cell.refundTextView.text];
        }
        return YES;
    }
    return NO;
}
-(BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result {
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 0) {
            [CCAlertView showText:@"申请退款请等待" life:1.0];
            if (_type == 1) {
                [self.navigationController popToRootViewControllerAnimated:NO];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"shenqing" object:nil];
            } else {
                if (_delegate != nil && [_delegate respondsToSelector:@selector(overRefundWithPopView)]) {
                    [_delegate overRefundWithPopView];
                    [self.navigationController popViewControllerAnimated:NO];
                }
            }
            
        }
        return YES;
    }
    return NO;
}

/**
 *  键盘弹出
 */
-(void)handleTheKeyBoardWillShow:(NSNotification *)notification {
    NSValue *keyBoardRectAsObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [keyBoardRectAsObject CGRectValue];
    CGFloat keyBoardHight = keyboardRect.size.height;
    [_tableview setFrame:CGRectMake(0, 0, ViewWidth, self.view.height - keyBoardHight)];
    [_tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    
}

/**
 * 键盘隐藏
 */
-(void)handleTheKeyBoardWillHiden {
//    [UIView beginAnimations:@"Curl" context:nil];
//    [UIView setAnimationDuration:0.50];
//    [UIView setAnimationDelegate:self];
    [_tableview setFrame:CGRectMake(0, 0, ViewWidth, self.view.height - 80)];
//    [UIView commitAnimations];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
