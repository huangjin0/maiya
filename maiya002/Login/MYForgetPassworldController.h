//
//  MYForgetPassworldController.h
//  maiya002
//
//  Created by HuangJin on 16/9/13.
//  Copyright © 2016年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ForgetPassworldVC @"MYForgetPassworldController"

@interface MYForgetPassworldController : MYBaseViewController
@property (weak, nonatomic) IBOutlet UITextField *regin_UserName;

@property (weak, nonatomic) IBOutlet UIButton *regin_getCompleteCHA;

@property (weak, nonatomic) IBOutlet UITextField *regin_CompleteCHA;
@property (weak, nonatomic) IBOutlet UITextField *regin_setPass;
@property (weak, nonatomic) IBOutlet UITextField *regin_qrpass;

@property (weak, nonatomic) IBOutlet UIButton *regin;
@end
