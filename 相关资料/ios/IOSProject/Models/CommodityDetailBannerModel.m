//
//  CommodityDetailBannerModel.m
//  IOSProject
//
//  Created by wkfImac on 15/7/6.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "CommodityDetailBannerModel.h"
#import "CommodityViewController.h"

#define PATH [[NSBundle mainBundle]pathForResource:PLISTFILENAME ofType:nil]

@implementation CommodityDetailBannerModel

- (instancetype)initWithImageName{
    self = [super init];
    if (self) {
        _imageNameArrar = @[@"vip_pic",@"icon",@"hongzao",@"hongzao"];
    }
    return self;
}

- (instancetype)initWithImageNameAndBannerTitleArray{
    return [self initWithImageName];
}

+ (id)bannerModelWithImageName{
    return [[self alloc] initWithImageName];
}

+ (id)bannerModelWithImageNameAndBannerTitleArray{
    return [[self alloc] initWithImageNameAndBannerTitleArray];
}

@end
