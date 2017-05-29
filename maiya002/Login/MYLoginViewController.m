//
//  MYLoginViewController.m
//  maiya002
//
//  Created by HuangJin on 16/9/12.
//  Copyright © 2016年 com. All rights reserved.
//

#import "MYLoginViewController.h"
#import "MYForgetPassworldController.h"
#import "MYMainTabBarController.h"

@interface MYLoginViewController ()
{
    

}
@property (weak, nonatomic) IBOutlet UITextField *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *clearUserName;
@property (weak, nonatomic) IBOutlet UITextField *passworldName;
@property (weak, nonatomic) IBOutlet UIButton *clearPassWorld;
@property(strong,nonatomic)MYForgetPassworldController*forgetPassVC;
@property(assign,nonatomic)BOOL remberStatus;

@end

@implementation MYLoginViewController

- (IBAction)clearPassworld:(id)sender {

    _passworldName.text=@"";
}

- (IBAction)clearUserName:(id)sender {

      _userNameLabel.text=@"";
}
- (IBAction)remeberPassworld:(UIButton*)sender {
    
    [sender setSelected:!sender.selected];
    _remberStatus=sender.selected;//是否记住密码，登录成功后更新是否记住密码

}
- (IBAction)forgetPassworld:(id)sender {
    
    [self.navigationController pushViewController:self.forgetPassVC animated:NO];
    
}
- (IBAction)login:(id)sender {

    if(![NSString isValidateString:_userNameLabel.text]){
        
        [Uinits showToastWithMessage:@"手机号码不能为空"];
        
        return;
    }
    if (![NSString valiMobile:_userNameLabel.text]) {
        
        [Uinits showToastWithMessage:@"请输入正确的手机号码"];
        return;
        
    }
     if(![NSString isValidateString:_passworldName.text ]){
        
        [Uinits showToastWithMessage:@"密码不能为空"];
        
        return;
    }
    
    if(_passworldName.text.length<6||_passworldName.text.length>12){
        
        [Uinits showToastWithMessage:@"密码必须是6-12位字母或者数字"];
        
        return;
    }
    
    [[HTTPClient shareAFNetClient] userLogInWithPhone:_userNameLabel.text password:_passworldName.text success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary*datas=responseObject;
        NSDictionary*status=datas[@"status"];
        NSInteger code=[status[@"code"] integerValue];
        if (code==0) {
            
            //是否记住密码
            [NSString setUserRemberPassStatus:_remberStatus];
            BOOL isRember=[NSString getUserRemberPassStatus];
            //  如果记住密码就存储密码
            if (isRember) {
                [_passworldName.text setUserPassToLoacl];
            }
            //存储手机号码到本地
            [_userNameLabel.text setUserNumberToLoacl];
            [self pushMainVC];
            
        }
        
    } faile:^(NSString *faile) {
         NSLog(@"%@",faile);
    }];
    
}

-(MYForgetPassworldController*)forgetPassVC
{
    if (_forgetPassVC==nil) {
        
        _forgetPassVC=[STORYBOAD_LOGIN instantiateViewControllerWithIdentifier:ForgetPassworldVC];
    }
    return _forgetPassVC;

}

-(void)pushMainVC{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        MYMainTabBarController* TabBarVc= [STORYBOAD_MAIN instantiateViewControllerWithIdentifier:MAINTABBARVC];
        [self.navigationController pushViewController:TabBarVc animated:YES];
        
    });
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.edgesForExtendedLayout=UIRectEdgeNone;
    
    _userNameLabel.text=[NSString getUserNumberToLoacl];
    
    if ([NSString getUserRemberPassStatus]) {
        
        _passworldName.text=[NSString getUserPassToLoacl];
    }

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
