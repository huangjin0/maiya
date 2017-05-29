//
//  CommodityDetailsViewController.m
//  IOSProject
//
//  Created by IOS002 on 15/6/6.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//
/**
 商品详情页
 */


#import "CommodityDetailsViewController.h"
#import "MainPageBannerScrollView.h"
#import "MainPageBannerModel.h"
#import "LoadingViewController.h"


@interface CommodityDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    MainPageBannerScrollView * _scrollView;
}

@end

@implementation CommodityDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addBackButtonToNavigation];
 //   _shouldHideNavigationBar = YES;
    self.subTableViewController = [[LoadingViewController alloc] init];
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 500, 200)];
    button.backgroundColor = [UIColor blackColor];
    [self.view addSubview:button];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//返回单元格个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
//定制单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identify = @"identify";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.backgroundColor = [UIColor clearColor];
    
    NSArray * arrValue = @[@"30.00",@"40.00"];
    NSArray * arrColor = @[@"#ff0000",@"#dfdfdd"];
    NSArray * arrC = @[@"#489925",@"#ff0000",@"dededd"];
    
    if (0 == indexPath.row) {
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(20, -10, self.view.width - 40, 20)];
        lab.text = @"商品标题商品标题商品标题商品标题商品标题商品标题商品标题";
        lab.textColor = [UIColor colorFromHexCode:@"#333333"];
        lab.font = [UIFont systemFontOfSize:15];
        lab.numberOfLines = 2;
        [cell addSubview:lab];
        
        for (NSInteger i = 0; i < 2; i ++) {
        UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(20 + (i * 60), 30, 30, 20)];
        lab1.text = @"￥";
        lab1.font = [UIFont systemFontOfSize:11];
        lab1.textColor = [UIColor colorFromHexCode:arrColor[i]];
            [cell addSubview:lab1];
        UILabel * lab2 = [[UILabel alloc] initWithFrame:CGRectMake(30 + (i * 60), 30, 60, 20)];
        lab2.text = arrValue[i];
        lab2.textColor = [UIColor colorFromHexCode:arrColor[i]];
        lab2.font = [UIFont systemFontOfSize:15];
            [cell addSubview:lab2];
        }
        UIImageView * imageLine = [[UIImageView alloc] initWithFrame:CGRectMake(80, 40, 50, 1)];
        imageLine.backgroundColor = [UIColor colorFromHexCode:@"dfdfdd"];
        [cell addSubview:imageLine];
        for (NSInteger j = 0; j < 3; j ++) {
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(20 + (j * 60), 60, 50, 10)];
            lab.text = @"菲律宾进口";
            lab.textColor = [UIColor whiteColor];
            lab.backgroundColor = [UIColor colorFromHexCode:arrC[j]];
            lab.layer.cornerRadius = 5.0;
            lab.layer.masksToBounds = YES;
            lab.font = [UIFont systemFontOfSize:9];
            lab.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:lab];
        }
    }else if (1 == indexPath.row){
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
        imageView.backgroundColor = [UIColor colorFromHexCode:@"dededd"];
        [cell addSubview:imageView];
    }else if (2 == indexPath.row){
        cell.textLabel.text = @"商品评价（1136）";
    }else if (3 == indexPath.row){
        UIButton * phonebtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 7.5, self.view.width - 40, 44)];
        [phonebtn setTitle:@"电话速购" forState:UIControlStateNormal];
        [phonebtn addTarget:self action:@selector(telephoneTesco) forControlEvents:UIControlEventTouchUpInside];
        phonebtn.backgroundColor = [UIColor colorFromHexCode:@"#489925"];
        [cell addSubview:phonebtn];
    }
    return cell;
}
//设置高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.row)
        return 80;
    else if (1 == indexPath.row)
        return 10;
    else if (2 == indexPath.row)
        return 90;
    else if (3 == indexPath.row)
        return 60;
    else if (4 == indexPath.row)
        return 60;
    else if (5 == indexPath.row)
        return 60;
    else
        return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerview = [[UIView alloc] initWithFrame:CGRectMake(0,-40, self.view.width, self.view.width - 20)]; //创建一个视图
    headerview.backgroundColor = RGBCOLOR(243, 243, 243);
    headerview.backgroundColor = [UIColor whiteColor];
    tableView.tableHeaderView = headerview;
    if (section == 0) {
    
    _scrollView = [[MainPageBannerScrollView alloc] initWithFrame:CGRectMake(0, -20, self.view.width , self.view.width - 20)];
    MainPageBannerModel * bannerModel = [MainPageBannerModel bannerModelWithImageNameAndBannerTitleArray];
    
    _scrollView.imageNameArray = bannerModel.imageNameArrar;
    _scrollView.PageControlShowStyle = UIPageControlShowStyleRight;
    _scrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _scrollView.pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
    [headerview addSubview:_scrollView];
    
    UIButton * returnbtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 50, 50, 30)];
    returnbtn.backgroundColor = [UIColor clearColor];
    [returnbtn setImage:[UIImage imageNamed:@"back2_ic_normal"] forState:UIControlStateNormal];
    [returnbtn addTarget:self action:@selector(returnback) forControlEvents:UIControlEventTouchUpInside];
    [returnbtn.layer setCornerRadius:returnbtn.width / 2];
    [headerview addSubview:returnbtn];
    }
    return headerview;
}

- (void)returnback{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)telephoneTesco{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
