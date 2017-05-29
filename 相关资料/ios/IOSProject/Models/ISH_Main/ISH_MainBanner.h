//
//  ISH_MainBanner.h
//  IOSProject
//
//  Created by IOS002 on 16/6/2.
//  Copyright © 2016年 CC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISH_MainBanner : NSObject

@property (nonatomic,assign) NSInteger ad_id;
@property (nonatomic,strong) NSString *ad_name;
@property (nonatomic,strong) NSString *ad_image;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
