//
//  NewClassStoreBtn.m
//  IOSProject
//
//  Created by IOS002 on 16/5/27.
//  Copyright © 2016年 CC Inc. All rights reserved.
//

#import "NewClassStoreBtn.h"

@implementation NewClassStoreBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(20, 0, contentRect.size.width - 20, contentRect.size.height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, 0, 15, contentRect.size.height);
}

@end
