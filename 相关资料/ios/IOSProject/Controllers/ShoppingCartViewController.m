//
//  ShoppingCartViewController.m
//  IOSProject
//
//  Created by IOS002 on 15/5/30.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoppingCartCell.h"
#import "ShoppingCartModel.h"
#import "SettlementViewController.h"
#import "CommodityDetailsViewController.h"
#import "SettleViewController.h"
#import "CartFooterView.h"
#import "CommodityViewController.h"
#import "LoginingViewController.h"
#import "PullTableView.h"
//#import "PersonalCenterViewController.h"
//#import "ShEngine.h"



@interface ShoppingCartViewController ()<UITableViewDataSource,UITableViewDelegate,ShoppingCartCellDelegate,footerViewDelegate,logInDelegate>{
    UITableView    * _myTableView;
    float            _allPrice;
    NSMutableArray * _infoArr;
    UIImageView    * _backgroundImage;
    ShoppingCartCell * _shoppingcart;
//    购物车列表数组
    NSMutableArray *_cartListArr;
//    选中商品数组
    NSMutableArray *_selectGoodsArr;
    //添加全选图片按钮
    
//    创建底部视图
    CartFooterView *_cartFooterView;
//    超出金额，超出将不再收取运费
    NSString *_maxPrice;
//    运费
    NSString *_shipfee;
//    选中的购物车id
    NSString *_cartId;
//    购物车的数量
    NSString *_cartNum;
    
//    是否第一次请求
    BOOL _isFristRequest;
    
    BOOL _isRequest;
}

@property(strong,nonatomic)UIButton * allSelectbtn;
@property(strong,nonatomic)UILabel  * allPricelabel;
@property(strong,nonatomic)UILabel  * allFreight;
@property (nonatomic,strong)UIButton *settlementBtn;

@end

//NSString * goodsidValue = @""; //传值goods_id到商品详情

@implementation ShoppingCartViewController


- (id)init{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = NO;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cartNumWithNotification:) name:@"cartNum" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refund) name:@"shenqing" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToMyOrderWithNotifiction:) name:@"backToMyOrderStatus" object:nil];
    return self;
}

-(void)backToMyOrderWithNotifiction:(NSNotification *)notification {
    self.tabBarController.selectedIndex = 2;
    NSNotification *notification1 = [NSNotification notificationWithName:@"myOrderStatus" object:nil userInfo:notification.userInfo];
    [[NSNotificationCenter defaultCenter] postNotification:notification1];
    
}

-(void)refund {
    self.tabBarController.selectedIndex = 2;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shenqingtuikuan" object:nil];
    
}

-(void)cartNumWithNotification:(NSNotification *)notification {
    NSString *str = [notification.userInfo getStringValueForKey:@"cartNum" defaultValue:nil];
    UIViewController *controller = [self.tabBarController.viewControllers objectAtIndex:3];
    if ([str integerValue] != 0) {
        controller.tabBarItem.badgeValue = str;
    } else {
        controller.tabBarItem.badgeValue = nil;
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    添加监听
    if ([IEngine engine].isSignedIn) {
            [self startRequest:0];
    } else {
        LoginingViewController *logInVC = [[LoginingViewController alloc] init];
        logInVC.isLogin = YES;
        logInVC.delegate = self;
        [self.navigationController pushViewController:logInVC animated:NO];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.view removeAllSubviews];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeSelect" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"购物车";
    if (self.type != 1) {
        [self addBackButtonToNavigation];
    }
    _cartListArr = [NSMutableArray array];
    _selectGoodsArr = [NSMutableArray array];
    //初始化数据
    _allPrice = 0.0;
    
}

#pragma mark - logInDelegate
-(void)backToPerCenVCWithInfo:(NSDictionary *)info {
    [self startRequest:0];
}

/**
 *创建表格，并设置代理
 */
-(void)setTableView {
    [self.view removeAllSubviews];
    if (self.type == 1) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, ScreenHeight - status1 - 60) style:UITableViewStylePlain];
        _cartFooterView = [[CartFooterView alloc] initWithFrame:CGRectMake(0, ScreenHeight - status1 - 60, self.view.frame.size.width, 60)];
    } else {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 60) style:UITableViewStylePlain];
        _cartFooterView = [[CartFooterView alloc] initWithFrame:CGRectMake(0, self.view.height - 60, self.view.frame.size.width, 60)];
    }
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_myTableView];
//    _cartFooterView.maxPrice.text = [NSString stringWithFormat:@"(订单满%.0f元可免运费)",[_maxPrice floatValue]];
    _cartFooterView.allFreight.text = [NSString stringWithFormat:@"￥0.00"];
    _cartFooterView.delegate = self;
    [self.view addSubview:_cartFooterView];
    [self totalPrice];
}

//返回单元格个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cartListArr.count;
}

/**
 *定制单元格内容
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify =  @"indentify";
    ShoppingCartCell *cell = [[ShoppingCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify row:indexPath.row];
    cell.delegate = self;
    //调用方法，给单元格赋值
    [cell addTheValue:[_cartListArr objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    return cell;
}

//返回单元格的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (IBAction)editButton:(id)sender {
    [_myTableView setEditing:!_myTableView animated:YES];
}

#pragma mark - 点击cell弹出商品详情界面
-(void)tapcellActionWith:(ShoppingCartCell *)cell {
    NSIndexPath *index = [_myTableView indexPathForCell:cell];
    CommodityViewController *commodityVC = [[CommodityViewController alloc] init];
    ShoppingCartModel *model = [_cartListArr objectAtIndex:index.row];
    commodityVC.strgoods_id = model.goodsID;
    [self.navigationController pushViewController:commodityVC animated:YES];
}

#pragma mark - 是否选中商品按钮点击代理事件
-(void)isSelectedGoodsWithRow:(NSInteger)row {
    /**
     *  判断当期是否为选中状态，如果选中状态点击则更改成未选中，如果未选中点击则更改成选中状态
     */
    ShoppingCartModel *model = [_cartListArr objectAtIndex:row];
    if (model.selectState)
    {
        model.selectState = NO;
    }
    else
    {
        model.selectState = YES;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    //刷新当前行
    [_myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self totalPrice];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectNum" object:nil];
}

#pragma mark -- 实现加减按钮点击代理事件
/**
 *  实现加减按钮点击代理事件
 *
 *  @param cell 当前单元格
 *  @param flag 按钮标识，11 为减按钮，12为加按钮
 */
-(void)Clickbtn:(UITableViewCell *)cell andFlag:(int)flag{
    NSIndexPath *index = [_myTableView indexPathForCell:cell];
    ShoppingCartModel *model = [_cartListArr objectAtIndex:index.row];
    switch (flag) {
        case 11:
        {
            //做减法
            //先获取到当期行数据源内容，改变数据源内容，刷新表格
            if (model.goodsNum > 1)
            {
                model.goodsNum --;
            }
        }
            break;
        case 12:
        {
            //做加法
            model.goodsNum ++;
            
        }
            break;
        default:
            break;
    }
    _cartId = model.cartId;
    _cartNum = [NSString stringWithFormat:@"%ld",(long)model.goodsNum];
    //刷新表格
    [_myTableView reloadData];
//    修改购物车数量
    [self startRequest:2];
    //计算总价
//    [self totalPrice];
}

/**
 * 删除购物车
 */
-(void)deleteGoods:(ShoppingCartCell *)cell {
    NSIndexPath *index = [_myTableView indexPathForCell:cell];
    ShoppingCartModel *model = [_cartListArr objectAtIndex:index.row];
    _cartId = model.cartId;
    [_cartListArr removeObjectAtIndex:index.row];
    [self totalPrice];
    [self startRequest:3];
}

#pragma mark - footerViewDelegate
/**
 * 结算按钮处理
 */
-(void)settlementOrderList {
    SettleViewController *settleVC = [[SettleViewController alloc] init];
    if (_type == 2) {
        settleVC.type = 2;
    }
    settleVC.goodsInfo = _selectGoodsArr;
    settleVC.totalPrice = _cartFooterView.allPricelabel.text;
    settleVC.shipfee = _shipfee;
    settleVC.maxPrice = _maxPrice;
    [self.navigationController pushViewController:settleVC animated:YES];
}

/**
 * 全选按钮处理事件
 */
-(void)allSelectedOrderListWithState:(BOOL)state {
    if (state) {
        for (ShoppingCartModel *shopCartModel in _cartListArr) {
            shopCartModel.selectState = NO;
        }
        [_myTableView reloadData];
        [self totalPrice];
    } else {
        for (ShoppingCartModel *shopCartModel in _cartListArr) {
            if (shopCartModel.hasGoods) {
                shopCartModel.selectState = YES;
            } else {
                shopCartModel.selectState = NO;
            }
        }
        [_myTableView reloadData];
        [self totalPrice];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectNum" object:nil];
}

#pragma mark -- 计算价格
-(void)totalPrice{
    int i = 0;
    int j = 0;
    [_selectGoodsArr removeAllObjects];
//     遍历整个数据源，然后判断如果是选中的商品，就计算价格（单价 * 商品数量）
    for (ShoppingCartModel *model in _cartListArr) {
        if (model.selectState) {
            _allPrice = _allPrice +model.goodsNum *[model.goodsPrice floatValue];
            i ++;
            [_selectGoodsArr addObject:model];
        }
        if (model.hasGoods) {
            j ++;
        }
    }
    if (j == i) {
        _cartFooterView.allSelectbtn.selected = YES;
    } else {
        _cartFooterView.allSelectbtn.selected = NO;
    }
//给总价文本赋值
//    _cartFooterView.allPricelabel.text = [NSString stringWithFormat:@"%.2f",_allPrice];
    if (_allPrice >= [_maxPrice floatValue] || _allPrice == 0) {
       _cartFooterView.allPricelabel.text = [NSString stringWithFormat:@"%.2f",_allPrice];
//        _cartFooterView.allFreight.text = [NSString stringWithFormat:@"￥0.00"];
        
    }else if (_allPrice < [_maxPrice floatValue]){
        _cartFooterView.allPricelabel.text = [NSString stringWithFormat:@"%.2f",_allPrice + [_shipfee floatValue]];
//        _cartFooterView.allFreight.text = [NSString stringWithFormat:@"￥%.2f",[_shipfee floatValue]];
    }
    NSString *setBtnTitleStr = [NSString stringWithFormat:@"结算(%d)",i];
    [_cartFooterView.settlementBtn setTitle:setBtnTitleStr forState:UIControlStateNormal];
    if (i == 0) {
        _cartFooterView.settlementBtn.backgroundColor = [UIColor colorFromHexCode:@"#dededd"];
        _cartFooterView.settlementBtn.userInteractionEnabled= NO;
    } else {
        _cartFooterView.settlementBtn.backgroundColor = RGBCOLOR(255, 95, 5);
        _cartFooterView.settlementBtn.userInteractionEnabled = YES;
    }
//每次算完要重置为0，因为每次的都是全部循环算一遍
    _allPrice = 0.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 若购物车为空则加载
 */
-(void)emptyShopCartLoadView {
    [self.view removeAllSubviews];
    UIImageView *emptyCart = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width / 3, self.view.height / 3, self.view.width / 3, self.view.width / 3)];
    emptyCart.image = [UIImage imageNamed:@"shopping_cart_146.08993576017px_1160212_easyicon.net"];
    [self.view addSubview:emptyCart];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width / 2 - 95, self.view.height / 3 + self.view.width / 3 + 10, 190, 30)];
    label.text = @"你的购物车内还没有任何商品";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorFromHexCode:@"#999999"];
    [self.view addSubview:label];
}

#pragma mark - CCRequest
-(BOOL)startRequest:(NSInteger)requestID {
    if ([super startRequest:requestID]) {
        if (requestID == 0) {
            [_client getListOfUserCart];
        } if (requestID == 1) {
            [_client getInformationOfShippingfee];
        } if (requestID == 2) {
            [_client editTheQuantityOfCartWithQuantity:[_cartNum intValue] cartId:_cartId];
        } if (requestID == 3) {
            [_client cancelShopcartWithCartId:_cartId];
        } if (requestID == 4) {
            [_client userGetCartNum];
        }
        return YES;
    }
    return NO;
}

-(BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result {
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 0) {
            _isRequest = YES;
            [_cartListArr removeAllObjects];
            [self getCartListDataWithArr:[result getArrayForKey:@"data"]];
            if ([_cartListArr count] == 0) {
                [self emptyShopCartLoadView];
            } else {
                [self startRequest:1];
            }
        } if (sender.requestID == 1) {
            NSDictionary *dic = [result getDictionaryForKey:@"data"];
            _maxPrice = [dic getStringValueForKey:@"expend1" defaultValue:nil];
            _shipfee  = [dic getStringValueForKey:@"value" defaultValue:nil];
            [self setTableView];
        } if (sender.requestID == 2) {
            [self totalPrice];
        } if (sender.requestID == 3) {
            [self startRequest:4];
            if (_cartListArr.count == 0) {
                [self emptyShopCartLoadView];
            } else {
                [_myTableView reloadData];
            }
        } if (sender.requestID == 4) {
            NSDictionary *data = [result getDictionaryForKey:@"data"];
            NSString *cartNum = [data getStringValueForKey:@"cart_number" defaultValue:nil];
            UIViewController *controller =  [self.tabBarController.viewControllers objectAtIndex:3];
            if ([cartNum intValue] != 0) {
                controller.tabBarItem.badgeValue = cartNum;
            } else {
                controller.tabBarItem.badgeValue = nil;
            }
        }
        return YES;
    }
    return NO;
}

/**
 * 解析购物车列表返回数据
 */
-(void)getCartListDataWithArr:(NSArray *)arr {
    [_cartListArr removeAllObjects];
    for (NSDictionary *dic in arr) {
        ShoppingCartModel *model = [[ShoppingCartModel alloc] initWithDict:dic];
        [_cartListArr addObject:model];
    }
}

@end
