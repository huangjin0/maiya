//
//  MainPageBannerModel.h
//  IOSProject
//
//  Created by IOS002 on 15/6/1.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainPageBannerModel : NSObject

@property (retain,nonatomic,readonly) NSArray * imageNameArrar;
@property (retain,nonatomic,readonly) NSArray * bannerTitleArray;

- (instancetype)initWithImageName;
- (instancetype)initWithImageNameAndBannerTitleArray;
+ (id)bannerModelWithImageName;
+ (id)bannerModelWithImageNameAndBannerTitleArray;

@end
