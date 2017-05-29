//
//  MYPersonCenterController.m
//  maiya002
//
//  Created by HuangJin on 16/9/10.
//  Copyright © 2016年 com. All rights reserved.
//

#import "MYPersonCenterController.h"
#import "MYPersonInformationController.h"
#import "MYMyOrdersController.h"
@interface MYPersonCenterController()
@property (weak, nonatomic) IBOutlet UIView *topPersonInformation;

@property (weak, nonatomic) IBOutlet UIButton *lookForAllorders;
@property(nonatomic,strong)MYPersonInformationController *pserCentre;
@property(nonatomic,strong)MYMyOrdersController *oderList;


@end
@implementation MYPersonCenterController

//用户资料
- (IBAction)personInfromation:(id)sender {
    
    [self pushVC:self.pserCentre animation:NO];
}
//查看所有订单
- (IBAction)allOders:(id)sender {
    
    [self pushVC:self.oderList animation:YES];
//    [self.navigationController pushViewController:self.oderList animated:YES];
}
//待付款
- (IBAction)preparePay:(id)sender {
}

// 待收货
- (IBAction)prepareRecive:(id)sender {
}
//已完成
- (IBAction)completeOrders:(id)sender {
}
//退款中
- (IBAction)refundOders:(id)sender {
}


//我的收藏
- (IBAction)myCollections:(id)sender {
}
//消息中心
- (IBAction)messageCentre:(id)sender {
}
//地址管理
- (IBAction)addressManage:(id)sender {
}
//联系我们
- (IBAction)linkeMe:(id)sender {
}

//密码修改
- (IBAction)passAlert:(id)sender {
}

//设置
- (IBAction)setting:(id)sender {
}

//配送订单
- (IBAction)distinctbuteOders:(id)sender {
}


-(MYPersonInformationController*)pserCentre
{
    if (_pserCentre==nil) {
        
        _pserCentre=[STORYBOAD_PERSON instantiateViewControllerWithIdentifier:PersonInformationVC];
    }
    return _pserCentre;

}

-(MYMyOrdersController*)oderList
{
    if (_oderList==nil) {
        
      _oderList=[STORYBOAD_PERSON instantiateViewControllerWithIdentifier:MYODERSVC];
    }
    
    return _oderList;
   

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigationController.navigationBarHidden = YES;
   
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    [self setNavigationBarHidden:NO];
    self.navigationController.navigationBarHidden = NO;
//    self.navigationController.navigationBar.translucent = YES;

}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    [self setNavigationBarTranslucent];
//    [self setNavigation];
   
    

}


@end
