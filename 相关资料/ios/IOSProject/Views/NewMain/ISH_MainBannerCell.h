//
//  ISH_MainBannerCell.h
//  IOSProject
//
//  Created by IOS002 on 16/6/1.
//  Copyright © 2016年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISH_MainBanner.h"
#import "SDCycleScrollView.h"

@interface ISH_MainBannerCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet SDCycleScrollView *bannerView;

@end
