//
//  BannerCollectionModel.m
//  IOSProject
//
//  Created by IOS004 on 15/7/11.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BannerCollectionModel.h"

#define PATH [[NSBundle mainBundle]pathForResource:PLISTFILENAME ofType:nil]

@implementation BannerCollectionModel

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

