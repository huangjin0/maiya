//
//  CommodityDetailBannerModel.h
//  IOSProject
//
//  Created by wkfImac on 15/7/6.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommodityDetailBannerModel : NSObject

@property (retain,nonatomic,readonly) NSArray * imageNameArrar;
//@property (retain,nonatomic,readonly) NSArray * imageDetailArrar;
@property (retain,nonatomic,readonly) NSArray * bannerTitleArray;
@property (retain,nonatomic,readonly) NSArray * arrcontent;

- (instancetype)initWithImageName;
- (instancetype)initWithImageNameAndBannerTitleArray;
+ (id)bannerModelWithImageName;
+ (id)bannerModelWithImageNameAndBannerTitleArray;

@end
