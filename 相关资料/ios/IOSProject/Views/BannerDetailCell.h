//
//  BannerDetailCell.h
//  IOSProject
//
//  Created by wkfImac on 15/7/8.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicCell.h"

@protocol bannerDetailDelegate <NSObject>

- (void)returnProductDetails;

@end

@interface BannerDetailCell : BasicCell

@property (assign,nonatomic)id<bannerDetailDelegate>delegate;

@property (strong, nonatomic) NSIndexPath * bannerindexPath;

@property (nonatomic,strong) UIImageView * imageshow;
@property (nonatomic,strong) UILabel * titlelab;
@property (nonatomic,strong) UILabel * labValueNew;
@property (nonatomic,strong) UILabel * labValueOld;

- (void)setBannerDetail:(NSArray *)bannerdetail;
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier del:(id)delegate;

@end
