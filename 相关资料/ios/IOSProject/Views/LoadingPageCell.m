//
//  LoadingPageCell.m
//  IOSProject
//
//  Created by wkfImac on 15/7/4.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "LoadingPageCell.h"

@implementation LoadingPageCell

- (void)loadingpagecell{
    [self cleanUpSubviews];  //继承Basiccell，来优化tableview界面；
    
    if (_loadingIndexPath.row == 0) {
    UILabel * labtext = [[UILabel alloc] initWithFrame:CGRectMake(self.width / 2 - 60, 40, 120, 20)];
            labtext.text = @"向下拖动返回商品详情";
            labtext.textColor = [UIColor colorFromHexCode:@"#757575"];
            labtext.font = [UIFont systemFontOfSize:12];
            labtext.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:labtext];
    
            UIImageView * imageline = [[UIImageView alloc] initWithFrame:CGRectMake(20 , 50, self.width / 2 - 85 , 1)];
            imageline.backgroundColor = [UIColor colorFromHexCode:@"#757575"];
            [self.contentView addSubview:imageline];
            UIImageView * imageline1 = [[UIImageView alloc] initWithFrame:CGRectMake(self.width / 2 + 65, 50, self.width / 2 - 85 , 1)];
            imageline1.backgroundColor = [UIColor colorFromHexCode:@"#757575"];
            [self.contentView addSubview:imageline1];
        }else if (_loadingIndexPath.row == 1){
            for (NSInteger i = 0; i < 2; i ++) {
                NSArray * arrText = @[@"规格参数",@"图文详情"];
    
            UILabel * labtext = [[UILabel alloc] initWithFrame:CGRectMake(self.width / 2 - 40, 10 + 180 * i, 80, 20)];
            labtext.text = arrText[i];
            labtext.textColor = [UIColor colorFromHexCode:@"#333333"];
            labtext.font = [UIFont systemFontOfSize:15];
            labtext.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:labtext];
    
            UIImageView * imageline = [[UIImageView alloc] initWithFrame:CGRectMake(20 , 20 + 180 * i, self.width / 2 - 60 , 1)];
            imageline.backgroundColor = [UIColor colorFromHexCode:@"#757575"];
            [self.contentView addSubview:imageline];
            UIImageView * imageline1 = [[UIImageView alloc] initWithFrame:CGRectMake(self.width / 2 + 40, 20 + 180 * i, self.width / 2 - 60 , 1)];
            imageline1.backgroundColor = [UIColor colorFromHexCode:@"#757575"];
            [self.contentView addSubview:imageline1];
            }
    
            for (NSInteger k = 0; k < 5; k ++) {
                NSArray * arr = @[@"生产厂商:",@"净重:",@"保质期:",@"口味:",@"尺寸:"];
                NSArray * arr2 = @[@"鑫农丰",@"130g",@"6个月",@"略酸",@"20mm*20mm"];
    
                UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake( 44, 40 + k * 30, 100, 20)];
                lab1.text = arr[k];
                lab1.textColor = [UIColor colorFromHexCode:@"#333333"];
                lab1.font = [UIFont systemFontOfSize:12];
                [self.contentView addSubview:lab1];
                UILabel * lab2 = [[UILabel alloc] initWithFrame:CGRectMake( 74, 40 + k * 30, 100, 20)];
                lab2.text = arr2[k];
                lab2.textColor = [UIColor colorFromHexCode:@"#999999"];
                lab2.font = [UIFont systemFontOfSize:12];
                [self.contentView addSubview:lab2];
                if (k == 0) lab2.frame = CGRectMake(100, 40, 100, 20);
                if (k == 2) lab2.frame = CGRectMake(88, 100, 100, 20);
            }
            for (NSInteger p = 0; p < 4; p ++) {
                NSArray * arr = @[@"产地:",@"包装:",@"容量:",@"材质:"];
                NSArray * arr2 = @[@"成都",@"散装",@"30L",@"不锈钢"];
    
                UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake( 205, 40 + p * 30, 100, 20)];
                lab1.text = arr[p];
                lab1.textColor = [UIColor colorFromHexCode:@"#333333"];
                lab1.font = [UIFont systemFontOfSize:12];
                [self.contentView addSubview:lab1];
                UILabel * lab2 = [[UILabel alloc] initWithFrame:CGRectMake( 235, 40 + p * 30, 100, 20)];
                lab2.text = arr2[p];
                lab2.textColor = [UIColor colorFromHexCode:@"#999999"];
                lab2.font = [UIFont systemFontOfSize:12];
                [self.contentView addSubview:lab2];
            }
        }
    for (NSInteger n = 2; n < 4; n ++) {
    
        if (_loadingIndexPath.row == n){
    //        UIButton * detailbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 250)];
            UIImageView * imagedetail = [[UIImageView alloc] initWithFrame:CGRectMake(0, -10, self.width, 210)];
            imagedetail.image = [UIImage imageNamed:@"640"];
            [self.contentView addSubview:imagedetail];
            UILabel * textlab = [[UILabel alloc] initWithFrame:CGRectMake(0, 210, self.width, 40)];
            textlab.text = @"dajofpjafieaphfio";
            [self.contentView addSubview:textlab];
            UIImageView * imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 240, self.width, 1)];
            imageline.backgroundColor = [UIColor blackColor];
            [self.contentView addSubview:imageline];
        }
    }
}

@end
