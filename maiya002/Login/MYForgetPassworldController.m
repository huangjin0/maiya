//
//  MYForgetPassworldController.m
//  maiya002
//
//  Created by HuangJin on 16/9/13.
//  Copyright © 2016年 com. All rights reserved.
//

#import "MYForgetPassworldController.h"
#import "MYMainTabBarController.h"
#import "LoginModel.h"
@interface MYForgetPassworldController ()

@property (weak, nonatomic) IBOutlet UITextField *uerNameNumber;
@property(nonatomic,strong)NSTimer* verIDTimer;
@property(nonatomic,assign)NSInteger verIDInterval;

@end

@implementation MYForgetPassworldController

//注册
- (IBAction)regin:(id)sender {
    
    
    if(![NSString isValidateString:_uerNameNumber.text]){
        
        [Uinits showToastWithMessage:@"手机号码不能为空"];
        
        return;
    }
    if (![NSString valiMobile:_uerNameNumber.text]) {
        
        [Uinits showToastWithMessage:@"请输入正确的手机号码"];
        return;
        
    }
    if(![NSString isValidateString:_regin_CompleteCHA.text]){
        
        [Uinits showToastWithMessage:@"验证码能为空"];
        
        return;
    }
    if(![NSString isValidateString:_regin_setPass.text ]){
        
        [Uinits showToastWithMessage:@"密码不能为空"];
        
        return;
    }
    if(![NSString isValidateString:_regin_qrpass.text ]){
        
        [Uinits showToastWithMessage:@"请再次输入密码"];
        
        return;
    }
    
    if(_regin_setPass.text.length<6||_regin_setPass.text.length>12){
        
        [Uinits showToastWithMessage:@"密码必须是6-12位字母或者数字"];
        
        return;
    }

    if(![_regin_setPass.text isEqualToString: _regin_qrpass.text]){
        
        [Uinits showToastWithMessage:@"两次输入密码不一致"];
        
        return;
    }


   [[HTTPClient shareAFNetClient]  userRegistWithPhone:_uerNameNumber.text passWord:_regin_setPass.text verifyCode:_regin_CompleteCHA.text success:^(id responseObject) {
      
       NSLog(@"%@",responseObject);
       NSDictionary*datas=responseObject;
       NSDictionary*status=[datas valueForKey:@"status"];
        NSInteger code= [status[@"code"]integerValue];
       if ( code==0) {
           
           NSDictionary*data=[datas valueForKey:@"data"];
          NSString*phone =[data valueForKey:@"phone"];
           NSString*pass=[data valueForKey:@"password"];
           //存储密码和手机号到本地保存
           [phone setUserNumberToLoacl];
//           if ([NSString getUserRemberPassStatus]) {
//               
//               [pass setUserPassToLoacl];
//           }
          
           [self pushMainVC];
       }else if(code==1006)
       {
             [Uinits showToastWithMessage:@"用户已经注册，可以直接登录"];
           [self.navigationController popViewControllerAnimated:YES];
       
       }
       
       
       
       
   } faile:^(NSString *faile) {
       
       NSLog(@"%@",faile);
       
   }];
    
    
}


//验证码
- (IBAction)sendVERID:(id)sender {
    
    if(![NSString isValidateString:_uerNameNumber.text]){
        
         [Uinits showToastWithMessage:@"手机号码不能为空"];
        
        return;
    }
    if (![NSString valiMobile:_uerNameNumber.text]) {
     
        [Uinits showToastWithMessage:@"请输入正确的手机号码"];
        return;
        
    }
    _verIDInterval=60;
   _verIDTimer= [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(hideVerID) userInfo:nil repeats:YES];
    
    [[HTTPClient shareAFNetClient]userGetRegistCodeWithPhone:_uerNameNumber.text success:^(id responseObject) {
      
        
    } progress:^(NSProgress *progress) {
        
        
    } faile:^(NSString *faile) {
        
        
    }];
}

-(void)pushMainVC{

    dispatch_async(dispatch_get_main_queue(), ^{
        
        MYMainTabBarController* TabBarVc= [STORYBOAD_MAIN instantiateViewControllerWithIdentifier:MAINTABBARVC];
        [self.navigationController pushViewController:TabBarVc animated:YES];
        
    });
  
    
}

-(void)hideVerID
{
    if (_verIDInterval==0) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [_regin_getCompleteCHA setUserInteractionEnabled:YES];
            [_regin_getCompleteCHA setTitle:@"获取验证码" forState:UIControlStateNormal];
            [_verIDTimer invalidate];
            _verIDTimer=nil;
            return ;
        });
 
        
    }else{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [_regin_getCompleteCHA setUserInteractionEnabled:NO];
        [_regin_getCompleteCHA setTitle:[NSString stringWithFormat:@"重新获取(%ldS)",_verIDInterval] forState:UIControlStateNormal];
        _verIDInterval--;
    });
    }
    

}

-(void)showErrorMessage:(NSString*)title
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow.rootViewController.view animated:YES];
    
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = title;
    // Move to bottm center.
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    hud.backgroundColor=[UIColor colorWithHex:0x4c4c4c alpha:1.0];
    hud.tintColor=[UIColor whiteColor];
    [hud hideAnimated:YES afterDelay:3.f];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
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
