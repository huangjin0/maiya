//
//  BannerAndConnectionImageViewController.m
//  IOSProject
//
//  Created by IOS004 on 15/6/16.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//
//Banner图和商品链接详情

#import "BannerAndConnectionImageViewController.h"
#import "ShoppingCartViewController.h"
#import "MainPageViewController.h"
#import "CollectionViewCell.h"
//#import "BannerCollectionScrollView.h"
#import "BannerCollectionModel.h"
#import "CommodityViewController.h"
#import "HomeViewController.h"
#import "ADView.h"
#import "LoginingViewController.h"
#import "BannerCollectionShoppingCartModel.h"
#import "AdScrollView.h"
#import "AdDataModel.h"

#import "JXBAdPageView.h"

@interface BannerAndConnectionImageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,joinshoppingcratDelegate,ADViewDelegate,logInDelegate>{
//    BannerCollectionScrollView * _scrollView;
    NSMutableArray * _arrBannerDetail;
    NSInteger        _ad_idValue;   //参数ad_id
    NSMutableArray * _arrName1;     //参数名称
    NSMutableArray * _arrImagePath; //参数图片
    NSMutableArray * _arrPrice;     //参数新价格
    NSMutableArray * _arrOld;       //参数旧价格
    NSMutableArray * _arrgoods_id;  //参数goods_id
    NSMutableArray * _arrspec;      //参数spec_id
    NSMutableArray * _arrshop;      //参数shop_id
    NSArray        * _arrCount;     //参数count，collectioncell的数量
    NSMutableDictionary * _dic;
    //加入购物车所需参数
    NSInteger   _goods_id;     //产品id
    NSInteger   _spec_id;      //规格id
    NSInteger   _shop_id;      //商品id
    NSString  * _goods_name;   //产品名
    NSString  * _goods_image;  //产品图片
    NSInteger   _quantity;     //数量
    
    NSString  * _strName;      //获取传值参数name
    NSString  * _strImage;     //获取传值参数image
    NSString  * _strShop;      //获取传值参数shop_id
    NSString  * _strSpec;      //获取传值参数spec_id
    NSString  * _strgoodsid;   //获取传值参数goods_id
    //加入购物车
    NSMutableArray                    * _arrJoinsc;   //循环数组取值
    BannerCollectionShoppingCartModel * _bannermodel; //model
    NSMutableArray                    * _arrbanner;   //photos数组取值
    NSString                          * _bannerstr;   //获取photos字符串
}
//@property (strong, nonatomic)TAPageControl * pageControl;
@property (nonatomic, strong)JXBAdPageView * adView;
@end

@implementation BannerAndConnectionImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _shouldHideNavigationBar = YES;
    _arrJoinsc = [NSMutableArray array];
    _arrbanner = [NSMutableArray array];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.headerReferenceSize = CGSizeMake(self.view.width, self.view.width - 30);//头部
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) collectionViewLayout:flowLayout];
    
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];

    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //注册cell和ReusableView（相当于头部）
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    
    //添加返回按钮
    UIButton * returnbtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 30, 30)];
    [returnbtn setImage:[UIImage imageNamed:@"iSH_Back"] forState:UIControlStateNormal];
    [returnbtn addTarget:self action:@selector(returnback) forControlEvents:UIControlEventTouchUpInside];
    [self.collectionView addSubview:returnbtn];
    
    //页眉添加悬浮购物车标签，点击直接进入购物车界面
    UIButton * shoppingbtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width - 50, self.view.height - 50, 30, 30)];
    [shoppingbtn setImage:[UIImage imageNamed:@"home_ic_gouwuche_normal"] forState:UIControlStateNormal];
    [shoppingbtn addTarget:self action:@selector(returnShoppingCart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shoppingbtn];
    
    _ad_idValue = [_strHomeAd_id integerValue];
    [self startRequest:101];
}

//添加按钮方法，pop到上一页面
- (void)returnback{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)returnShoppingCart{
    //点击悬浮按钮进入购物车页面
    if ([IEngine engine].isSignedIn) {
        ShoppingCartViewController * shoppingcart = [[ShoppingCartViewController alloc] init];
        [self.navigationController pushViewController:shoppingcart animated:YES];
    } else {
        [CCAlertView showText:@"请登录" life:2.0];
        LoginingViewController *logingVC = [[LoginingViewController alloc] init];
        logingVC.delegate = self;
        [self.navigationController pushViewController:logingVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arrCount.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    BannerCollectionShoppingCartModel * model = [_arrJoinsc objectAtIndex:indexPath.row];
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
    }
    cell.delegate = self;
    cell.delegate = self;
    cell.item = model;
    [cell.imageShow setImageWithURL:[_arrImagePath objectAtIndex:indexPath.row]];
    cell.titlelab.text = [_arrName1 objectAtIndex:indexPath.row];
    cell.labValueNew.text = [_arrPrice objectAtIndex:indexPath.row];
    cell.labValueOld.text = [_arrOld objectAtIndex:indexPath.row];
    NSString *salePrice = _arrPrice[indexPath.row];
    NSString *oldPrice  = _arrOld[indexPath.row];
    if (salePrice.floatValue != oldPrice.floatValue) {
        cell.labValueOld.hidden = NO;
        cell.imageLine1.hidden = NO;
        cell.goldLab.hidden = NO;
    } else {
        cell.labValueOld.hidden = YES;
        cell.imageLine1.hidden = YES;
        cell.goldLab.hidden = YES;
    }
    
    return cell;
}
//头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                            UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    if (indexPath.section == 0) {

        if (_arrbanner.count != 0) {

            _adView = [[JXBAdPageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.view.width - 40)];
            _adView.iDisplayTime = 4.0;
//            _adView.pageControl.dotImage = [UIImage imageNamed:@"101"];
//            _adView.pageControl.currentDotImage = [UIImage imageNamed:@"100"];
            _adView.pageControl.currentPageIndicatorTintColor = RGBCOLOR(255, 95, 5);
            _adView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
            [_adView startAdsWithBlock:_arrbanner block:^(NSInteger clickIndex) {
                NSLog(@"%ld",(long)clickIndex);
            }];
            [headerView addSubview:_adView];
        }
    }
    return headerView;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //边距占5*4=20 ，2个
    //图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
    if (ScreenWidth == 320) {
        return CGSizeMake((self.view.width)/2, 240);
    }else if (ScreenWidth == 375){
        return CGSizeMake((self.view.width)/2, 280);
    }else
        return CGSizeMake((self.view.width)/2, 320);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    BannerCollectionShoppingCartModel * model = [_arrJoinsc objectAtIndex:indexPath.row];
    CommodityViewController * commodity = [[CommodityViewController alloc] init];
    NSString * strgoodsid = [_arrgoods_id objectAtIndex:indexPath.row];
    commodity.strgoods_id = strgoodsid;
    [self.navigationController pushViewController:commodity animated:YES];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//提示加入购物车成功
- (void)successShoppingCart:(CollectionViewCell *)cell{
    if ([IEngine engine].isSignedIn) {
        NSIndexPath * index = [_collectionView indexPathForCell:cell];
 //       _bannermodel = [_arrJoinsc objectAtIndex:index.row];
        _strName = [_arrName1 objectAtIndex:index.row];
        _strImage = [_arrImagePath objectAtIndex:index.row];
        _strSpec = [_arrspec objectAtIndex:index.row];
        _strgoodsid = [_arrgoods_id objectAtIndex:index.row];
        [self startRequest:102];
    } else {
        [CCAlertView showText:@"请登录" life:2.0];
        LoginingViewController *logingVC = [[LoginingViewController alloc] init];
        logingVC.delegate = self;
        [self.navigationController pushViewController:logingVC animated:YES];
    }
}

#pragma mark - Requests Banner图连接
- (BOOL)startRequest:(NSInteger)requestID{
    if ([super startRequest:requestID]) {
        if (requestID == 101) {
            [_client mainPageDeals:_ad_idValue];//_ad_idValue现在无返回结果
        }else if (requestID == 102){
            _goods_id = [_strgoodsid integerValue];
            _spec_id = [_strSpec integerValue];
            _shop_id = [_strShop integerValue];
            _goods_name = _strName;
            _goods_image = _strImage;
            [_client userAddShopcartWithGoodsId:(int)_goods_id sperId:(int)_spec_id shopId:0 goodsName:_goods_name goodsImg:_goods_image quantity:1];
        }else if (requestID == 103){
            [_client userGetCartNum];
        }else if (requestID == 104){
            [_client mainPageadlists:_ad_idValue];
        }
        return YES;
    }
    return NO;
}

- (BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result{
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 101) {
            _arrCount = [result getArrayForKey:@"data"];
            _arrName1 = [NSMutableArray array];
            _arrImagePath = [NSMutableArray array];
            _arrPrice = [NSMutableArray array];
            _arrOld = [NSMutableArray array];
            _arrgoods_id = [NSMutableArray array];
            _arrspec = [NSMutableArray array];
            _arrshop = [NSMutableArray array];
            for (NSDictionary * dict in _arrCount){
                BannerCollectionShoppingCartModel * item = [BannerCollectionShoppingCartModel objectWithDictionary:dict];
                [_arrJoinsc addObject:item];
                NSString * strName1 = [dict objectForKey:@"goods_name"];
                NSString * strImagePath = [dict objectForKey:@"goods_image"];
                NSString * strPrice = [dict objectForKey:@"goods_price"];
                NSString * strOld = [dict objectForKey:@"old_price"];
                NSString * strdetail_goods_id = [dict objectForKey:@"goods_id"];
                //无shop_id;
                NSString * strdetail_spec_id = [dict objectForKey:@"spec_id"];
                [_arrspec addObject:strdetail_spec_id];
                
                if ([strImagePath hasPrefix:@"http"]) {
                    [_arrImagePath addObject:strImagePath];
                } else {
                    NSString * stringImage = [NSString stringWithFormat:@"%@%@", DeFaultURL, strImagePath];
                    [_arrImagePath addObject:stringImage];
                }
                [_arrName1 addObject:strName1];

                [_arrPrice addObject:strPrice];
                [_arrOld addObject:strOld];
                [_arrgoods_id addObject:strdetail_goods_id];
            };
                [self startRequest:104];
        }else if (sender.requestID == 102){
            [CCAlertView showText:@"加入购物车成功" life:1.0];
            [self startRequest:103];
        }else if (sender.requestID == 103){
            NSDictionary *data = [result getDictionaryForKey:@"data"];
            NSString *cartNum = [data getStringValueForKey:@"cart_number" defaultValue:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cartNum" object:nil userInfo:@{@"cartNum":cartNum}];
        }else if (sender.requestID == 104){
            NSDictionary * dict = [result getDictionaryForKey:@"data"];
            NSArray * arr = [dict getArrayForKey:@"photos"];
            for (NSInteger i = 0; i < arr.count; i ++) {

            if ([arr[i] hasPrefix:@"http"]) {
                [_arrbanner addObject:arr[i]];
            } else {
                NSString * stringImage = [NSString stringWithFormat:@"%@%@", DeFaultURL, arr[i]];
                [_arrbanner addObject:stringImage];
            }
        }
        }
        NSLog(@"%@",_arrbanner);
        [_collectionView reloadData];
        return YES;
    }
    return NO;
}
- (void)backToPerCenVCWithInfo:(NSDictionary *)info{
}

@end
