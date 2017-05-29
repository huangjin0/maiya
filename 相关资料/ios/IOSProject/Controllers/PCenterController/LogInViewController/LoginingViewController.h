//
//  loginingViewController.h
//  IOSProject
//
//  Created by IOS004 on 15/6/17.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicTableViewController.h"

@protocol logInDelegate <NSObject>

-(void)backToPerCenVCWithInfo:(NSDictionary *)info;

@end

@interface LoginingViewController : BasicTableViewController

@property (weak,nonatomic) id<logInDelegate>delegate;
@property (assign, nonatomic) BOOL statusToLogin;
@property (nonatomic,assign) BOOL isLogin;
@property (nonatomic,assign) NSInteger type;
@end
