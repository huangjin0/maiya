//
//  ViewController.m
//  maiya002
//
//  Created by HuangJin on 16/9/10.
//  Copyright © 2016年 com. All rights reserved.
//

#import "ViewController.h"
#import "MYMainTabBarController.h"
#import "MYLoginViewController.h"

@interface ViewController ()
{
MYMainTabBarController*TabBarVc;
MYLoginViewController*loginVC;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BOOL islogin=YES;
    if(islogin==YES)
    {
       TabBarVc= [STORYBOAD_MAIN instantiateViewControllerWithIdentifier:MAINTABBARVC];
        [[UIApplication sharedApplication]keyWindow].rootViewController=TabBarVc;
    }else
    {
     loginVC=[STORYBOAD_LOGIN instantiateViewControllerWithIdentifier:LoginViewVC];
    
        [self.navigationController pushViewController:loginVC animated:NO];
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
