//
//  ResetPasswordViewController.h
//  IOSProject
//
//  Created by IOS002 on 15/6/4.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicTableViewController.h"

@interface ResetPasswordViewController : BasicTableViewController
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *codeStr;

@end
