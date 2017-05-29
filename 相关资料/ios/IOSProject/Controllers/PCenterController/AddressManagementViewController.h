//
//  AddressManagementViewController.h
//  IOSProject
//
//  Created by IOS004 on 15/6/9.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicViewController.h"

@protocol backtoSettleVCDelegate <NSObject>

-(void)backToSettleVCWithDic:(NSDictionary *)dic;

@end

@interface AddressManagementViewController : BasicViewController

//用户校验码
@property (nonatomic,strong) NSString *ucode;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,weak) id<backtoSettleVCDelegate>delegate;

@end
