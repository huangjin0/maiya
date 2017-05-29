//
//  MYBaseViewController.m
//  maiya002
//
//  Created by HuangJin on 16/9/10.
//  Copyright © 2016年 com. All rights reserved.
//

#import "MYBaseViewController.h"
#import "D5NavigationBar.h"
@interface MYBaseViewController ()

@end

@implementation MYBaseViewController

- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self setNavigationBarHidden:NO];
   
    [self setNavigationBarColor:[UIColor whiteColor]];
   
    [self setStatusBarStyle:UIBarStyleBlack];
    [self setNavigationTitleColor:[UIColor blackColor]];
    self.edgesForExtendedLayout=UIRectEdgeNone;
     [super viewDidLoad];
}

//- (void)changeLanguage {
//    @autoreleasepool {
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:LANGUAGE_CHANGED object:nil];
//        [self viewDidLoad];
//    }
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [self setNavigationBarHidden:NO];
  
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setStatusBarStyle:(UIBarStyle)style {
    [((D5NavigationBar *)self.navigationController.navigationBar) setBarStyle:style];
}

- (void)setNavigationBarHidden:(BOOL)isHide {
    [self.navigationController setNavigationBarHidden:isHide animated:NO];
}

- (void)setNavigationBarColor:(UIColor *)color {
    
    D5NavigationBar*bar=(D5NavigationBar *)self.navigationController.navigationBar;
   
    [self setNavigationBarWithColor:color];
}
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (void)setNavigationBarWithColor:(UIColor *)barColor {
    UIImage *image = [self imageWithColor:barColor];
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
}


- (void)setNavigationTitleColor:(UIColor *)color {
    //设置titile颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color, NSForegroundColorAttributeName, [UIFont fontWithName:FONT_NAME size:20], NSFontAttributeName, nil]];
}

- (void)setBackBarItem {
    [D5BarItem setLeftBarItemWithImage:VC_BACK_IMAGE target:self action:@selector(back)];
}

- (void)setLightContentBar {
    [self setNavigationBarHidden:NO];
    [self setStatusBarStyle:UIBarStyleBlack];
}

- (void)setNavigationBarTranslucent {
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsCompact];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    if ([self.navigationController.navigationBar respondsToSelector:@selector(shadowImage)])
    {
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }
    //    以上面4句是必须的,但是习惯还是加了下面这句话
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
}

- (void)setBlackBar {
    [self setNavigationBarHidden:NO];
    [self setStatusBarStyle:UIBarStyleDefault];
}


#pragma mark - back
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)pushVC:(UIViewController*)vc animation:(BOOL)animation;
{
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:animation];
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
