//
//  MainPageViewController.m
//  IOSProject
//
//  Created by IOS002 on 15/5/30.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "MainPageViewController.h"
#import "MainPageBannerScrollView.h"
#import "MainPageBannerModel.h"
#import "MainPageCell.h"
#import "BannerViewController.h"
#import "SearchPageViewController.h"
#import "ShoppingCartViewController.h"
#import "CommodityViewController.h"
#import "BannerAndConnectionImageViewController.h"
#import "MsgCenViewController.h"
#import "MainPageProductCollectionViewCell.h"
#import "MainPageLastCollectionViewCell.h"


@interface MainPageViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>{
    
    MainPageCell             * _maincell;
    MainPageBannerScrollView * _scrollView;
    UIScrollView             * _myscrollview;
    UITableView              * _tableView;
    
    UIButton                 * _orderInquirybtn;  //订购查询按钮
    UIButton                 * _myCollectionbtn;  //我的收藏按钮
    UIButton                 * _phonePurchasebtn; //电话速购按钮
    NSString                 * _strName;          //首页中部广告名称
    NSString                 * _strImage;         //首页中部广告图片
    NSString                 * _strName1;         //首页尾部广告名称
    NSString                 * _strPrice;         //首页尾部广告新价格
    NSString                 * _strImagePath;     //首页尾部广告图片
    NSString                 * _strOld;           //首页尾部广告旧价格
    NSString                 * _ad_id;            //获取ad_id
    NSMutableArray           * _arrName1;
    NSArray * _arr4;
    NSMutableDictionary * _dic1;
    NSMutableDictionary * _dic2;
    NSMutableDictionary * _dic3;
    NSMutableDictionary * _dic4;
}
@property (nonatomic,strong) NSString *ucode;

@end

NSString * adIdCenter = @"";   //传值ad_id到其他控制器
NSString * goodsidValue = @""; //传值goods_id到商品详情

@implementation MainPageViewController

- (id)init{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ucode = [[NSUserDefaults standardUserDefaults] objectForKey:@"ucode"];
    // Do any additional setup after loading the view.
    
    [self startRequest:101];
    /**
     设置navigationItem；
     */
    UIButton * leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
    leftbtn.frame = CGRectMake(10, 0, 20, 20);
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIButton * rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setBackgroundImage:[UIImage imageNamed:@"mynews_ic_normal"] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(rightBtnMessage) forControlEvents:UIControlEventTouchUpInside];
    rightbtn.frame = CGRectMake(10, 0, 20, 20);
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    UIButton * searchbtn = [[UIButton alloc] init];
    [searchbtn setBackgroundImage:[UIImage imageNamed:@"search__"] forState:UIControlStateNormal];
    [searchbtn addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    searchbtn.frame = CGRectMake(50, 10, 200, 30);
    self.navigationItem.titleView = searchbtn;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    
    //********************************
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    flowLayout.headerReferenceSize = CGSizeMake(self.view.width, 30);//头部
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 465) collectionViewLayout:flowLayout];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
//    [self.view addSubview:self.collectionView];

    
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];

    //注册cell和ReusableView（相当于头部）
    [self.collectionView registerClass:[MainPageProductCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    
    //**************************************
}

/**
 *  跳转到消息中心
 */
- (void)rightBtnMessage{
    MsgCenViewController *msgVC = [[MsgCenViewController alloc] init];
    [self.navigationController pushViewController:msgVC animated:YES];
}
/**
 *  跳转到搜索界面
 */
- (void)searchButtonAction{
    SearchPageViewController * searchPage = [[SearchPageViewController alloc] init];
    [self.navigationController pushViewController:searchPage animated:YES];
}

#pragma mark - 构建循环滚动banner图
- (void)bannerImageScrollView{
    _scrollView = [[MainPageBannerScrollView alloc] initWithFrame:CGRectMake(64, 0, self.view.width, 200)];
    MainPageBannerModel * bannerModel = [MainPageBannerModel bannerModelWithImageNameAndBannerTitleArray];
    _scrollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    _scrollView.imageNameArray = bannerModel.imageNameArrar;
    _scrollView.PageControlShowStyle = UIPageControlShowStyleRight;
    _scrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _scrollView.pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     NSString * identifier = [NSString stringWithFormat:@"cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
    MainPageCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil){
        cell = [[MainPageCell alloc] initWithReuseIdentifier:identifier del:self];
    } else {
        [cell cleanUpSubviews];
    }
//    {
//        //删除cell的所有子视图
//        while ([cell.contentView.subviews lastObject] != nil)
//        {
//            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
//        }
//    }
    if (indexPath.row == 7) {
        [cell addSubview:self.collectionView];
    }
    
    cell.maintext.text = _strName;
    [cell.image1 setImageWithURL:_strImage];
    cell.lab1.text = _strName1;
    cell.lab2.text = _strName1;
    cell.pricelab.text = _strPrice;
    cell.oldlab.text = _strOld;
    [cell.imagePath setImageWithURL:_strImagePath];
    cell.backgroundColor = [UIColor clearColor];
    cell.mainindexPath = indexPath;
    
    [cell setMainPageCell];
    
    return cell;
}


//设置cell
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

//设置高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [UIScreen mainScreen].bounds.size.height - 160;
    CGFloat cellhight = [UIScreen mainScreen].bounds.size.height - height;
    
    if (0 == indexPath.row)
        return cellhight ;
    else if(1 == indexPath.row)
        return 59.5;
    else if(2 == indexPath.row)
        return 7.5;
    else if(3 == indexPath.row)
        return 153;
    else if(4 == indexPath.row)
        return 153;
    else if(5 == indexPath.row)
        return 7.5;
    else if(6 == indexPath.row)
        return 29;
    else if(7 == indexPath.row)
        return 425;
//    else if(8 == indexPath.row)
//        return 29;
//    else if(9 == indexPath.row)
//        return 550;
    else
        return 160;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _maincell = [[MainPageCell alloc] init];
}

#pragma mark-加载数据方法
- (void)commodityDetails{
    //实现button跳转页面，在MainPageCell中；
}
- (void)recommendedColumn{
    //实现button跳转页面，在MainPageCell中；
}

//******************************************
//*******************************************
#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    if (section == 0) {
//        return 9;
//    }else if (section == 1){
//    return 9;
//    }else
    return _arr4.count;
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
    MainPageProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
    }
    cell.imgView.image = [UIImage imageNamed:@""];
    //   cell.text.text = [NSString stringWithFormat:@"Cell %ld",indexPath.row];
    [cell.imageShow setImageWithURL:_strImagePath];
    cell.titlelab.text = _strName;
    cell.labValueNew.text = _strPrice;
    cell.labValueOld.text = _strOld;
    
    return cell;

}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //边距占5*4=20 ，2个
    //图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
    return CGSizeMake((self.view.width)/3, 145);
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
    CommodityViewController * commodity = [[CommodityViewController alloc] init];
    [self.navigationController pushViewController:commodity animated:YES];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


#pragma mark - Requests产品详情
- (BOOL)startRequest:(NSInteger)requestID{
    if ([super startRequest:requestID]) {
        if (requestID == 101) {
            [_client bannerAdvertising:1];
        }else if (requestID == 102){
            [_client advertisementsCentral:2];
            [self startRequest:103];
        }else if (requestID == 103){
            [_client advertisementsTail:3];
        }else if (requestID == 104) {
            [_client mainPageDeals:[_ad_id intValue]];
        }
        return YES;
    }
    return NO;
}
- (BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result{
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 101) {
            NSArray * arr = [result getArrayForKey:@"data"];
            //获取banner图图片;
            for (NSInteger i = 0; i < arr.count; i++) {
                _dic1 = [NSMutableDictionary dictionary];
                _dic1 = [arr objectAtIndex:i];
                NSString * strImage = [_dic1 objectForKey:@"ad_image"];
                NSString * ad_idtitle = [_dic1 objectForKey:@"ad_id"];
                adIdCenter = ad_idtitle;
            }
            
            [self startRequest:102];
        }else if (sender.requestID == 102){
            NSArray * arr2 = [result getArrayForKey:@"data"];
            
            for (NSInteger j = 0; j < arr2.count; j ++) {
                _dic2 = [NSMutableDictionary dictionary];
                _dic2 = [arr2 objectAtIndex:j];
                _strImage = [_dic2 objectForKey:@"ad_image"];
                _strName = [_dic2 objectForKey:@"ad_name"];
                _ad_idcenter = [_dic2 objectForKey:@"ad_id"];
                adIdCenter = _ad_idcenter;  //把_ad_idcenter取到的ad_id值传给adIdCenter；
            }
            
            
            [self startRequest:103];
        }else if (sender.requestID == 103){
            NSArray * arr3 = [result getArrayForKey:@"data"];
            for (NSInteger k = 0; k < arr3.count; k ++) {
                _dic3 = [NSMutableDictionary dictionary];
                _dic3 = [arr3 objectAtIndex:k];
                _ad_id = [_dic3 objectForKey:@"ad_id"];
            }
            
            [self startRequest:104];
        }else if (sender.requestID == 104){
            _arr4 = [result getArrayForKey:@"data"];
            _arrName1 = [NSMutableArray array];
            for (NSInteger m = 0; m < _arr4.count; m ++) {
                _dic4 = [NSMutableDictionary dictionary];
                _dic4 = [_arr4 objectAtIndex:m];
                _strName1 = [_dic4 objectForKey:@"goods_name"];
                _strImagePath = [_dic4 objectForKey:@"goods_image"];
                _strPrice = [_dic4 objectForKey:@"goods_price"];
                _strOld = [_dic4 objectForKey:@"old_price"];
                _goods_idValue = [_dic4 objectForKey:@"goods_id"];
                goodsidValue = _goods_idValue; //
                [_arrName1 addObject:_strName1];
            }
        }
        [_tableView reloadData];
        return YES;
    }
    return NO;
}

@end
