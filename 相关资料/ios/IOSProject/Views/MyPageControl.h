//
//  MyPageControl.h
//  IOSProject
//
//  Created by IOS004 on 15/8/26.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPageControl : UIPageControl{
//    UIImage * imagePageStateNormal;  //正常状态
//    UIImage * imagePageStateHighlight; //高亮状态
}
- (id)initWithFrame:(CGRect)frame;
@property (nonatomic, retain)UIImage * imagePageStateNormal;
@property (nonatomic, retain)UIImage * imagePageStateHighlight;

@end
