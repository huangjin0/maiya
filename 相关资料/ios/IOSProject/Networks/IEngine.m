//
//  DFBEngine.m
//  DoctorFixBao
//
//  Created by Kiwi on 11/28/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import "IEngine.h"

#define KEY_Info @"KEY_Info"
#define KEY_ACC @"KEY_Info_ACC"
#define KEY_PASS @"KEY_Info_PASS"
#define KEY_HEADIMAGE @"KEY_HeadImage"
#define KEY_NICK @"KEY_NickName"

@implementation IEngine

+ (IEngine*)engine {
    return (id)[super engine];
}

- (void)loginWithDictionary:(NSDictionary*)dic {
    //    self.user = [User objectWithDictionary:dic];
    NSString *headStr = [dic getStringValueForKey:@"head_img" defaultValue:nil];
    if ([headStr hasPrefix:@"htttp"]) {
        self.headImage = headStr;
    } else {
        self.headImage = [NSString stringWithFormat:@"%@%@",DeFaultURL,headStr];
    }
//    self.headImage = [dic getStringValueForKey:@"head_img" defaultValue:nil];
    self.account = [dic getStringValueForKey:@"phone" defaultValue:nil];
    self.nickName = [dic getStringValueForKey:@"nack_name" defaultValue:nil];
    self.userintegral = [dic getStringValueForKey:@"user_integral" defaultValue:nil];
    self.sex = [dic getStringValueForKey:@"sex" defaultValue:nil];
    self.birthDay = [dic getStringValueForKey:@"birthday" defaultValue:nil];
    self.linkTel = [dic getStringValueForKey:@"tel" defaultValue:nil];
    self.loginKey = @"ucode";
    self.loginValue = [dic getStringValueForKey:@"ucode" defaultValue:nil];
    self.ownerId = [dic getStringValueForKey:@"uid" defaultValue:nil];
}

- (void)chageWithDic:(NSDictionary *)dic {
    NSString *headStr = [dic getStringValueForKey:@"head_img" defaultValue:nil];
    if ([headStr hasPrefix:@"htttp"]) {
        self.headImage = headStr;
    } else {
        self.headImage = [NSString stringWithFormat:@"%@%@",DeFaultURL,headStr];
    }
    self.nickName = [dic getStringValueForKey:@"nack_name" defaultValue:nil];
    self.sex = [dic getStringValueForKey:@"sex" defaultValue:nil];
    self.birthDay = [dic getStringValueForKey:@"birthday" defaultValue:nil];
    self.linkTel = [dic getStringValueForKey:@"tel" defaultValue:nil];
}

- (void)signout {
    [self deleteFromFile];
    self.account = nil;
    self.password = nil;
    self.nickName = nil;
    self.userintegral = nil;
    self.sex = nil;
    self.birthDay = nil;
    self.linkTel = nil;
    self.ownerId = nil;
    self.loginValue = nil;
}

- (void)readFromFile {
    [super readFromFile];
    self.loginKey = @"ucode";
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary * accDic = [def objectForKey:KEY_Info];
    if ([accDic isKindOfClass:[NSDictionary class]]) {
//        self.nickName = [accDic getStringValueForKey:@"nickName" defaultValue:nil];
//        self.account = [accDic getStringValueForKey:@"phoneNum" defaultValue:nil];
//        self.headImage = [accDic getStringValueForKey:@"headImg" defaultValue:nil];
//        self.ownerId = [accDic getStringValueForKey:@"uid" defaultValue:nil];
        self.account = [accDic getStringValueForKey:KEY_ACC defaultValue:nil];
        self.password = [accDic getStringValueForKey:KEY_PASS defaultValue:nil];
    }
}

- (void)saveToFile {
    [super saveToFile];
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary * accDic = [NSMutableDictionary dictionary];
    [accDic setObject:self.account forKey:KEY_ACC];
    [accDic setObject:self.password forKey:KEY_PASS];
    [def setObject:accDic forKey:KEY_Info];
    [def synchronize];
}

- (void)deleteFromFile {
    [super deleteFromFile];
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    [def removeObjectForKey:KEY_Info];
    [def synchronize];
}

@end
