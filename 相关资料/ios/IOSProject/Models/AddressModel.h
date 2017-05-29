//
//  AddressModel.h
//  IOSProject
//
//  Created by IOS002 on 15/7/14.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *phone;
@property(nonatomic,strong) NSString *address;
@property(nonatomic,strong) NSString *area;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
