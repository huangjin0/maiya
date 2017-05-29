//
//  BannerCollectionModel.h
//  IOSProject
//
//  Created by IOS004 on 15/7/11.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerCollectionModel : NSObject

@property (retain,nonatomic,readonly) NSArray * imageNameArrar;
@property (retain,nonatomic,readonly) NSArray * bannerTitleArray;
@property (retain,nonatomic,readonly) NSArray * arrcontent;

- (instancetype)initWithImageName;
- (instancetype)initWithImageNameAndBannerTitleArray;
+ (id)bannerModelWithImageName;
+ (id)bannerModelWithImageNameAndBannerTitleArray;

@end
