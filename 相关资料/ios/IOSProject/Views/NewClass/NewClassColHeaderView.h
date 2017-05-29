//
//  NewClassColHeaderView.h
//  IOSProject
//
//  Created by IOS002 on 16/5/27.
//  Copyright © 2016年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapHeaderBlock)(void);

@interface NewClassColHeaderView : UICollectionReusableView
@property (strong, nonatomic) IBOutlet UILabel *headTitleLab;

@property (strong, nonatomic) TapHeaderBlock block;

- (void)tapWithBlock:(TapHeaderBlock)block;

@end
