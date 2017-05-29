//
//  MYMainTabBarController.m
//  maiya002
//
//  Created by HuangJin on 16/9/10.
//  Copyright © 2016年 com. All rights reserved.
//

#import "MYMainTabBarController.h"

@interface MYMainTabBarController ()
@property(nonatomic,strong)MYHonePageController*homePageVC;
@property(nonatomic,strong)MYPersonCenterController*personCentreVC;
@property(nonatomic,strong)MYMainSearchController*searchVC;
@property(nonatomic,strong)MYBuyCarController*buyCarVC;
@end

@implementation MYMainTabBarController
-(MYHonePageController*)homePageVC
{
    if (_homePageVC==nil) {
        
        _homePageVC=[STORYBOAD_MAIN instantiateViewControllerWithIdentifier:HOMEPAGE_VC];
       
    }
    
    UITabBarItem*item=[[UITabBarItem alloc]initWithTitle:@"首页" image:IMAGE(@"home_ic_normal") selectedImage:IMAGE(@"home_ic_press")];
    _homePageVC.tabBarItem=item;
    return _homePageVC;

}
-(MYPersonCenterController*)personCentreVC
{
    if (_personCentreVC==nil) {
        
        _personCentreVC=[STORYBOAD_MAIN instantiateViewControllerWithIdentifier:PERSONCENTRE_VC];
       
        
    }
    UITabBarItem*item=[[UITabBarItem alloc]initWithTitle:@"个人中心" image:IMAGE(@"grcenter_ic_normal") selectedImage:IMAGE(@"grcenter_ic_press")];
    _personCentreVC.tabBarItem=item;
    
    return _personCentreVC;
    
}
-(MYMainSearchController*)searchVC
{
    if (_searchVC==nil) {
        
        _searchVC=[STORYBOAD_MAIN instantiateViewControllerWithIdentifier:MAINSRARCHVC_VC];
        
        
    }
    
    UITabBarItem*item=[[UITabBarItem alloc]initWithTitle:@"搜索" image:nil selectedImage:nil];
    _searchVC.tabBarItem=item;
    
    return _searchVC;
    
}
-(MYBuyCarController*)buyCarVC
{
    if (_buyCarVC==nil) {
        
        _buyCarVC=[STORYBOAD_MAIN instantiateViewControllerWithIdentifier:BUYCAR_VC];
        
    }
    UITabBarItem*item=[[UITabBarItem alloc]initWithTitle:@"购物车" image:nil selectedImage:nil];
    _buyCarVC.tabBarItem=item;

    
    return _buyCarVC;
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
//     [self.navigationController setNavigationBarHidden:YES animated:NO];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Second" image:nil tag:2];
    [item setFinishedSelectedImage:[UIImage imageNamed:@"second.png"]
       withFinishedUnselectedImage:[UIImage imageNamed:@"first.png"]];
//    viewController2.tabBarItem = item;
    
   
    self.viewControllers=@[NAV(self.homePageVC),NAV(self.personCentreVC),NAV(self.searchVC),NAV(self.buyCarVC)];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//      [self.navigationController setNavigationBarHidden:YES animated:NO];

}


@end
