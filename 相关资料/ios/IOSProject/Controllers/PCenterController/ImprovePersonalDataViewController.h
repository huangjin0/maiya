//
//  ImprovePersonalDataViewController.h
//  IOSProject
//
//  Created by IOS004 on 15/6/8.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicTableViewController.h"

@protocol BackPCDelegate <NSObject>

-(void)backToPCViewController;

@end

@interface ImprovePersonalDataViewController : BasicTableViewController

//头像
@property (nonatomic,strong) NSString *headImg;
//呢称
@property (nonatomic,strong) NSString *nickNam;
//性别
@property (nonatomic,strong) NSString *sex;
//出生日期
@property (nonatomic,strong) NSString *brithDate;
//联系电话
@property (nonatomic,strong) NSString *phoneNum;

@property (nonatomic,weak) id<BackPCDelegate>delegate;

- (void)toInPut;

@end
