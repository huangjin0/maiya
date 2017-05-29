//
//  LogInView.m
//  IOSProject
//
//  Created by IOS002 on 15/7/22.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "LogInView.h"

@implementation LogInView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)unlogInviewDidLoad {
    self.backgroundColor = Color_bkg_lightGray;
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, self.height)];
//    CGFloat scrollSize = self.height > 400 ? self.height : 400;
//    scrollView.contentSize = CGSizeMake(ViewWidth, scrollSize);
//    [self addSubview:scrollView];
    /**
     添加按钮及图标；
     */
    UIImageView * personalImage = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth/2 - 70, 65, 140, 140)];
    
    personalImage.image = [UIImage imageNamed:@"grcenter_pic"];
    [self addSubview:personalImage];
    
    UILabel * personalLable = [[UILabel alloc] initWithFrame:CGRectMake(ViewWidth/2 - 45, 245, 90, 15)];
    personalLable.text = @"您还未登录";
    personalLable.textColor = [UIColor grayColor];
    [self addSubview:personalLable];
    
    UIButton * loginbtn = [UIButton roundedRectButtonWithTitle:@"登录" color:RGBCOLOR(255, 95, 5) raduis:5.0];
    loginbtn.frame = CGRectMake(16, 290, ViewWidth - 32, 45);
    [loginbtn addTarget:self action:@selector(logInAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginbtn];
    UIButton * registerbtn = [UIButton roundedRectButtonWithTitle:@"注册" color:[UIColor colorFromHexCode:@"#dfdfdd"] raduis:5.0];
    registerbtn.frame = CGRectMake(16, 350, ViewWidth - 32, 45);
    [registerbtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:registerbtn];
}

-(void)logInAction {
    if (_delegate != nil && [_delegate respondsToSelector:@selector(clickLogInOrRegistertag:)]) {
        [_delegate clickLogInOrRegistertag:1];
    }
}

-(void)registerAction {
    if (_delegate != nil && [_delegate respondsToSelector:@selector(clickLogInOrRegistertag:)]) {
        [_delegate clickLogInOrRegistertag:2];
    }
}

@end
