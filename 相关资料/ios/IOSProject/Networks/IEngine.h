//
//  DFBEngine.h
//  DoctorFixBao
//
//  Created by Kiwi on 11/28/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import "CCEngine.h"
//#import "User.h"

@interface IEngine : CCEngine

//uid
@property (strong, nonatomic) NSString *ownerId;
//账号
@property (strong, nonatomic) NSString * account;
//密码
@property (strong, nonatomic) NSString * password;
//头像
@property (strong, nonatomic) NSString * headImage;
//呢称
@property (strong, nonatomic) NSString * nickName;
//联系电话
@property (strong, nonatomic) NSString * linkTel;
//性别
@property (strong, nonatomic) NSString * sex;
//出生日期
@property (strong, nonatomic) NSString * birthDay;
//用户积分
@property (strong, nonatomic) NSString *userintegral;
//@property (strong, nonatomic) User * user;
@property (strong, nonatomic) NSArray * sparepartsFilterItems;

@property (strong, nonatomic) NSString * deviceAPNSID;
@property (assign, nonatomic) BOOL canUseAPNS;

+ (IEngine*)engine;

- (void)loginWithDictionary:(NSDictionary*)dic;
- (void)chageWithDic:(NSDictionary *)dic;

- (void)signout;

@end
