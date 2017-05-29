//
//  ISH_MainImgCell.h
//  IOSProject
//
//  Created by IOS002 on 16/6/1.
//  Copyright © 2016年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISH_MainBanner.h"

@interface ISH_MainImgCell : UICollectionViewCell

@property (nonatomic,strong) ISH_MainBanner *item;
@property (strong, nonatomic) IBOutlet UIImageView *bannerImg;
@property (strong, nonatomic) IBOutlet UILabel *bannerTitle;

@end
