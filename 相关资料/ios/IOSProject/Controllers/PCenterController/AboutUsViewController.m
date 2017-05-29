//
//  AboutUsViewController.m
//  IOSProject
//
//  Created by IOS004 on 15/6/9.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//
/**
 关于我们
 */

#import "AboutUsViewController.h"

@interface AboutUsViewController (){
    CGFloat _high;
    CGFloat _highImg;
}

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButtonToNavigation];
    
    
    if (ScreenHeight == 480) {
        _high = 300;
        _highImg = 60;
    }else if (ScreenHeight == 568){
        _high = 350;
        _highImg = 100;
    }else if (ScreenHeight == 667){
        _high = 420;
        _highImg = 150;
    }else{
        _high = 470;
        _highImg = 200;
    }
    
    self.navigationItem.title = @"关于我们";
    
    UIImageView * backgroud = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    backgroud.backgroundColor = [UIColor colorFromHexCode:@"Color_bkg_green"];
    [self.view addSubview:backgroud];
    
    UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width/2 - 40, 60, 80, 80)];
    imageview.image = [UIImage imageNamed:@"iSH_HomeLogo"];
    [self.view addSubview:imageview];
    
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width/2 - 25, 186, 60, 20)];
    lab.text = @"i生活";
    lab.textColor = [UIColor colorFromHexCode:@"#757575"];
    lab.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:lab];
    
    for (NSInteger i = 0; i < 2; i ++) {
        UIImageView * lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(10 + i * (self.view.width/2 + 20), 195, self.view.width/2 - 40, 1)];
        lineImage.backgroundColor = [UIColor colorFromHexCode:@"#dfdfdd"];
        [self.view addSubview:lineImage];
        
        NSArray * arr = @[@"扫描二维码",@"您的朋友也可以下载i生活APP"];
        UILabel * labText = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth / 2 - 150, _high + i * 20, 300, 30)];
        labText.text = arr[i];
        labText.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:labText];
    }
    UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth / 2 - (_highImg + 10) / 2, 220, _highImg + 10, _highImg)];
    image.image = [UIImage imageNamed:@"iSH_Erweima"];
    [self.view addSubview:image];
    
    UIButton * phonebtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width/2 - 100, self.view.height - 120, 200, 20)];
    [phonebtn setTitle:@"客服电话:(0834-3283366)" forState:UIControlStateNormal];
    [phonebtn setTitleColor:[UIColor colorFromHexCode:@"#757575"] forState:UIControlStateNormal];
    phonebtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    phonebtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:phonebtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
