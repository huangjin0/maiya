//
//  ISH_MainViewController.m
//  IOSProject
//
//  Created by IOS002 on 16/6/1.
//  Copyright © 2016年 CC Inc. All rights reserved.
//

#import "ISH_MainViewController.h"
#import "ISH_MainBannerCell.h"
#import "ISH_MainBtnCell.h"
#import "ISH_MainImgCell.h"
#import "ISH_MainGoodsCell.h"
#import "ISH_MainHeadView.h"
#import "SearchPageViewController.h"
#import "LoginingViewController.h"
#import "MsgCenViewController.h"
#import "BannerAndConnectionImageViewController.h"
#import "AllOrdersViewController.h"
#import "CollectionManagementViewController.h"
#import "CommodityViewController.h"


@interface ISH_MainViewController ()<logInDelegate,SDCycleScrollViewDelegate> {
    
    IBOutlet UICollectionView *_collectionView;
//    banner数组
    NSMutableArray *_bannerArr;
//    按钮数组
    NSArray *_btnArr;
//    中部广告数组
    NSMutableArray *_midAdArr;
//    请求数量
    NSInteger _reqeustInteger;
//    下部广告位section数组
    NSMutableArray *_bottomSecArr;
//    下部广告为商品数组
    NSMutableArray *_bottomGoodsArr;
//    红点
    UIImageView *_pointImageView;
//    红点是否显示
    BOOL _hasRedPoint;
    UIButton *_rightBtn;
}

@end

static NSString *cellIdentifier0 = @"cell0";
static NSString *cellIdentifier1 = @"cell1";
static NSString *cellIdentifier2 = @"cell2";
static NSString *cellIdentifier3 = @"cell3";
static NSString *headIdentifier = @"headIdentifier";

#define KImg @"Kimage"
#define KTitle @"Ktitle"

@implementation ISH_MainViewController

- (id)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = NO;
        ADD_NTF(@"heartBeat", @selector(hasRecivedNewMessageWithnotification:));
        ADD_NTF(@"hasRedPoint", @selector(hasReadMessage));
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hasRedPoint" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.leftBarButtonItem = [self addItemWithImg:@"iSH_HomeLogo" action:@selector(logoActionWithSender:)];
    [self addLogoButton];
//    self.navigationItem.rightBarButtonItem = [self addItemWithImg:@"mynews_ic_normal" action:@selector(meassgeActionWithSender:)];
    [self addRightMsgButton];
    self.navigationItem.titleView = [self addSearhBar];
//    注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"ISH_MainBannerCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier0];
    [_collectionView registerNib:[UINib nibWithNibName:@"ISH_MainBtnCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier1];
    [_collectionView registerNib:[UINib nibWithNibName:@"ISH_MainImgCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier2];
    [_collectionView registerNib:[UINib nibWithNibName:@"ISH_MainGoodsCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier3];
    [_collectionView registerNib:[UINib nibWithNibName:@"ISH_MainHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentifier];
//    初始化
    _bannerArr = [NSMutableArray array];
    _btnArr = @[@{KImg:@"iSH_HomeDingDan",KTitle:@"订单查询"},
                @{KImg:@"iSH_HomeShoucang",KTitle:@"我的收藏"},
                @{KImg:@"dianhua_icon",KTitle:@"电话速购"}];
    _midAdArr = [NSMutableArray array];
    _bottomSecArr = [NSMutableArray array];
    _bottomGoodsArr = [NSMutableArray array];
    [self startRequest:101];
    // Do any additional setup after loading the view from its nib.
}

/**
 * 添加右边消息按钮
 */
- (void)addRightMsgButton {
    UIButton * rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setBackgroundImage:[UIImage imageNamed:@"iSH_NewsMsg"] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(meassgeActionWithSender:) forControlEvents:UIControlEventTouchUpInside];
    rightbtn.frame = CGRectMake(10, 0, 25, 25);
    _pointImageView = [[UIImageView alloc] initWithFrame:CGRectMake(22.5, 0, 5, 5)];
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

/**
 * 添加搜索框
 */
- (UIView *)addSearhBar {
    UIButton * searchbtn = [[UIButton alloc] init];
    [searchbtn setBackgroundImage:[UIImage imageNamed:@"search__@3x"] forState:UIControlStateNormal];
    [searchbtn addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    searchbtn.frame = CGRectMake(50, 10, 200, 30);
    return searchbtn;
}

/**
 * 添加logo按钮
 */
- (void)addLogoButton {
    UIButton * leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"iSH_HomeLogo"] forState:UIControlStateNormal];
    leftbtn.frame = CGRectMake(10, 0, 25, 25);
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = leftButton;
}

/**
 *  跳转到搜索界面
 */
- (void)searchButtonAction{
    SearchPageViewController * searchPage = [[SearchPageViewController alloc] init];
    [self.navigationController pushViewController:searchPage animated:YES];
}


//logo_Action
- (void)logoActionWithSender:(id)sender {
    
}

//消息中心
- (void)meassgeActionWithSender:(id)sender {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 获取banner图片url
 */
- (NSArray *)getTheBannerImgWithArr:(NSArray *)arr {
    NSMutableArray *imgArr = [NSMutableArray array];
    for (ISH_MainBanner *item in arr) {
        NSString *url = [ISH_ImgUrl ish_imgUrlWithStr:item.ad_image];
        [imgArr addObject:url];
    }
    return imgArr;
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
    NSURL * telURL = [NSURL URLWithString:@"tel://0834-3283366"];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebview];
}


#pragma mark -SDCycleViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    ISH_MainBanner *item = _bannerArr[index];
    BannerAndConnectionImageViewController * bannerconnection = [[BannerAndConnectionImageViewController alloc] init];
    bannerconnection.strHomeAd_id = [NSString stringWithFormat:@"%ld",(long)item.ad_id];
    [self.navigationController pushViewController:bannerconnection animated:YES];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 3;
    }
    if (section == 2) {
        return _midAdArr.count;
    }
    NSArray *secArr = _bottomGoodsArr[section - 3];
    return secArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ISH_MainBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier0 forIndexPath:indexPath];
        cell.bannerView.imageURLStringsGroup = [self getTheBannerImgWithArr:_bannerArr];
        cell.bannerView.delegate = self;
        return cell;
    }
    if (indexPath.section == 1) {
        ISH_MainBtnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier1 forIndexPath:indexPath];
        NSDictionary *dic = _btnArr[indexPath.row];
        cell.logoImg.image = [UIImage imageNamed:[dic getStringValueForKey:KImg defaultValue:nil]];
        cell.logoTitle.text = [dic getStringValueForKey:KTitle defaultValue:nil];
        if (indexPath.row == 2) {
            cell.backgroundColor = RGBCOLOR(255, 147, 0);
            cell.logoTitle.textColor = [UIColor whiteColor];
        } else {
            cell.backgroundColor = [UIColor whiteColor];
            cell.logoTitle.textColor = RGBCOLOR(255, 147, 0);
        }
        return cell;
    }
    if (indexPath.section == 2) {
        ISH_MainImgCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier2 forIndexPath:indexPath];
        cell.item = _midAdArr[indexPath.row];
        return cell;
    }
    ISH_MainGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier3 forIndexPath:indexPath];
    NSArray *secArr = _bottomGoodsArr[indexPath.section - 3];
    cell.item = secArr[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 1) {
        return nil;
    }
    ISH_MainHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentifier forIndexPath:indexPath];
    if (indexPath.section == 2) {
        headView.titleLab.text = @"今日推荐";
    } else {
        ISH_MainBanner *item = _bottomSecArr[indexPath.section - 3];
        headView.titleLab.text = item.ad_name;
    }
    return headView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3 + _bottomGoodsArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return CGSizeMake(KViewWidth, KViewWidth / 2);
    }
    if (indexPath.section == 1 ) {
        return CGSizeMake((KViewWidth - 2) / 3, KViewWidth / 3 / 106 * 60);
    }
    if (indexPath.section == 2) {
        return CGSizeMake(KViewWidth, KViewWidth / 320 * 153);
    }
    return CGSizeMake((KViewWidth - 2) / 3, (KViewWidth - 2) / 3 / 106 * 146);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return CGSizeZero;
    }
    return CGSizeMake(KViewWidth, KViewWidth / 320 * 40);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        return;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self oderDdetail];
            return;
        }
        if (indexPath.row ==1) {
            [self myCollection];
            return;
        }
        if (indexPath.row == 2) {
            [self telephoneTesco];
            return;
        }
        return;
    }
    if (indexPath.section == 2) {
        ISH_MainBanner *item = _midAdArr[indexPath.row];
        BannerAndConnectionImageViewController * bannerconnection = [[BannerAndConnectionImageViewController alloc] init];
        bannerconnection.strHomeAd_id = [NSString stringWithFormat:@"%ld",(long)item.ad_id];
        [self.navigationController pushViewController:bannerconnection animated:YES];
        return;
    }
    NSArray *secArr = _bottomGoodsArr[indexPath.section - 3];
    ISH_MainGoods *item = secArr[indexPath.row];
    CommodityViewController * commodity = [[CommodityViewController alloc] init];
    commodity.strgoods_id = [NSString stringWithFormat:@"%ld",(long)item.goods_id];
    [self.navigationController pushViewController:commodity animated:YES];
}


#pragma mark - CCReqeust
- (BOOL)startRequest:(NSInteger)requestID {
    if ([super startRequest:requestID]) {
        if (requestID == 101) {
            [_client getTheHomeAdListWithType_id:1];
        }
        if (requestID == 102) {
            [_client getTheHomeAdListWithType_id:2];
        }
        if (requestID == 103) {
            [_client getTheHomeAdListWithType_id:3];
        }
        if (requestID == 104) {
            ISH_MainBanner *item = _bottomSecArr[_reqeustInteger];
            [_client mainPageDeals:item.ad_id];
        }
        return YES;
    }
    return NO;
}

- (BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result {
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 101) {
            NSArray *data = [result getArrayForKey:@"data"];
            for (NSDictionary *dic in data) {
                ISH_MainBanner *item = [[ISH_MainBanner alloc] initWithDic:dic];
                [_bannerArr addObject:item];
            }
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
            [_collectionView reloadSections:indexSet];
            [self startRequest:102];
        }
        if (sender.requestID == 102) {
            NSArray *data = [result getArrayForKey:@"data"];
            for (NSDictionary *dic in data) {
                ISH_MainBanner *item = [[ISH_MainBanner alloc] initWithDic:dic];
                [_midAdArr addObject:item];
            }
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:2];
            [_collectionView reloadSections:indexSet];
            [self startRequest:103];
        }
        if (sender.requestID == 103) {
            NSArray *data = [result getArrayForKey:@"data"];
            for (NSDictionary *dic in data) {
                ISH_MainBanner *item = [[ISH_MainBanner alloc] initWithDic:dic];
                [_bottomSecArr addObject:item];
            }
            _reqeustInteger = 0;
            if (_bottomSecArr.count != 0) {
                [self startRequest:104];
            }
        }
        if (sender.requestID == 104) {
            NSArray *data = [result getArrayForKey:@"data"];
            NSMutableArray *mutableArr = [NSMutableArray array];
            for (NSDictionary *dic in data) {
                ISH_MainGoods *item = [[ISH_MainGoods alloc] initWithDic:dic];
                [mutableArr addObject:item];
            }
            [_bottomGoodsArr addObject:mutableArr];
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:3 + _reqeustInteger];
            [_collectionView insertSections:indexSet];
            _reqeustInteger ++;
            if (_reqeustInteger < _bottomSecArr.count) {
                [self startRequest:104];
            }
        }
        return YES;
    }
    return NO;
}

#pragma mark - loginDelegate
-(void)backToPerCenVCWithInfo:(NSDictionary *)info {
    
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
