//
//  MainPageBannerModel.m
//  IOSProject
//
//  Created by IOS002 on 15/6/1.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "MainPageBannerModel.h"

#define PATH [[NSBundle mainBundle]pathForResource:PLISTFILENAME ofType:nil]

@implementation MainPageBannerModel

- (instancetype)initWithImageName{
    self = [super init];
    if (self) {
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
