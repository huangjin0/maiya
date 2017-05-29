//
//  CollectionManagementViewController.m
//  IOSProject
//
//  Created by IOS004 on 15/6/8.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//
/**
 收藏管理
 */

#import "CollectionManagementViewController.h"
//#import "CommodityDetailsViewController.h"
#import "CommodityViewController.h"
#import "CollectionModel.h"
#import "CollectionCell.h"

#define statusH ([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.height)

@interface CollectionManagementViewController ()<UITableViewDataSource,UITableViewDelegate,CollectionCellDelegate>{
    UITableView * _tableview;
    //    收藏品数组
    NSMutableArray *_collectGoodsArr;
//    取消收藏的产品ID
    NSString * _selectedGoodsId;
//    加入购物车的产品信息
    NSDictionary *_goodsInfoDic;
    CollectionModel *_model;
}

@end

@implementation CollectionManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButtonToNavigation];
    self.navigationItem.title = @"我的收藏";
    _collectGoodsArr = [NSMutableArray array];
    [self startRequest:0];
}

/**
 tableview一共有多少组
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

/**
 返回行数，每组有多少行
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_collectGoodsArr count];
}

/**
 定制单元格内容、每行显示内容
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"identifier";
    CollectionModel *model = [_collectGoodsArr objectAtIndex:indexPath.row];
    CollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CollectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.item = model;
    return cell;
}

/**
 *  设置cell的height
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 95;
}

//cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CollectionModel *model = [_collectGoodsArr objectAtIndex:indexPath.row];
    CommodityViewController * commodity = [[CommodityViewController alloc] init];
    commodity.strgoods_id = model.goodsId;
    [self.navigationController pushViewController:commodity animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CollectionCellDelegate
//取消商品收藏
-(void)cancelCollectionWithcell:(CollectionCell *)cell {
    NSIndexPath *index = [_tableview indexPathForCell:cell];
    CollectionModel *model = [_collectGoodsArr objectAtIndex:index.row];
    _selectedGoodsId = model.goodsId;
    [_collectGoodsArr removeObjectAtIndex:index.row];
    [self startRequest:1];
}

//添加商品到购物车
-(void)addGoodsTocartWithcell:(CollectionCell *)cell {
    NSIndexPath *index = [_tableview indexPathForCell:cell];
    _model = [_collectGoodsArr objectAtIndex:index.row];
    if (_model.hasStock) {
        [self startRequest:2];
    } else {
        [CCAlertView showText:@"本品缺货，我们会尽快补充" life:1.0];
    }
    
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
            [_client getListOfCollectGoods];
        } else if (requestID == 1) {
            [_client cancelCollectGoodsWithGoodsId:[_selectedGoodsId intValue]];
        } else if (requestID == 2) {
            int goodsId = [_model.goodsId intValue];
            int sperId = [_model.specId intValue];
            int shopId = [_model.shopId intValue];
            NSString *goodName = _model.goodsTitle;
            NSString *goodsImg = _model.goodsImg;
            [_client userAddShopcartWithGoodsId:goodsId sperId:sperId shopId:shopId goodsName:goodName goodsImg:goodsImg quantity:1];
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
            NSArray *dataArr = [result objectForKey:@"data"];
            if (dataArr.count == 0) {
                [self emptyCollectionLoadView];
            } else {
                [self getCollectionGoodsWithArray:dataArr];
                _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
                _tableview.delegate = self;
                _tableview.dataSource = self;
                _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
                _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
                [self.view addSubview:_tableview];
            }
        }
        if (sender.requestID == 1) {
            if (_collectGoodsArr.count == 0) {
                [self.view removeAllSubviews];
                [self emptyCollectionLoadView];
            } else {
                [_tableview reloadData];
            }

        }
        if (sender.requestID == 2) {
            [self startRequest:3];
            [CCAlertView showText:@"成功加入购物车" life:1.0];
        }
        if (sender.requestID == 3) {
            NSDictionary *data = [result getDictionaryForKey:@"data"];
            NSString *cartNum = [data getStringValueForKey:@"cart_number" defaultValue:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cartNum" object:nil userInfo:@{@"cartNum":cartNum}];
        }

        return YES;
    }
    return NO;
}

/**
 * 获取收藏列表
 */
-(void)getCollectionGoodsWithArray:(NSArray *)arr {
    for (NSDictionary *dic in arr) {
        CollectionModel *model = [[CollectionModel alloc] initWithDic:dic];
        [_collectGoodsArr addObject:model];
    }
}

/**
 * 若收藏为空则加载
 */
-(void)emptyCollectionLoadView {
    [self.view removeAllSubviews];
    UIImageView *emptyCart = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width / 3, self.view.height / 3, self.view.width / 3, self.view.width / 3)];
    emptyCart.image = [UIImage imageNamed:@"gouwuche_ic_normal.png"];
    [self.view addSubview:emptyCart];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width / 2 - 95, self.view.height / 3 + self.view.width / 3 + 10, 190, 30)];
    label.text = @"你还没有收藏任何商品";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorFromHexCode:@"#999999"];
    [self.view addSubview:label];
}



@end
