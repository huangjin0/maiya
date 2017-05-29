//
//  ISH_MainImgCell.m
//  IOSProject
//
//  Created by IOS002 on 16/6/1.
//  Copyright © 2016年 CC Inc. All rights reserved.
//

#import "ISH_MainImgCell.h"

@implementation ISH_MainImgCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setItem:(ISH_MainBanner *)item {
    [_bannerImg setImageWithURL:[ISH_ImgUrl ish_imgUrlWithStr:item.ad_image] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor] cornerRadius:0.0]];
    _bannerTitle.text = item.ad_name;
}

@end
