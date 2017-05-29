//
//  CommodityViewController.m
//  IOSProject
//
//  Created by IOS004 on 15/6/24.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//
//商品详情
//

#import "CommodityViewController.h"
#import "LoadingPageViewController.h"
#import "ProductEvaluationViewController.h"
#import "LoadingViewController.h"
#import "CommodityDetailBannerModel.h"
#import "BannerDetailCell.h"
#import "MainPageViewController.h"
#import "LoginingViewController.h"
#import "GoodsCell.h"
#import "AdScrollView.h"
#import "AdDataModel.h"

#import "JXBAdPageView.h"

@interface CommodityViewController ()<UITableViewDataSource,UITableViewDelegate,logInDelegate,joinshoppingcartDelegate,commodityDetailDelegate>{
    
    NSString * _strGoodsContent;  //获取商品评价，显示一条
    NSString * _strGoodsName;     //获取用户昵称，显示一条
    NSString * _totalCount;       //string类型评价总数
    NSInteger _intCount;          //int类型评价总数
    NSString * _strName;
    NSString * _strImage;
    NSString * _strPrice;
    NSString * _strOld;
    NSArray  * _arrPrice;
    NSMutableArray * _arrDate;
    NSString * _strDatetime;   //显示评价时间
    NSArray  * _arrexpend;     //菲律宾进口显示数量
    NSMutableArray * _arrimagebanner; //banner图
    NSString * _strimage1;//banner图
    NSMutableDictionary * _dicgoods;
        NSInteger _goods_id;
    BOOL _choice;
    UIButton * _collectbtn;
    UIImageView * _hasgoods;
            NSInteger        _level;          //评价等级
    NSMutableArray * _arrTimeNow;
    NSMutableArray * _arrName;
    NSMutableArray * _arrContent;
    UIButton * _phonebtn;
    NSDictionary * _collectDic;
    NSString * _strstock;
    NSString * _strval;
    //加入购物车所需参数
    NSInteger   _goodsid;     //产品id
    NSInteger   _spec_id;      //规格id
    NSInteger   _shop_id;      //商品id
    NSString  * _goods_name;   //产品名
    NSString  * _goods_image;  //产品图片
    NSString  * _quantity;     //数量
    NSInteger _quantitycount;
    
    NSString  * _detail_spec_id;      //规格id
    NSString  * _detail_shop_id;      //商品id
}
@property (nonatomic, strong)JXBAdPageView * adView;
@end

NSString * strDescription = @"";
NSArray * arrBanner;

@implementation CommodityViewController

- (id)init{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    _level = 1;
    /**
     隐藏UINavigationBar
     显示：
     　　[self.navigationController setNavigationBarHidden:NO animated:YES];
     隐藏：
     　　[self.navigationController setNavigationBarHidden:YES animated:YES];
     隐藏返回键
     　　 self.navigationItem.hidesBackButton = YES;
     */
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.subTableViewController = [[LoadingViewController alloc] init];
    _shouldHideNavigationBar = YES;

    _arrimagebanner = [NSMutableArray array];
    
    _goods_id = [_strgoods_id integerValue];
    [self startRequest:101];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/**
 *返回单元格个数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

/**
 *定制单元格内容
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identify = @"identify";
    BasicCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell){
        cell = [[BasicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else
        [cell cleanUpSubviews];
    NSArray * arrColor = @[@"#ff0000",@"#dfdfdd"];
    NSArray * arrC = @[@"#489925",@"#ff0000",@"dededd"];

    if (0 == indexPath.row) {
        //显示商品信息
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.view.width - 40, 20)];
        lab.text = _strName;
        lab.textColor = [UIColor colorFromHexCode:@"#333333"];
        lab.font = [UIFont systemFontOfSize:15];
        lab.numberOfLines = 2;
        [cell.contentView addSubview:lab];
        NSString *salePri = _arrPrice[0];
        NSString *oldPri  = _arrPrice[1];
        for (NSInteger i = 0; i < 2; i ++) {
            UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(20 + (i * 70), 30, 30, 20)];
            lab1.text = @"￥";
            lab1.font = [UIFont systemFontOfSize:11];
            lab1.textColor = [UIColor colorFromHexCode:arrColor[i]];
            [cell.contentView addSubview:lab1];
            if (salePri.floatValue == oldPri.floatValue) {
                if (i == 1) {
                    lab1.hidden = YES;
                }
            }
        }
        UILabel * newPrice = [UILabel singleLineText:_arrPrice[0] font:[UIFont systemFontOfSize:15] wid:100 color:[UIColor colorFromHexCode:arrColor[0]]];
        newPrice.origin = CGPointMake(30, 30);
        [cell.contentView addSubview:newPrice];
        if (salePri.floatValue != oldPri.floatValue) {
            UILabel * oldPrice = [UILabel singleLineText:_arrPrice[1] font:[UIFont systemFontOfSize:14] wid:100 color:[UIColor colorFromHexCode:arrColor[1]]];
            oldPrice.origin = CGPointMake(100, 30);
            [cell.contentView addSubview:oldPrice];
            
            UIImageView * imageLine = [[UIImageView alloc] initWithFrame:CGRectMake(90, 40, oldPrice.width + 20, 1)];
            imageLine.backgroundColor = [UIColor colorFromHexCode:@"dfdfdd"];
            [cell.contentView addSubview:imageLine];
        }
        
        for (NSInteger j = 0; j < _arrexpend.count; j ++) {
            
            UILabel * labExpend = [UILabel singleLineText:_arrexpend[j] font:[UIFont systemFontOfSize:12] wid:100 color:[UIColor whiteColor]];
            labExpend.origin = CGPointMake(20 + j * (labExpend.width + 30), 55);
            labExpend.backgroundColor = [UIColor colorFromHexCode:arrC[j]];
            labExpend.layer.cornerRadius = 5.0;
            labExpend.layer.masksToBounds = YES;
            [cell.contentView addSubview:labExpend];
        }
        _hasgoods = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width - 60, 30, 30, 20)];
        if ([_strstock integerValue] - [_strval integerValue] > 0) {
            _hasgoods.image = [UIImage imageNamed:@"iSH_hasGoods"];
        }else{
            _hasgoods.image = [UIImage imageNamed:@"hasnoGoods"];
        }
        [cell.contentView addSubview:_hasgoods];
    }else if (1 == indexPath.row){
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
        imageView.backgroundColor = [UIColor colorFromHexCode:@"dededd"];
        [cell.contentView addSubview:imageView];
    }else if (2 == indexPath.row){
        //显示一条用户评价信息
        UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, 200, 30)];
        lab1.text = @"商品评价";
        lab1.textColor = [UIColor colorFromHexCode:@"#333333"];
        lab1.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:lab1];
        UILabel * labcount1 = [[UILabel alloc] initWithFrame:CGRectMake(80, 7, 20, 30)];
        labcount1.text = @"(";
        [cell.contentView addSubview:labcount1];
        NSInteger x;
        if (_intCount >= 100) {
            x = 115;
        }else{
            x = 110;
        }
        UILabel * labcount2 = [[UILabel alloc] initWithFrame:CGRectMake(x, 7, 20, 30)];
        labcount2.text = @")";
        [cell.contentView addSubview:labcount2];
        
        UILabel * lab2 = [[UILabel alloc] initWithFrame:CGRectMake(90, 8, 100, 30)];
        lab2.text = _totalCount;
        lab2.textColor = [UIColor colorFromHexCode:@"#333333"];
        lab2.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:lab2];
        UIImageView * arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width - 30, 10, 10, 15)];
        arrowImage.image = [UIImage imageNamed:@"xuanze_ic"];
        [cell.contentView addSubview:arrowImage];
        
        for (NSInteger i = 0; i < 2; i++) {
            
            UILabel * lab2 = [[UILabel alloc] initWithFrame:CGRectMake(20 + i * self.view.width / 2, 40, 200, 20)];
            lab2.textColor = [UIColor colorFromHexCode:@"#757575"];
            lab2.font = [UIFont systemFontOfSize:12];
            if (i == 0) lab2.text = _strGoodsName;
            if (i == 1) lab2.text = _strDatetime;
            [cell.contentView addSubview:lab2];
        }
        
        UILabel * labContent = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, self.view.width - 40, 30)];
        labContent.textColor = [UIColor colorFromHexCode:@"#757575"];
        labContent.font = [UIFont systemFontOfSize:12];
        labContent.text = _strGoodsContent;
        [cell.contentView addSubview:labContent];
    }else if (3 == indexPath.row){
        _phonebtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 7.5, self.view.width - 40, 44)];
        [_phonebtn setTitle:@"电话速购" forState:UIControlStateNormal];
        if ([_strstock integerValue] - [_strval integerValue] > 0) {
            _phonebtn.backgroundColor = RGBCOLOR(255, 95, 5);
            [_phonebtn addTarget:self action:@selector(telephoneTesco) forControlEvents:UIControlEventTouchUpInside];
        }else{
            _phonebtn.backgroundColor = [UIColor colorFromHexCode:@"#dededd"];//]@"#dededd"];
            [_phonebtn addTarget:self action:@selector(promptGoodsStock) forControlEvents:UIControlEventTouchUpInside];
        }
        [cell.contentView addSubview:_phonebtn];
    }
    return cell;
}


/**
 * 设置cell高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        
    if (0 == indexPath.row)
        return 80;
    else if (1 == indexPath.row)
        return 10;
    else if (2 == indexPath.row)
        return 90;
    else if (3 == indexPath.row)
        return 60;
    else
        return 20;
}
    
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerview = [[UIView alloc] init]; //创建一个视图
    headerview.backgroundColor = [UIColor clearColor];
    tableView.tableHeaderView = headerview;

    if (section == 0) {
        if (_arrimagebanner.count != 0) {
            _adView = [[JXBAdPageView alloc] initWithFrame:CGRectMake(0, -10, [UIScreen mainScreen].bounds.size.width, self.view.width - 20)];
            _adView.iDisplayTime = 4.0;
//            _adView.pageControl.dotImage = [UIImage imageNamed:@"101"];
//            _adView.pageControl.currentDotImage = [UIImage imageNamed:@"100"];
            _adView.pageControl.currentPageIndicatorTintColor = RGBCOLOR(255, 95, 5);
            _adView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
            [_adView startAdsWithBlock:_arrimagebanner block:^(NSInteger clickIndex) {
                NSLog(@"%ld",(long)clickIndex);
            }];
            [headerview addSubview:_adView];
        }
        //添加收藏功能
        _collectbtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width - 50, self.view.width - 100, 30, 30)];
        [_collectbtn addTarget:self action:@selector(choice) forControlEvents:UIControlEventTouchUpInside];
        [_collectbtn setImage:[UIImage imageNamed:@"iSH_shoucang_n"] forState:UIControlStateNormal];
        [_collectbtn setImage:[UIImage imageNamed:@"iSH_shoucang_p"] forState:UIControlStateSelected];
        if (_choice) {
            _collectbtn.selected = YES;
        } else {
            _collectbtn.selected = NO;
        }
        [headerview addSubview:_collectbtn];
        //添加返回按钮
        UIButton * returnbtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 50, 30)];
        returnbtn.backgroundColor = [UIColor clearColor];
        [returnbtn setImage:[UIImage imageNamed:@"iSH_Back"] forState:UIControlStateNormal];
        [returnbtn addTarget:self action:@selector(returnback) forControlEvents:UIControlEventTouchUpInside];
        [returnbtn.layer setCornerRadius:returnbtn.width / 2];
        [self.view addSubview:returnbtn];
    }
    return headerview;
}

/**
 *设置section高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.view.width - 40;
}

/**
 *cell的点击事件
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        ProductEvaluationViewController * product = [[ProductEvaluationViewController alloc] init];
        product.levgoods_id = _strgoods_id;
        [self.navigationController pushViewController:product animated:YES];
    }
}

- (void)returnback{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)telephoneTesco{
    UIWebView * callWebview = [[UIWebView alloc] init];
    NSURL * telURL = [NSURL URLWithString:@"tel://02886523627"];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebview];
}

//实现是否选中的方法
- (void)choice{
    if ([IEngine engine].isSignedIn) {
        if (_choice == YES) {
            _collectbtn.selected = NO;
            _choice = NO;
            [self startRequest:105];
            [CCAlertView showText:@"取消收藏" life:2.0];
        }else if (_choice == NO){
            _collectbtn.selected = YES;
            _choice = YES;
            [self startRequest:104];
            [CCAlertView showText:@"已收藏" life:1.0];
        }

    } else {
        [CCAlertView showText:@"请登录" life:2.0];
        LoginingViewController *logingVC = [[LoginingViewController alloc] init];
        logingVC.delegate = self;
        [self.navigationController pushViewController:logingVC animated:YES];
    }
}
//缺货提示
- (void)promptGoodsStock{
    [CCAlertView showText:@"本品缺货，我们会尽快补充" life:3.0];
}
- (void)valueOfQuantity:(NSString *)quantity{
    _quantity = quantity;
}
- (void)joinShoppingCartDetail{
    if ([IEngine engine].isSignedIn) {
        if ([_strstock integerValue] - [_strval integerValue] > 0) {
            [self startRequest:106];
        }else{
            [CCAlertView showText:@"本品缺货，我们会尽快补充" life:3.0];
        }
    } else {
        [CCAlertView showText:@"请登录" life:2.0];
        LoginingViewController *logingVC = [[LoginingViewController alloc] init];
        logingVC.delegate = self;
        [self.navigationController pushViewController:logingVC animated:YES];
    }
}
- (void)goodsidToCommodity:(NSString *)goodsid{
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    if (_firstAppear) {
//        [self startRequest:101];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Requests产品详情
- (BOOL)startRequest:(NSInteger)requestID{
    if ([super startRequest:requestID]) {
        if (requestID == 101) {
            [_client goodsInfo:_goods_id];//[goodsidValue intValue]];
        }else if (requestID == 102){
//            [_client productEvaluationList:_goods_id level:1];
            [_client productEvaluationList:_goods_id level:1 pageing:0];
        }else if (requestID == 103){
            [_client productEvaluationCount:_goods_id levelValueCount:0];
        }else if (requestID == 104){
            [_client addCollectGoodsWithGoodsId:(int)_goods_id];
        }else if (requestID == 105){
            [_client cancelCollectGoodsWithGoodsId:(int)_goods_id];
        }else if (requestID == 106){
            _goodsid = _goods_id;
            _spec_id = [_detail_spec_id integerValue];
            _shop_id = [_detail_shop_id integerValue];
            _goods_name = _strName;
            _goods_image = _strImage;
            _quantitycount = [_quantity integerValue];
            if (_quantity == nil) {
                _quantitycount = 1;
            }
            [_client userAddShopcartWithGoodsId:(int)_goodsid sperId:(int)_spec_id shopId:(int)_shop_id goodsName:_goods_name goodsImg:_goods_image quantity:(int)_quantitycount];
        }else if (requestID == 107){
            [_client collectionGoods:(int)_goods_id];
        }else if (requestID == 108){
            [_client userGetCartNum];
        }
        return YES;
    }
    return NO;
}

- (BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result{
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 101) {
            NSDictionary * dict = [result getDictionaryForKey:@"data"];

            _strName = [dict getStringValueForKey:@"goods_name" defaultValue:nil];
            _strImage = [dict getStringValueForKey:@"goods_image" defaultValue:nil];
            _strPrice = [dict getStringValueForKey:@"goods_price" defaultValue:nil];
            _strOld = [dict getStringValueForKey:@"old_price" defaultValue:nil];
            NSString * description = [dict getStringValueForKey:@"description" defaultValue:nil];
            _arrPrice = @[_strPrice,_strOld];
            _arrexpend = [dict getArrayForKey:@"expend1"]; //数组，显示菲律宾进口个数
            NSArray * arrImages = [dict getArrayForKey:@"images"];
            strDescription = description;
            _detail_shop_id = [dict getStringValueForKey:@"shop_id" defaultValue:nil];
            _detail_spec_id = [dict getStringValueForKey:@"spec_id" defaultValue:nil];
            _strstock = [dict objectForKey:@"stock"];
            _strval = [dict objectForKey:@"virtual_sales"];

            for (NSInteger i = 0; i < arrImages.count; i ++) {
                
                NSDictionary * dictionary = [arrImages objectAtIndex:i];
                _strimage1 = [dictionary getStringValueForKey:@"image_url" defaultValue:nil];
                if ([_strimage1 hasPrefix:@"http"]) {
                    [_arrimagebanner addObject:_strimage1];
                } else {
                    NSString * stringImage = [NSString stringWithFormat:@"%@%@", DeFaultURL, _strimage1];
                    [_arrimagebanner addObject:stringImage];
                }

            }
            [self startRequest:102];
        }else if (sender.requestID == 102){
            NSArray * arrgood = [result getArrayForKey:@"data"];
        //    NSDictionary * dicname = [result getDictionaryForKey:@"data"];
            _arrTimeNow = [NSMutableArray array];
            _arrName = [NSMutableArray array];
            _arrContent = [NSMutableArray array];
            for (NSInteger k = 0; k < arrgood.count; k ++) {
                _dicgoods = [NSMutableDictionary dictionary];
                _dicgoods = [arrgood objectAtIndex:0];
                _strGoodsContent = [_dicgoods getStringValueForKey:@"content" defaultValue:nil];
                NSString * strTime = [_dicgoods getStringValueForKey:@"create_time" defaultValue:nil];
                NSDictionary * dintionary = [arrgood objectAtIndex:0];
//                NSDictionary * userinfo = [dintionary objectForKey:@"userinfo"];
                NSDictionary *userinfo = [dintionary getDictionaryForKey:@"userinfo"];
                _strGoodsName = [userinfo getStringValueForKey:@"nack_name" defaultValue:nil];
                [_arrTimeNow addObject:strTime];
                [_arrName addObject:_strGoodsName];
                [_arrContent addObject:_strGoodsContent];
                //时间戳
                NSString * str_time = _arrTimeNow[0];
                NSTimeInterval time = [str_time integerValue];
                NSDate * date = [NSDate dateWithTimeIntervalSince1970:time];
                //实例化一个
                NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
                //设定时间格式
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSString * dateStr = [dateFormatter stringFromDate:date];
                _strDatetime = dateStr;
            }
            [self startRequest:103];
        }else if (sender.requestID == 103){
            NSDictionary * dicTotal = [result getDictionaryForKey:@"data"];
            _totalCount = [dicTotal getStringValueForKey:@"totalcount" defaultValue:nil];
            _intCount = [_totalCount intValue];
            if ([IEngine engine].isSignedIn) {
                [self startRequest:107];
            }
        }else if (sender.requestID == 104){
//          NSArray * arr = [result getArrayForKey:@"data"];
        }else if (sender.requestID == 105){
//          NSArray * arr = [result getArrayForKey:@"data"];
        }else if (sender.requestID == 106){
            [CCAlertView showText:@"加入购物车成功" life:1.0];
            [self startRequest:108];
        }else if (sender.requestID == 107){
            _collectDic = [result getDictionaryForKey:@"data"];
            NSDictionary *iscollect = [_collectDic getDictionaryForKey:@"is_collect"];
            NSString *collectStr = [iscollect getStringValueForKey:@"collect_id" defaultValue:nil];
            if (collectStr) {
                _choice = YES;
            } else {
                _choice = NO;
            }
        }else if (sender.requestID == 108){
            NSDictionary *data = [result getDictionaryForKey:@"data"];
            NSString *cartNum = [data getStringValueForKey:@"cart_number" defaultValue:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cartNum" object:nil userInfo:@{@"cartNum":cartNum}];
        }
        NSLog(@"%@",_arrimagebanner);
        [self.tableView reloadData];
        
        return YES;
    }
    return NO;
}
- (void)backToPerCenVCWithInfo:(NSDictionary *)info{
}
@end
