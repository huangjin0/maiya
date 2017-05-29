//
//  PerCenViewController.h
//  IOSProject
//
//  Created by IOS002 on 15/6/26.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicViewController.h"
#import "LogInView.h"

@interface PerCenViewController : BasicViewController

@property (nonatomic,assign) BOOL isLogIn;
@property (nonatomic,strong) LogInView *logInView;

@end
