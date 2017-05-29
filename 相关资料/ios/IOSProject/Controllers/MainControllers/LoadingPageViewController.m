//
//  LoadingPageViewController.m
//  IOSProject
//
//  Created by IOS004 on 15/6/23.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//
//图文详情
//

#import "LoadingPageViewController.h"
//#import "LoadingPageCell.h"

@interface LoadingPageViewController ()<UITableViewDataSource,UITableViewDelegate>{
//    LoadingPageCell * loadingcell;
}

@property(nonatomic, strong)NSMutableArray *dataListOne;
@end

@implementation LoadingPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataListOne = [NSMutableArray array];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    LoadingPageCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = [UIColor whiteColor];
//    cell.loadingIndexPath = indexPath;
//    [cell loadingIndexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (NSInteger j = 0; j < 2; j ++) {
        
        NSArray * arr = @[@"向下拖动返回商品详情",@"规格参数"];
        if (indexPath.row == 0) {
            UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake( self.view.width / 2 - 55 * 30, 80, 200, 20)];
            lab1.text = arr[j];
            if (j == 0){
                lab1.textColor = [UIColor colorFromHexCode:@"#757575"];
                lab1.font = [UIFont systemFontOfSize:12];
            }
            if (j == 1){
                lab1.textColor = [UIColor colorFromHexCode:@"#333333"];
                lab1.font = [UIFont systemFontOfSize:15];
            }
            [cell.contentView addSubview:lab1];
            UIImageView * imageline = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width / 2 - 60  * 30, 90, -100 * 20, 1)];
            imageline.backgroundColor = [UIColor colorFromHexCode:@"#757575"];
            [cell.contentView addSubview:imageline];
            UIImageView * imageline1 = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.width / 2 + 70)* 30, 90, 100 * 20, 1)];
            imageline1.backgroundColor = [UIColor colorFromHexCode:@"#757575"];
            [cell.contentView addSubview:imageline1];
            }
        }
        if (indexPath.row == 2) {
            for (NSInteger k = 0; k < 5; k ++) {
                NSArray * arr = @[@"生产厂商:",@"净重:",@"保质期:",@"口味:",@"尺寸:"];
                NSArray * arr2 = @[@"鑫农丰",@"130g",@"6个月",@"略酸",@"20mm*20mm"];
                
            UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake( 44, 120 + k * 30, 100, 20)];
            lab1.text = arr[k];
            lab1.textColor = [UIColor colorFromHexCode:@"#333333"];
            lab1.font = [UIFont systemFontOfSize:12];
            [cell.contentView addSubview:lab1];
                UILabel * lab2 = [[UILabel alloc] initWithFrame:CGRectMake( 74, 120 + k * 30, 100, 20)];
                lab2.text = arr2[k];
                lab2.textColor = [UIColor colorFromHexCode:@"#999999"];
                lab2.font = [UIFont systemFontOfSize:12];
                [cell.contentView addSubview:lab2];
                if (k == 0) lab2.frame = CGRectMake(100, 120, 100, 20);
                if (k == 2) lab2.frame = CGRectMake(88, 180, 100, 20);
            }
            for (NSInteger p = 0; p < 4; p ++) {
                NSArray * arr = @[@"产地:",@"包装:",@"容量:",@"材质:"];
                NSArray * arr2 = @[@"成都",@"散装",@"30L",@"不锈钢"];
                
                UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake( 205, 120 + p * 30, 100, 20)];
                lab1.text = arr[p];
                lab1.textColor = [UIColor colorFromHexCode:@"#333333"];
                lab1.font = [UIFont systemFontOfSize:12];
                [cell.contentView addSubview:lab1];
                    UILabel * lab2 = [[UILabel alloc] initWithFrame:CGRectMake( 235, 120 + p * 30, 100, 20)];
                    lab2.text = arr2[p];
                    lab2.textColor = [UIColor colorFromHexCode:@"#999999"];
                    lab2.font = [UIFont systemFontOfSize:12];
                    [cell.contentView addSubview:lab2];
            }
        }
    if (indexPath.row == 3) {
        UILabel * lab2 = [[UILabel alloc] initWithFrame:CGRectMake( self.view.width / 2 - 25, 150, 200, 20)];
        lab2.text = @"图文详情";
        lab2.textColor = [UIColor colorFromHexCode:@"#333333"];
        lab2.font = [UIFont systemFontOfSize:12];
        [cell.contentView addSubview:lab2];
        UIImageView * imageline = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width / 2 -30, 160, -120, 1)];
        imageline.backgroundColor = [UIColor colorFromHexCode:@"#757575"];
        [cell.contentView addSubview:imageline];
        UIImageView * imageline1 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width / 2 + 40, 160, 120, 1)];
        imageline1.backgroundColor = [UIColor colorFromHexCode:@"#757575"];
        [cell.contentView addSubview:imageline1];
    }else if (indexPath.row == 4){
        //图文详情添加n = 接口数据；
        for (NSInteger n = 0; n < 3; n ++) {
            
            UIImageView * detailsImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 160 + n * 160, self.view.width, 120)];
            detailsImage.backgroundColor = [UIColor greenColor];
            [cell.contentView addSubview:detailsImage];
            UILabel * detailslab = [[UILabel alloc] initWithFrame:CGRectMake(0, 280 + n * 160, self.view.width, 40)];
            detailslab.text = @"零食大聚会哦大聚会";
            detailslab.font = [UIFont systemFontOfSize:15];
            [cell.contentView addSubview:detailslab];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return 44;
    if (indexPath.row == 1) return 44;
    if (indexPath.row == 2) return 120;
    if (indexPath.row == 3) return 120;
    if (indexPath.row == 4) return 120;
    if (indexPath.row == 5) return 120;
    else                    return 100;
    return 20;
}

@end
