//
//  ShoppingCartViewController.h
//  IOSProject
//
//  Created by IOS002 on 15/5/30.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicViewController.h"

@interface ShoppingCartViewController : BasicViewController
//用户校验码
//@property (nonatomic,strong) NSString *ucode;
@property (nonatomic,assign) BOOL isLoad;
@property (assign, nonatomic) NSInteger type;
@end
