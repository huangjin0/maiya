//
//  HomeViewController.m
//  IOSProject
//
//  Created by sfwen on 15/7/17.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "HomeViewController.h"
#import "ADView.h"
#import "ADBanner.h"
#import "Recommend.h"
#import "RecommendCell.h"
#import "SaleGoods.h"
#import "Goods.h"
#import "GoodsCell.h"
#import "MsgCenViewController.h"
#import "SearchPageViewController.h"
#import "AllOrdersViewController.h"
#import "CollectionManagementViewController.h"
#import "ClassificationViewController.h"
#import "BannerAndConnectionImageViewController.h"
#import "CommodityViewController.h"
#import "LoginingViewController.h"
#import "JXBAdPageView.h"

@interface HomeViewController () <ADViewDelegate,recommendDelegate,commmoditygoodsDelegate,logInDelegate,commodityDetailDelegate,UITableViewDataSource,UITableViewDelegate> {
    NSMutableArray * _headerBannerImageArray;
    NSMutableArray * _headIdArray;
    NSMutableArray * _recommendArray;
    NSMutableArray * _saleArray;//特惠
    NSMutableArray * _hotSellArray;//热销
    NSInteger       _indexAd;
    NSMutableArray * _allSaleArray;
    NSInteger       _indexSale;
    
    NSMutableArray * _arrimage;
    NSMutableArray * _arrname;
    NSString * _strimage;
    NSString * _strname;
    NSMutableArray * _arrNameList1;
    NSMutableArray * _arrImageList1;
    NSInteger _int_p_idValue;
    NSArray * _arrlist;
    NSMutableDictionary * _dic;
    NSMutableDictionary * _dict;
    NSString * _strstok;
    NSString * _strvirtal;
    
    NSString * _str_ad_idtitle;
    NSString * _str_ad_iddetail;
    NSString * _str_goods_id;
    NSMutableArray * _arrad_idtitle;//banner图传参ad_id
    NSMutableArray * _arrad_iddetail;//广告栏传参ad_id
    NSMutableArray * _arrgoods_iddetail;//产品传参goods_id
//    红点是否显示
    BOOL _hasRedPoint;
//    红点
    UIImageView *_pointImageView;
    NSString * _strName;
    NSMutableArray * _arrName;//三级栏广告标题名称
    NSMutableArray * _arrAdid;//ad_id
    NSInteger * _adid;
//    产品数组
    NSMutableArray *_productArr;
    CGFloat h;//中部广告图高度
    CGFloat m;//按钮高度
    CGFloat m1;//按钮图片y轴高度
    CGFloat h1;//特惠栏高度
    CGFloat h2;
    CGFloat h3;
}
@property (nonatomic,assign) BOOL loadFinish;
@property (nonatomic, strong)JXBAdPageView * adView;

@end


@implementation HomeViewController

- (id)init{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = NO;
    }
    //    添加消息监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasRecivedNewMessageWithnotification:) name:@"heartBeat" object:nil];
    return self;
}

/**
 * 消息监听
 */
-(void)hasRecivedNewMessageWithnotification:(NSNotification *)notification {
    if (!_hasRedPoint) {
        _pointImageView.hidden = NO;
        _hasRedPoint = YES;
    }
}

/**
 * 取消红点
 */
-(void)hasReadMessage {
    if (_hasRedPoint) {
        _pointImageView.hidden = YES;
        _hasRedPoint = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _productArr = [NSMutableArray array];

    // Do any additional setup after loading the view from its nib.
//    _adView.delegate = self;
    [self initHomeData];

//    h = ScreenWidth / 1;
    if (ScreenWidth == 320) {
        h = 160;
        m = 70;
        m1 = 7.5;
        h1 = 145;
        h2 = 10;
        h3 = 10;
    }else if (ScreenWidth == 375){
        h = 187.5;
        m = 70;
        m1 = 17.5;
        h1 = 165;
        h2 = 15;
        h3 = 22;
    }else{
        h = 207;
        m = 80;
        m1 = 20;
        h1 = 185;
        h2 = 20;
        h3 = 22;
    }
    
    //设置navigationItem；
    UIButton * leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
    leftbtn.frame = CGRectMake(10, 0, 20, 20);
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIButton * rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setBackgroundImage:[UIImage imageNamed:@"mynews_ic_normal"] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(rightBtnMessage) forControlEvents:UIControlEventTouchUpInside];
    rightbtn.frame = CGRectMake(10, 0, 20, 20);
    _pointImageView = [[UIImageView alloc] initWithFrame:CGRectMake(17.5, 0, 5, 5)];
    _pointImageView.backgroundColor = [UIColor redColor];
    _pointImageView.layer.cornerRadius = 2.5;
    _pointImageView.layer.masksToBounds = YES;
    if (_hasRedPoint) {
        _pointImageView.hidden = NO;
    } else {
        _pointImageView.hidden = YES;
    }
    [rightbtn addSubview:_pointImageView];
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    //设置搜索框
    UIButton * searchbtn = [[UIButton alloc] init];
    [searchbtn setBackgroundImage:[UIImage imageNamed:@"search__@3x"] forState:UIControlStateNormal];
    [searchbtn addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    searchbtn.frame = CGRectMake(50, 10, 200, 30);
    self.navigationItem.titleView = searchbtn;
    
    [self firstBanner];
}

- (void)firstBanner{
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableView.frame = CGRectMake(0, 0, self.view.width, [UIScreen mainScreen].bounds.size.height - m);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.separatorStyle = NO;
    _tableView.contentInset = UIEdgeInsetsMake(h + m + 15, 0, 0, 0);
    
    [self.view addSubview:_tableView];
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    _imageBG = [[UIButton alloc] init];
    _imageBG.frame = CGRectMake(0, -(h + m + 15), ScreenWidth, h);
    [_tableView addSubview:_imageBG];
    UIImageView * backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, h, ScreenWidth, h / 2 - h3)];
    backgroundImg.backgroundColor = [UIColor whiteColor];
    [_imageBG addSubview:backgroundImg];
    
    //首页类别
    NSArray * arrDetail = @[@"订单查询",@"我的收藏",@"电话速购"];
    for (NSInteger i = 0; i < 3; i ++) {
        UIButton * detailBtn = [[UIButton alloc] init];
        detailBtn.frame = CGRectMake(ScreenWidth / 3 * i, -(m + 15), ScreenWidth / 3, m + 2);
//        detailBtn.backgroundColor = [UIColor redColor];
        
        [_tableView addSubview:detailBtn];
        if (i == 0) {
            [detailBtn addTarget:self action:@selector(oderDdetail) forControlEvents:UIControlEventTouchUpInside];
        }else if (i == 1){
            [detailBtn addTarget:self action:@selector(myCollection) forControlEvents:UIControlEventTouchUpInside];
        }else if (i == 2){
            [detailBtn addTarget:self action:@selector(telephoneTesco) forControlEvents:UIControlEventTouchUpInside];
            [detailBtn setBackgroundColor:[UIColor colorFromHexCode:@"9ee083"]];
        }
        
        NSArray * arrImg = @[@"home_dingdan_icon_normal",@"home_shoucang_icon_normal2",@"dianhua_icon"];
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth / 3) / 2 - 12.5, m1, 25, 25)];
        image.image = [UIImage imageNamed:arrImg[i]];
        [detailBtn addSubview:image];
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth / 3) / 2 - 40, m1 + 30, 80, 20)];
        lab.text = arrDetail[i];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:12];
        [detailBtn addSubview:lab];
    }
}

- (void)initHomeData {
    _headerBannerImageArray = [[NSMutableArray alloc] init];
    _recommendArray = [[NSMutableArray alloc] init];
    _saleArray = [[NSMutableArray alloc] init];
    _hotSellArray = [[NSMutableArray alloc] init];
    _allSaleArray = [[NSMutableArray alloc] init];
    _headIdArray = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_firstAppear || !_loadFinish) {
        _needLoadingHUD = NO;
        [self startRequest:0];
    }
//    取消红点监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasReadMessage) name:@"hasRedPoint" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = _productArr.count;
    return count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _recommendArray.count;
    } else {
        NSArray * arr = [_productArr objectAtIndex:section - 1];
        if (arr.count % 3 == 0) {
            return arr.count / 3;
        } else {
            return arr.count / 3 + 1;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString * idetifier = @"RecommendCell";
        RecommendCell * cell = [tableView dequeueReusableCellWithIdentifier:idetifier];
        if (!cell) {
            cell = [[RecommendCell alloc] initWithReuseIdentifier:idetifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (_recommendArray.count > 0) {
            cell.item = [_recommendArray objectAtIndex:indexPath.row];
        }
//        cell.delegated = self;
        return cell;
    } else {
        static NSString * idetifier = @"GoodsCell";
        GoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:idetifier];
        if (!cell) {
            cell = [[GoodsCell alloc] initWithReuseIdentifier:idetifier];
        }
        NSArray *arr = [_productArr objectAtIndex:indexPath.section - 1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        //@ wenti
        cell.indexPath = indexPath;

        for (NSInteger n = 0; n < _allSaleArray.count + 1; n ++) {
            if (indexPath.section == n + 1) {
//                cell.goodsArray = _saleArray;
                cell.goodsArray = arr;
            }
        }
        cell.delegate = self;
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.0001;
    } else {
        return 30;
    }
}

//section加标题;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    view.backgroundColor = [UIColor redColor];
    if (section == 0) {
        if (_headerBannerImageArray.count != 0) {
            [_adView removeFromSuperview];
            _adView = [[JXBAdPageView alloc] initWithFrame:CGRectMake(0,0, ScreenWidth, h)];
            _adView.iDisplayTime = 4.0;
            //        _adView.pageControl.dotImage = [UIImage imageNamed:@"101"];
            //        _adView.pageControl.currentDotImage = [UIImage imageNamed:@"100"];
            _adView.pageControl.currentPageIndicatorTintColor = [UIColor colorFromHexCode:@"8fc31f"];
            _adView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
            [_adView startAdsWithBlock:_headerBannerImageArray block:^(NSInteger clickIndex) {
                NSLog(@"%ld",(long)clickIndex);
                BannerAndConnectionImageViewController * bannerconnection = [[BannerAndConnectionImageViewController alloc] init];
                //    NSIndexPath * index = [_tableView indexPathForCell:view];
                NSString * strtag = [NSString stringWithFormat:@"%ld",(long)clickIndex];
                ADBanner * model = [_headIdArray objectAtIndex:[strtag integerValue]];
                //            NSString * str = [NSString stringWithFormat:@"%ld",(long)model.strId];
                bannerconnection.strHomeAd_id = model;//_str_ad_idtitle;
                [self.navigationController pushViewController:bannerconnection animated:YES];
            }];
            [_imageBG addSubview:_adView];
        }

    }
    for (NSInteger i = 0; i <= _arrName.count; i ++) {
        if (section == i + 1){
            
            UIImageView * imageback = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width * 3, 29)];
            imageback.backgroundColor = [UIColor colorFromHexCode:@"#ffffff"];
            [view addSubview:imageback];
            UILabel * labtitle = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 100, 29)];
            labtitle.text = _arrName[i];
            labtitle.textColor = [UIColor colorFromHexCode:@"#333333"];
            [view addSubview:labtitle];
    
            UIImageView * imagetitle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
            imagetitle.backgroundColor = [UIColor colorFromHexCode:@"#60b63c"];
            [view addSubview:imagetitle];
        }
    }
    return view;
}
//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (_recommendArray.count > 0) {
//            Recommend * item = [_recommendArray objectAtIndex:indexPath.row];
//            return [RecommendCell heightForCell:item];
            return h;
        }
        else return 0;
    } else {
        //特惠栏cell的高度
        return h1;
    }
 //   return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        BannerAndConnectionImageViewController * banner = [[BannerAndConnectionImageViewController alloc] init];
        NSIndexPath * index = indexPath;//[_tableView indexPathForCell:cell];
        Recommend * model = [_recommendArray objectAtIndex:index.row];
        banner.strHomeAd_id = model.ad_id;
        [self.navigationController pushViewController:banner animated:YES];
    }
}

/**
 *  跳转到消息中心
 */
- (void)rightBtnMessage{
    if ([IEngine engine].isSignedIn) {
        MsgCenViewController *msgVC = [[MsgCenViewController alloc] init];
        [self.navigationController pushViewController:msgVC animated:YES];
    }else{
        [CCAlertView showText:@"请登录" life:2.0];
        LoginingViewController *logingVC = [[LoginingViewController alloc] init];
        logingVC.delegate = self;
        [self.navigationController pushViewController:logingVC animated:YES];
//        self.tabBarController.selectedIndex = 2;
    }
}
/**
 *  跳转到搜索界面
 */
- (void)searchButtonAction{
    SearchPageViewController * searchPage = [[SearchPageViewController alloc] init];
    [self.navigationController pushViewController:searchPage animated:YES];
}

- (void)needReceiveAd_id:(ADView *)view tag:(NSInteger)tag{
    BannerAndConnectionImageViewController * bannerconnection = [[BannerAndConnectionImageViewController alloc] init];
//    NSIndexPath * index = [_tableView indexPathForCell:view];
    NSString * strtag = [NSString stringWithFormat:@"%ld",(long)tag];
    ADBanner * model = [_headerBannerImageArray objectAtIndex:[strtag integerValue]];
    NSString * str = [NSString stringWithFormat:@"%ld",(long)model.ID];
    bannerconnection.strHomeAd_id = str;//_str_ad_idtitle;
    [self.navigationController pushViewController:bannerconnection animated:YES];
}

- (void)recommendValue:(RecommendCell *)cell{
    BannerAndConnectionImageViewController * banner = [[BannerAndConnectionImageViewController alloc] init];
    NSIndexPath * index = [_tableView indexPathForCell:cell];
    Recommend * model = [_recommendArray objectAtIndex:index.row];
    banner.strHomeAd_id = model.ad_id;
    [self.navigationController pushViewController:banner animated:YES];
}

- (void)commoditygoods:(GoodsCell *)cell tag:(NSInteger)tag{
    NSIndexPath *index = [_tableView indexPathForCell:cell];
    NSArray *arr = [_productArr objectAtIndex:index.section - 1];
    CommodityViewController * commodity = [[CommodityViewController alloc] init];
    NSString * strtag = [NSString stringWithFormat:@"%ld",(long)tag];
    Goods * model = [arr objectAtIndex:[strtag integerValue]];
    commodity.strgoods_id = model.goods_id;
    [self.navigationController pushViewController:commodity animated:YES];
}

#pragma mark - Requests
- (BOOL)startRequest:(NSInteger)requestID {
    if ([super startRequest:requestID]) {
        if (requestID == 0) {
            [_client bannerAdvertising:1];
        } else if (requestID == 1) {
            [_client advertisementsCentral:2];
        } else if (requestID == 2) {
            [_client advertisementsTail:3];
        } else if (requestID == 3) {
            SaleGoods * item = [_allSaleArray objectAtIndex:_indexSale];
            [_client mainPageDeals:item.ID];
        } else if (requestID == 4) {
            [_client userGetCartNum];
        }
        return YES;
    }
    return NO;
}

- (BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result {
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 0) {
            [_headerBannerImageArray removeAllObjects];
            [_headIdArray removeAllObjects];
            NSArray * data = [result getArrayForKey:@"data"];
            _arrad_idtitle = [NSMutableArray array];
            _arrgoods_iddetail = [NSMutableArray array];
            if (data.count == 0) {
                _adView = nil;
                _adView.height = 0;
            } else {
                _arrad_iddetail = [NSMutableArray array];
                for (NSDictionary * dict in data) {
                    ADBanner * item = [ADBanner objectWithDictionary:dict];
                    [_headerBannerImageArray addObject:item.headURL];
                    [_headIdArray addObject:item.strId];
                    NSString * ad_idtitle = [dict objectForKey:@"ad_id"];
                    [_arrad_idtitle addObject:ad_idtitle];
                }
//                _adView.imageArray = _headerBannerImageArray;
            }
            _needLoadingHUD = NO;
            [self startRequest:1];
        } else if (sender.requestID == 1) {
            NSArray * data = [result getArrayForKey:@"data"];
            for (NSDictionary * dict in data)  {
                Recommend * item = [Recommend objectWithDictionary:dict];
                [_recommendArray addObject:item];
            }
            _needLoadingHUD = NO;
            [self startRequest:2];
        } else if (sender.requestID == 2) {
            _arrName = [NSMutableArray array];
            _arrAdid = [NSMutableArray array];
            NSArray * data = [result getArrayForKey:@"data"];
            for (NSDictionary * dict in data) {
                SaleGoods * item = [SaleGoods objectWithDictionary:dict];
                [_allSaleArray addObject:item];
                NSString * strAdid = [dict objectForKey:@"ad_id"];
                [_arrAdid addObject:strAdid];
                _strName = [dict objectForKey:@"ad_name"];
                [_arrName addObject:_strName];
            }
            _needLoadingHUD = NO;
            [self startRequest:3];
        } else if (sender.requestID == 3) {
            NSArray * data = [result getArrayForKey:@"data"];
            
            NSMutableArray *proArr = [NSMutableArray array];
            for (NSDictionary * dict in data) {
                Goods * item = [Goods objectWithDictionary:dict];
                for (NSInteger p = 0; p < _allSaleArray.count; p ++) {
                    if (_indexSale == p) {
                        [_saleArray addObject:item];
                    }else if (_indexSale == p + 1){
                        [_saleArray removeLastObject];
                    }
                }
                        [proArr addObject:item];
                _str_goods_id = [dict objectForKey:@"goods_id"];
                [_arrgoods_iddetail addObject:_str_goods_id];
                _strstok = [dict objectForKey:@"stock"];
                _strvirtal = [dict objectForKey:@"virtal_sales"];
            }
            [_productArr addObject:proArr];
            
            
            _indexSale++;
            if (_indexSale < _allSaleArray.count) {
                _needLoadingHUD = NO;
                [self startRequest:3];
            } else {
                _loadFinish = YES;
                if ([IEngine engine].isSignedIn) {
                    _needLoadingHUD = NO;
                    [self startRequest:4];
                }
            }
        } else if (sender.requestID == 4) {
            NSDictionary *data = [result getDictionaryForKey:@"data"];
            NSString *cartNum = [data getStringValueForKey:@"cart_number" defaultValue:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cartNum" object:nil userInfo:@{@"cartNum":cartNum}];
        }
        [_tableView reloadData];
        return YES;
    }
    return NO;
}
/**
 * 订单查询
 */
- (IBAction)orderQuery:(id)sender {
    if ([IEngine engine].isSignedIn) {
        AllOrdersViewController * allOrders = [[AllOrdersViewController alloc] init];
        [self.navigationController pushViewController:allOrders animated:YES];
    } else {
        [CCAlertView showText:@"请登录" life:2.0];
        LoginingViewController *logingVC = [[LoginingViewController alloc] init];
        logingVC.delegate = self;
        [self.navigationController pushViewController:logingVC animated:YES];
//        self.tabBarController.selectedIndex = 2;
    }
}
/**
 * 我的收藏
 */
- (IBAction)myCollection:(id)sender {
    if ([IEngine engine].isSignedIn) {
        CollectionManagementViewController * collection = [[CollectionManagementViewController alloc] init];
        [self.navigationController pushViewController:collection animated:YES];
    } else {
        [CCAlertView showText:@"请登录" life:2.0];
        LoginingViewController *logingVC = [[LoginingViewController alloc] init];
        logingVC.delegate = self;
        [self.navigationController pushViewController:logingVC animated:YES];
//        self.tabBarController.selectedIndex = 2;
    }
}
/**
 
 * 电话速购
 */
- (IBAction)telephoneTesco:(id)sender {
    UIWebView * callWebview = [[UIWebView alloc] init];
    NSURL * telURL = [NSURL URLWithString:@"tel://02886523627"];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebview];
}
/**
 * 订单查询
 */
- (void)oderDdetail{
    if ([IEngine engine].isSignedIn) {
        AllOrdersViewController * allOrders = [[AllOrdersViewController alloc] init];
        [self.navigationController pushViewController:allOrders animated:YES];
    } else {
        [CCAlertView showText:@"请登录" life:2.0];
        LoginingViewController *logingVC = [[LoginingViewController alloc] init];
        logingVC.delegate = self;
        [self.navigationController pushViewController:logingVC animated:YES];
//        self.tabBarController.selectedIndex = 2;
    }
}
/**
 * 我的收藏
 */
- (void)myCollection{
    if ([IEngine engine].isSignedIn) {
        CollectionManagementViewController * collection = [[CollectionManagementViewController alloc] init];
        [self.navigationController pushViewController:collection animated:YES];
    } else {
        [CCAlertView showText:@"请登录" life:2.0];
        LoginingViewController *logingVC = [[LoginingViewController alloc] init];
        logingVC.delegate = self;
        [self.navigationController pushViewController:logingVC animated:YES];
//        self.tabBarController.selectedIndex = 2;
    }
}
/**
 * 电话速购
 */
- (void)telephoneTesco{
    UIWebView * callWebview = [[UIWebView alloc] init];
    NSURL * telURL = [NSURL URLWithString:@"tel://02886523627"];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebview];
}
- (void)goodsidToCommodity:(NSString *)goodsid{
}
- (void)backToPerCenVCWithInfo:(NSDictionary *)info{
}
//HASCHAGE
//- (void)telephoneTesco{
//}

@end
