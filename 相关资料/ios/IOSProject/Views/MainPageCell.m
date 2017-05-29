//
//  MainPageCell.m
//  IOSProject
//
//  Created by IOS002 on 15/6/2.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "MainPageCell.h"
#import "MainPageBannerScrollView.h"
#import "MainPageBannerModel.h"
#import "CommodityViewController.h"
#import "BannerAndConnectionImageViewController.h"
#import "OrderDetailsViewController.h"
#import "CollectionManagementViewController.h"
#import "AllOrdersViewController.h"
#import "CCClient+Requests.h"
#import "MainPageViewController.h"
#import "CollectionViewCell.h"

//#import "CommodityDetailsViewController.h"

@implementation MainPageCell{
    UIButton                 * _orderInquirybtn;
    UIButton                 * _myCollectionbtn;
    UIButton                 * _phonePurchasebtn;
    UICollectionView         * _commodityCollection;
    MainPageBannerScrollView * _scrollView;
    NSArray                  * _mainarrText;
    NSArray                  * _mainarrImage;
    UILabel                  * _mainlabtext;
    UIImageView              * _image1;
    NSString * _strname;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier del:(id)delegate{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _maintext = [[UILabel alloc] init];
   //     _maintext.tag = 101;
        _image1 = [[UIImageView alloc] init];
   //     _image1.tag = 102;
        _lab1 = [[UILabel alloc] init];
     //   _lab1.tag = 103;
        _lab2 = [[UILabel alloc] init];
       // _lab2.tag = 104;
        _pricelab = [[UILabel alloc] init];
       // _pricelab.tag = 105;
        _imagePath = [[UIImageView alloc] init];
        //_imagePath.tag = 106;
        _oldlab = [[UILabel alloc] init];
        //_oldlab.tag = 107;
        _delegate = delegate;
        _delegate2 = delegate;
    }
    return self;
}

- (void) setMainPageCell {
    [self cleanUpSubviews];    //继承Basiccell，来优化tableview界面；
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    
    [self.delegate commodityDetails];
    [self.delegate2 recommendedColumn];
    
    //主界面显示内容，i和p值待参数传入；
    NSInteger A = 5;
//    NSInteger B = 9;  //麦芽特惠传入产品数量，上限30个；
//    NSInteger C = 9;  //麦芽热销传入产品数量，上限30个；
//    NSInteger m = B / 3;
//    NSInteger n = C / 3;
//    NSInteger q = B % 3;  //取模；
//    NSInteger p = C % 3;  //取模；
    
    NSArray * arrName = @[@"订购查询",@"我的收藏",@"电话速购"];
    NSArray * arrImage = @[@"home_dingdan_icon_normal",@"home_shoucang_icon_normal",@"dianhua_icon"];
    
    if (0 == _mainindexPath.row) {
        //显示主页面banner图
        _scrollView = [[MainPageBannerScrollView alloc] initWithFrame:CGRectMake(0, 0, w , 160)];
        MainPageBannerModel * bannerModel = [MainPageBannerModel bannerModelWithImageNameAndBannerTitleArray];
        
        _scrollView.imageNameArray = bannerModel.imageNameArrar;
        _scrollView.PageControlShowStyle = UIPageControlShowStyleRight;
        _scrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _scrollView.pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
        [self.contentView addSubview:_scrollView];
    }else if (1 == _mainindexPath.row){
        for (NSInteger i = 0; i < 3; i ++) {
        
        _orderInquirybtn = [[UIButton alloc] initWithFrame:CGRectMake(w / 3 * i,0, w / 3, 59.5)];
        UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake( (w / 3 * i),20, w / 3, 59.5)];
        lable.text = arrName[i];
            if (i < 2)
        lable.textColor = [UIColor colorFromHexCode:@"#60b63c"];
            if (i == 2) lable.textColor = [UIColor whiteColor];
        lable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lable];
        [self.contentView addSubview:_orderInquirybtn];
        UIImageView * image1 = [[UIImageView alloc] initWithFrame:CGRectMake(38 + (w / 3 * i), 0, 30, 30)];
        image1.image = [UIImage imageNamed:arrImage[i]];
        [self.contentView addSubview:image1];
            
        UIImageView * phoneimage = [[UIImageView alloc] initWithFrame:CGRectMake(w / 3 * 2,0, w / 3, 59.5)];
        phoneimage.backgroundColor = [UIColor colorFromHexCode:@"9ee083"];
        [_orderInquirybtn addSubview:phoneimage];
            
            if (i == 0)
                [_orderInquirybtn addTarget:self action:@selector(orderInquiry) forControlEvents:UIControlEventTouchUpInside];
            if (i == 1)
                [_orderInquirybtn addTarget:self action:@selector(myCollectionbtn) forControlEvents:UIControlEventTouchUpInside];
            if (i == 2)
                [_orderInquirybtn addTarget:self action:@selector(phonePurchasebtn) forControlEvents:UIControlEventTouchUpInside];
        }
    }else if (2 == _mainindexPath.row){
        
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, w, 7.5)];
        image.backgroundColor = [UIColor colorFromHexCode:@"#f8f8f8"];
        [self.contentView addSubview:image];
    }
    for (NSInteger i = 3; i < A; i++) {    //预留接口，添加推介栏图片,i从第3张开始；A = 赋值;
        if (i == _mainindexPath.row){
        
            //预留接口，添加推介栏图片，最多10张；
            UIButton * columnbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, w , 153)];
            [columnbtn addTarget:self action:@selector(recommendedColumn) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:columnbtn];
            //推荐栏图片
            _image1.frame = CGRectMake(0, 0, w, 125);
            [columnbtn addSubview:_image1];
            //推荐栏文字
            _maintext.frame = CGRectMake(10, 105, w, 66);
            _maintext.textColor = [UIColor colorFromHexCode:@"#757575"];
            _maintext.font = [UIFont systemFontOfSize:9];
            [columnbtn addSubview:_maintext];
            if (i < A - 1) {
                UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 148, w, 1)];
                image.backgroundColor = [UIColor colorFromHexCode:@"cacaca"];
                [self.contentView addSubview:image];
            }
        }
    }
    if (_mainindexPath.row == A){
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, w, 7.5)];
        image.backgroundColor = [UIColor colorFromHexCode:@"#f8f8f8"];
        [self.contentView addSubview:image];
    }else if (_mainindexPath.row == A + 1){
        UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, w, 29)];
        lable.text = @"   麦芽特惠";
        lable.backgroundColor = [UIColor whiteColor];
        lable.textColor = [UIColor blackColor];
        [self.contentView addSubview:lable];
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 5, 29)];
        image.backgroundColor = [UIColor colorFromHexCode:@"60b63c"];
        [self.contentView addSubview:image];
    }
//    for (m = 0; m < B / 3; m++) {
//        
//    if (_mainindexPath.row == A + m + 2){
//        for (NSInteger j = 0; j < 2; j ++) {
//        
//        UIImageView * imageHeight = [[UIImageView alloc] initWithFrame:CGRectMake(w / 3 + (w / 3) * j, 0, 1, 150)];
//        imageHeight.backgroundColor = [UIColor colorFromHexCode:@"cacaca"];
//        [self.contentView addSubview:imageHeight];
//        }
//        for (NSInteger k = 0; k < 3; k ++) {
//            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(w / 3 * k, 0, w / 3, 150)];
//            button.backgroundColor = [UIColor clearColor];
//            [button addTarget:self action:@selector(commodityDetails) forControlEvents:UIControlEventTouchUpInside];
//            [self.contentView addSubview:button];
//            _imagePath.frame = CGRectMake(10 + (w / 3 * k), 10, w / 3 - 20, 100);
//            [self.contentView addSubview:_imagePath];
//            _lab1.frame = CGRectMake(10 + (w / 3 * k), 110, w / 3 - 10, 20);
//       //     _lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10 + (w / 3 * k), 110, w / 3 - 10, 20)];
//            _lab1.font = [UIFont systemFontOfSize:9];
//            _lab1.textColor = [UIColor colorFromHexCode:@"#333333"];
//            [self.contentView addSubview:_lab1];
//            
//            _pricelab.frame = CGRectMake(10 + (w / 3 * k), 130, 100, 20);
//            _pricelab.textColor = [UIColor colorFromHexCode:@"#ff0000"];
//            _pricelab.font = [UIFont systemFontOfSize:12];
//            [self.contentView addSubview:_pricelab];
//            
//            _oldlab.frame = CGRectMake(80 + w / 3 * k, 130, 100, 20);
//            _oldlab.textColor = [UIColor colorFromHexCode:@"#757575"];
//            _oldlab.font = [UIFont systemFontOfSize:9];
//            [self.contentView addSubview:_oldlab];
//            
//            UIImageView * imageLine = [[UIImageView alloc] initWithFrame:CGRectMake(75 + (w / 3 * k), 140, 30, 1)];
//            imageLine.backgroundColor = [UIColor colorFromHexCode:@"#757575"];
//            [self.contentView addSubview:imageLine];
//        }
//    }
//        
//        if (q == 1)
//            if (_mainindexPath.row == A + m + 3) {
//                UIImageView * imageHeight = [[UIImageView alloc] initWithFrame:CGRectMake(w / 3, 0, 1, 150)];
//                imageHeight.backgroundColor = [UIColor colorFromHexCode:@"cacaca"];
//                [self.contentView addSubview:imageHeight];
//                UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, w / 3, 150)];
//                button.backgroundColor = [UIColor clearColor];
//                [button addTarget:self action:@selector(commodityDetails) forControlEvents:UIControlEventTouchUpInside];
//                [self.contentView addSubview:button];
//                
//                UIImageView * imagePath = [[UIImageView alloc] initWithFrame:CGRectMake(10 , 10, w / 3 - 20, 100)];
//                imagePath.image = [UIImage imageNamed:@"hongzao"];
//                [self.contentView addSubview:imagePath];
//                _lab2.frame = CGRectMake(5 , 110, w / 3 - 5, 20);
//            //    lab.text = @"商品标题，商品标题,商品标题";
//                _lab2.font = [UIFont systemFontOfSize:9];
//                _lab2.textColor = [UIColor colorFromHexCode:@"#333333"];
//                [self.contentView addSubview:_lab2];
//            }
//        if (q == 2)
//            if (_mainindexPath.row == A + m + 3) {
//                for (NSInteger j = 0; j < 2; j ++) {
//                    
//                    UIImageView * imageHeight = [[UIImageView alloc] initWithFrame:CGRectMake(w / 3 + (w / 3) * j, 0, 1, 150)];
//                    imageHeight.backgroundColor = [UIColor colorFromHexCode:@"cacaca"];
//                    [self.contentView addSubview:imageHeight];
//                }
//                for (NSInteger k = 0; k < 2; k ++) {
//                    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(w / 3 * k, 0, w / 3, 150)];
//                    button.backgroundColor = [UIColor clearColor];
//                    [button addTarget:self action:@selector(commodityDetails) forControlEvents:UIControlEventTouchUpInside];
//                    [self.contentView addSubview:button];
//                    
//                    UIImageView * imagePath = [[UIImageView alloc] initWithFrame:CGRectMake(10 + (w / 3 * k), 10, w / 3 - 20, 100)];
//                    imagePath.image = [UIImage imageNamed:@"hongzao"];
//                    [self.contentView addSubview:imagePath];
//                    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(5 + (w / 3 * k), 110, w / 3 - 5, 20)];
//                    lab.text = @"商品标题，商品标题,商品标题";
//                    lab.font = [UIFont systemFontOfSize:9];
//                    lab.textColor = [UIColor colorFromHexCode:@"#333333"];
//                    [self.contentView addSubview:lab];
//                }
//            }
//    }
//    if (_mainindexPath.row == A + 2){
//        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, w, 7.5)];
//        image.backgroundColor = [UIColor colorFromHexCode:@"#f8f8f8"];
//        NSLog(@"**************************%@",image);
//        [self.contentView addSubview:image];
//    }else if (_mainindexPath.row == A + 3){
//        UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, w, 29)];
//        lable.text = @"   麦芽热销";
//        lable.backgroundColor = [UIColor whiteColor];
//        lable.textColor = [UIColor blackColor];
//        [self.contentView addSubview:lable];
//        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 5, 29)];
//        image.backgroundColor = [UIColor colorFromHexCode:@"60b63c"];
//        [self.contentView addSubview:image];
//    }else if (_mainindexPath.row == A + m + 4){
//        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
//        UICollectionView * collec = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, 260) collectionViewLayout:layout];
  //      [self.contentView addSubview:collec];
 //   }
//    for (n = 0; n < C / 3; n ++) {
//    
//    if (_mainindexPath.row == A + m + n + 4){
//        for (NSInteger j = 0; j < 2; j ++) {
//            
//            UIImageView * imageHeight = [[UIImageView alloc] initWithFrame:CGRectMake(w / 3 + (w / 3) * j, 0, 1, 150)];
//            imageHeight.backgroundColor = [UIColor colorFromHexCode:@"cacaca"];
//            [self.contentView addSubview:imageHeight];
//        }
//        for (NSInteger k = 0; k < 3; k ++) {
//            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(w / 3 * k, 0, w / 3, 150)];
//            button.backgroundColor = [UIColor clearColor];
//            [button addTarget:self action:@selector(commodityDetails) forControlEvents:UIControlEventTouchUpInside];
//            [self.contentView addSubview:button];
//            
//            UIImageView * imagePath = [[UIImageView alloc] initWithFrame:CGRectMake(10 + (w / 3 * k), 10, w / 3 - 20, 100)];
//            imagePath.image = [UIImage imageNamed:@"hongzao"];
//            [self.contentView addSubview:imagePath];
//            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(5 + (w / 3 * k), 110, w / 3 - 5, 20)];
//            lab.text = @"商品标题，商品标题,商品标题";
//            lab.font = [UIFont systemFontOfSize:9];
//            lab.textColor = [UIColor colorFromHexCode:@"#333333"];
//            [self.contentView addSubview:lab];
//            
//            UILabel * pricelab = [[UILabel alloc] initWithFrame:CGRectMake(5 + (w / 3 * k), 130, 100, 20)];
//            pricelab.text = @"20.00";
//            pricelab.textColor = [UIColor colorFromHexCode:@"#ff0000"];
//            pricelab.font = [UIFont systemFontOfSize:12];
//            [self.contentView addSubview:pricelab];
//            
//            UILabel * oldlab = [[UILabel alloc] initWithFrame:CGRectMake(80 + w / 3 * k, 130, 100, 20)];
//            oldlab.text = @"30.00";
//            oldlab.textColor = [UIColor colorFromHexCode:@"#757575"];
//            oldlab.font = [UIFont systemFontOfSize:9];
//            [self.contentView addSubview:oldlab];
//            
//            UIImageView * imageLine = [[UIImageView alloc] initWithFrame:CGRectMake(75 + (w / 3 * k), 140, 30, 1)];
//            imageLine.backgroundColor = [UIColor colorFromHexCode:@"#757575"];
//            [self.contentView addSubview:imageLine];
//        }
//    }
//        if (p == 1)
//            if (_mainindexPath.row == A + m + n + 5) {
//                UIImageView * imageHeight = [[UIImageView alloc] initWithFrame:CGRectMake(w / 3, 0, 1, 150)];
//                imageHeight.backgroundColor = [UIColor colorFromHexCode:@"cacaca"];
//                [self.contentView addSubview:imageHeight];
//                UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, w / 3, 150)];
//                button.backgroundColor = [UIColor clearColor];
//                [button addTarget:self action:@selector(commodityDetails) forControlEvents:UIControlEventTouchUpInside];
//                [self.contentView addSubview:button];
//                
//                UIImageView * imagePath = [[UIImageView alloc] initWithFrame:CGRectMake(10 , 10, w / 3 - 20, 100)];
//                imagePath.image = [UIImage imageNamed:@"hongzao"];
//                [self.contentView addSubview:imagePath];
//                UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(5 , 110, w / 3 - 5, 20)];
//                lab.text = @"商品标题，商品标题,商品标题";
//                lab.font = [UIFont systemFontOfSize:9];
//                lab.textColor = [UIColor colorFromHexCode:@"#333333"];
//                [self.contentView addSubview:lab];
//            }
//        if (p == 2)
//            if (_mainindexPath.row == A + m + n + 5) {
//                for (NSInteger j = 0; j < 2; j ++) {
//                    
//                    UIImageView * imageHeight = [[UIImageView alloc] initWithFrame:CGRectMake(w / 3 + (w / 3) * j, 0, 1, 150)];
//                    imageHeight.backgroundColor = [UIColor colorFromHexCode:@"cacaca"];
//                    [self.contentView addSubview:imageHeight];
//                }
//                for (NSInteger k = 0; k < 2; k ++) {
//                    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(w / 3 * k, 0, w / 3, 150)];
//                    button.backgroundColor = [UIColor clearColor];
//                    [button addTarget:self action:@selector(commodityDetails) forControlEvents:UIControlEventTouchUpInside];
//                    [self.contentView addSubview:button];
//                    
//                    UIImageView * imagePath = [[UIImageView alloc] initWithFrame:CGRectMake(10 + (w / 3 * k), 10, w / 3 - 20, 100)];
//                    imagePath.image = [UIImage imageNamed:@"hongzao"];
//                    [self.contentView addSubview:imagePath];
//                    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(5 + (w / 3 * k), 110, w / 3 - 5, 20)];
//                    lab.text = @"商品标题，商品标题,商品标题";
//                    lab.font = [UIFont systemFontOfSize:9];
//                    lab.textColor = [UIColor colorFromHexCode:@"#333333"];
//                    [self.contentView addSubview:lab];
//                }
//            }
//    }
}

//订购查询跳转页面
- (void)orderInquiry{
    if (_delegate && [_delegate respondsToSelector:@selector(orderInquiry)]) {
        [_delegate orderInquiry];
    }
    UIViewController * vc = [MainPageCell viewController:self];
    AllOrdersViewController * orderDetails = [[AllOrdersViewController alloc] init];
    [vc.navigationController pushViewController:orderDetails animated:YES];
}

//我的收藏跳转页面
- (void)myCollectionbtn{
    if (_delegate && [_delegate respondsToSelector:@selector(myCollectionbtn)]) {
        [_delegate myCollectionbtn];
    }
    UIViewController * vc = [MainPageCell viewController:self];
    CollectionManagementViewController * collectionmanagement = [[CollectionManagementViewController alloc] init];
    collectionmanagement.ucode = self.ucode;
    [vc.navigationController pushViewController:collectionmanagement animated:YES];
}

//电话速购跳转页面
- (void)phonePurchasebtn{
    UIWebView * callWebview = [[UIWebView alloc] init];
    NSURL * telURL = [NSURL URLWithString:@"tel://10086"];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.contentView addSubview:callWebview];
}

//推荐栏点击跳转页面
- (void)recommendedColumn{
    if (_delegate2 && [_delegate2 respondsToSelector:@selector(recommendedColumn)]) {
        [_delegate2 recommendedColumn];
    }
    UIViewController * viewcontroller = [MainPageCell viewController:self];
    
    BannerAndConnectionImageViewController * banner = [[BannerAndConnectionImageViewController alloc] init];
    [viewcontroller.navigationController pushViewController:banner animated:YES];
}

//跳转到商品详情；
- (void)commodityDetails{
    if (_delegate && [_delegate respondsToSelector:@selector(commodityDetails)]) {
        [_delegate commodityDetails];
    }
    UIViewController * vc = [MainPageCell viewController:self];
    CommodityViewController * commodity = [[CommodityViewController alloc] init];
 //   CommodityDetailsViewController * commodity = [[CommodityDetailsViewController alloc] init];
    [vc.navigationController pushViewController:commodity animated:YES];
}

//神奇的东西,view中取到所在当前控制器
+ (UIViewController *)viewController:(UIView *)view{
    
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    return nil;
}


@end
