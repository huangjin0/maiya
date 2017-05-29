//
//  BannerDetailCell.m
//  IOSProject
//
//  Created by wkfImac on 15/7/8.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BannerDetailCell.h"
#import "CommodityViewController.h"
#import "BannerCollectionScrollView.h"
#import "BannerCollectionModel.h"
//#import "BannerAndDetailModel.h"

@implementation BannerDetailCell{
    BannerCollectionScrollView * _scrollView;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier del:(id)delegate{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _imageshow = [[UIImageView alloc]init];
        _titlelab = [[UILabel alloc] init];
        _labValueNew = [[UILabel alloc] init];
        _labValueOld = [[UILabel alloc] init];
        _delegate = delegate;
    }
    return self;
}

- (void)setBannerDetail:(NSArray *)bannerdetail{
    [self cleanUpSubviews];


    if (0 == _bannerindexPath.row) {
        //滚动banner图
        _scrollView = [[BannerCollectionScrollView alloc] initWithFrame:CGRectMake(0, -20, self.width , self.width - 20)];
        BannerCollectionModel * bannerModel = [BannerCollectionModel bannerModelWithImageNameAndBannerTitleArray];
        
        _scrollView.imageNameArray = bannerModel.imageNameArrar;
        _scrollView.PageControlShowStyle = UIPageControlShowStyleRight;
//        _scrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
//        _scrollView.pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
        [self.contentView addSubview:_scrollView];
    }
        for (NSInteger i = 1; i < 5; i++) {
        if (_bannerindexPath.row == i) {
            for (NSInteger j = 0; j < 2; j ++) {
                
                NSArray * arrColor = @[@"#ff0000",@"#757575"];
                
                UIButton * clickbtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width / 2 * j, 0, self.width / 2, 240)];
                [clickbtn addTarget:self action:@selector(returnProductDetails) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:clickbtn];
                
                _imageshow.frame = CGRectMake(self.width / 2 * j , 0, 150, 150);
                _imageshow.backgroundColor = [UIColor clearColor];
                [self.contentView addSubview:_imageshow];
                _titlelab.frame = CGRectMake(self.width / 2 * j+ 10, 150, self.width / 2 - 20, 20);
                _titlelab.textColor = [UIColor colorFromHexCode:@"#333333"];
                _titlelab.font = [UIFont systemFontOfSize:12];
                [self.contentView addSubview:_titlelab];
                
                //添加购物车标签
                UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(self.width / 2 * j + 130, 200, 20, 20)];
                [btn setImage:[UIImage imageNamed:@"addgouwu_ic_normal"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(successShoppingCart) forControlEvents:UIControlEventTouchUpInside];
                [clickbtn addSubview:btn];
                
                for (NSInteger p = 0; p < 2; p ++) {
                    UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(self.width / 2 * j + (10 + (p * 60)), 200, 30, 20)];
                    lab1.text = @"￥";
                    lab1.textColor = [UIColor colorFromHexCode:arrColor[p]];
                    [self.contentView addSubview:lab1];
                    _labValueNew.frame = CGRectMake(self.width / 2 * j + 20, 200, 60, 20);
                    _labValueNew.textColor = [UIColor colorFromHexCode:@"#ff0000"];
                    
                    _labValueOld.frame = CGRectMake(self.width / 2 * j + 80, 200, 60, 20);
                    _labValueOld.textColor = [UIColor colorFromHexCode:@"#757575"];
                    if (p == 0) {
                        lab1.font = [UIFont systemFontOfSize:11];
                        _labValueNew.font = [UIFont systemFontOfSize:15];
                    }
                    if (p == 1) {
                        lab1.font = [UIFont systemFontOfSize:9];
                        _labValueOld.font = [UIFont systemFontOfSize:11];
                    }
                    [self.contentView addSubview:_labValueNew];
                    [self.contentView addSubview:_labValueOld];
                }
                UIImageView * imageLine = [[UIImageView alloc] initWithFrame:CGRectMake(self.width / 2 * j + 70, 210, 45, 1)];
                imageLine.backgroundColor = [UIColor colorFromHexCode:@"757575"];
                [self.contentView addSubview:imageLine];
            }
            UIImageView * imageLine = [[UIImageView alloc] initWithFrame:CGRectMake(self.width / 2, 0, 1, 240)];
            imageLine.backgroundColor = [UIColor blackColor];
            [self.contentView addSubview:imageLine];
        }
    }
}

//提示加入购物车成功
- (void)successShoppingCart{
    UIAlertView * alart = [[UIAlertView alloc] initWithTitle:@"加入购物车成功" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alart show];
}

- (void)returnProductDetails{
    if (_delegate && [_delegate respondsToSelector:@selector(returnProductDetails)]) {
        [_delegate returnProductDetails];
    }
    UIViewController * viewcontroller = [BannerDetailCell viewController:self];
    CommodityViewController * commodity = [[CommodityViewController alloc] init];
    [viewcontroller.navigationController pushViewController:commodity animated:YES];
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
