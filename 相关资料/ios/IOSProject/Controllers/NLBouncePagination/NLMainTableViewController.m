//
//  CommodityDetailsViewController.m
//  IOSProject
//
//  Created by IOS002 on 15/6/6.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "NLMainTableViewController.h"
#import "NLPullUpRefreshView.h"
#import "ShoppingCartViewController.h"
#import "ClassificationOfGoodsViewController.h"
#import "LoginingViewController.h"
#import "CommodityViewController.h"

@interface NLMainTableViewController ()<logInDelegate,joinshoppingcartDelegate>{
    UIButton * _deleteBtn;   //加按钮
    UILabel  * _numCountLab; //显示数量
    UIButton * _addBtn;      //减按钮
    NSInteger _flag;

}

@property(nonatomic, strong)NLPullUpRefreshView *pullFreshView;
@property(nonatomic) NSInteger refreshCounter;

@end

@implementation NLMainTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
#ifdef __IPHONE_7_0
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#endif
    
    self.view.backgroundColor = [UIColor clearColor];
    
    if (self.tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        
        [self.view addSubview:self.tableView];
    }
//    _flag = 1;
    // TODO: edgeInsetTop 要放到上层去设置
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.isResponseToScroll = YES;
    
//    UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.height - 49, self.view.width, 49)];
//    imageview.backgroundColor = [UIColor redColor];
//    [self.view addSubview:imageview];
    
    UIButton * backgroundlab = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.height - 60, self.view.width, 60)];
    backgroundlab.backgroundColor = [UIColor whiteColor];
//    [backgroundlab addTarget:self action:@selector(joinShoppingCart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backgroundlab];
    UIImageView * imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 1)];
    imageline.backgroundColor = [UIColor colorFromHexCode:@"dededd"];
    [backgroundlab addSubview:imageline];
    
    UIButton * joinShoppingbtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width / 2 - 40, 15, 110, 30)];
    [joinShoppingbtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    joinShoppingbtn.titleLabel.font = [UIFont systemFontOfSize:14];
    joinShoppingbtn.backgroundColor = RGBCOLOR(255, 95, 5);
    [joinShoppingbtn addTarget:self action:@selector(joinShoppingCart) forControlEvents:UIControlEventTouchUpInside];
    [backgroundlab addSubview:joinShoppingbtn];
    

    UIButton * shoppingbtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width - 55, 15, 30, 30)];
    [shoppingbtn setImage:[UIImage imageNamed:@"iSH_CartTab"] forState:UIControlStateNormal];
    [shoppingbtn addTarget:self action:@selector(returnShoppingCart) forControlEvents:UIControlEventTouchUpInside];
    [backgroundlab addSubview:shoppingbtn];
    
    //减按钮
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn.frame = CGRectMake(15, 15, 30, 30);
    [_deleteBtn setImage:[UIImage imageNamed:@"cut.png"] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _deleteBtn.tag = 11;
    [backgroundlab addSubview:_deleteBtn];
    
    //购买商品的数量
    _flag = 1;
    _numCountLab = [[UILabel alloc] initWithFrame:CGRectMake(45, 15, 30, 30)];
    _numCountLab.text = [NSString stringWithFormat:@"%ld",(long)_flag];
    _numCountLab.textAlignment = NSTextAlignmentCenter;

    [backgroundlab addSubview:_numCountLab];
    
    //加按钮
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(75, 15, 30, 30);
    [_addBtn setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _addBtn.tag = 12;
    [backgroundlab addSubview:_addBtn];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self addRefreshView];
    [self addSubPage];
    
    self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width, self.tableView.contentSize.height + 0.f);
}

- (void)addRefreshView {
    if (self.pullFreshView == nil) {
        float originY = self.tableView.contentSize.height + 64;
        self.pullFreshView = [[NLPullUpRefreshView alloc]initWithFrame:CGRectMake(0, originY, self.view.frame.size.width, 0.f)];
        self.pullFreshView.backgroundColor = [UIColor whiteColor];
    }
    
    if (!self.pullFreshView.superview) {
        [self.pullFreshView setupWithOwner:self.tableView delegate:self];
    }
}

- (void)addSubPage
{
    if (!self.subTableViewController) {
        return;
    }
    
    self.subTableViewController.mainTableViewController = self;
    self.subTableViewController.tableView.frame = CGRectMake(0, self.tableView.contentSize.height + 64, self.view.frame.size.width, self.view.frame.size.height);
    [self.tableView addSubview:self.subTableViewController.tableView];
}



- (void)pullUpRefreshDidFinish
{
    if (!self.refreshCounter) {
        self.refreshCounter = 0;
    }
    // 上拉分页动画
    [UIView animateWithDuration:0.3 animations:^{
        //-50上拉无遮挡；
        self.tableView.contentInset = UIEdgeInsetsMake(-self.tableView.contentSize.height - 20, 0, 0, 0);
    }];
    self.isResponseToScroll = NO;
    self.tableView.bounces = NO;
    [self.pullFreshView stopLoading];
    self.pullFreshView.hidden = YES;
}

- (void)pullDownRefreshDidFinish
{
    [self.subTableViewController.pullFreshView stopLoading];
    
    [UIView animateWithDuration:0.3 animations:^{
    //俩页重复显示页面设置20不在重复显示
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    // maintable重绘之后，contentsize要重新加上offset
    self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width, self.tableView.contentSize.height + 100.f);
    }];
    self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, self.tableView.contentOffset.y + 100.f - 100);
    self.tableView.bounces = YES;
    self.isResponseToScroll = YES;
    self.pullFreshView.hidden = NO;
    
    
    self.subTableViewController.tableView.frame = CGRectMake(0, self.tableView.contentSize.height + 64, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.isResponseToScroll) {
        [self.pullFreshView scrollViewWillBeginDragging:scrollView];
    } else {
        [self.subTableViewController.pullFreshView scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.isResponseToScroll) {
        [self.pullFreshView scrollViewDidScroll:scrollView];
    } else {
        [self.subTableViewController.pullFreshView scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.isResponseToScroll) {
        [self.pullFreshView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    } else {
        [self.subTableViewController.pullFreshView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.isResponseToScroll) {
        [self.pullFreshView scrollViewDidEndDecelerating:scrollView];
    } else {
    }
}

- (void)addBtnAction{
    if (_flag >= 1) {
        _flag ++;
        _numCountLab.text = [NSString stringWithFormat:@"%ld",(long)_flag];
    }
        [self.delegate valueOfQuantity:_numCountLab.text];
    NSLog(@"%@",_numCountLab.text);
}
- (void)deleteBtnAction{
    if (_flag > 1) {
        _flag --;
        _numCountLab.text = [NSString stringWithFormat:@"%ld",(long)_flag];
    }
        [self.delegate valueOfQuantity:_numCountLab.text];
    NSLog(@"%@",_numCountLab.text);
}
//跳转到购物车
- (void)returnShoppingCart{
    if ([IEngine engine].isSignedIn) {
        ShoppingCartViewController * shoppingcart = [[ShoppingCartViewController alloc] init];
        [self.navigationController pushViewController:shoppingcart animated:YES];
    }else{
        [CCAlertView showText:@"请登录" life:2.0];
        LoginingViewController *logingVC = [[LoginingViewController alloc] init];
        logingVC.delegate = self;
        [self.navigationController pushViewController:logingVC animated:YES];
    }

}

//加入购物车
- (void)joinShoppingCart{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(joinShoppingCartDetail)]) {
        [_delegate joinShoppingCartDetail];
    }
//    [self.delegate valueOfQuantity:_numCountLab.text];
}
- (void)backToPerCenVCWithInfo:(NSDictionary *)info{
}
- (void)joinShoppingCartDetail{
}
- (void)valueOfQuantity:(NSString *)quantity{
}
@end
