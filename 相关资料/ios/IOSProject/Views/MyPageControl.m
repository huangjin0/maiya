//
//  MyPageControl.m
//  IOSProject
//
//  Created by IOS004 on 15/8/26.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "MyPageControl.h"

@interface MyPageControl(private)

- (void)updateDots;

@end

@implementation MyPageControl

//@synthesize imagePageStateNormal = _imagePageStateNormal;
//@synthesize imagePageStateHighlight = _imagePageStateHighlight;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    return  self;
}

- (void)setImagePageStateNormal:(UIImage *)imagePageStateNormal{
    _imagePageStateNormal = imagePageStateNormal;
    [self updateDots];
}
- (void)setImagePageStateHighlight:(UIImage *)imagePageStateHighlight{
    _imagePageStateHighlight = imagePageStateHighlight;
    [self updateDots];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super endTrackingWithTouch:touch withEvent:event];
    [self updateDots];
}
- (void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    [self updateDots];
}
- (void)updateDots{
    if (_imagePageStateNormal && _imagePageStateHighlight) {
        NSArray * subview = self.subviews;
        for (NSInteger i = 0; i < [subview count]; i ++) {
//            UIImageView * dot = [subview objectAtIndex:i];
//            CGSize size = CGSizeMake(12, 12);
//            [dot setFrame:CGRectMake(dot.frame.origin.x, dot.frame.origin.y, size.width, size.height)];

//           dot.image = self.currentPage == i ? _imagePageStateNormal : _imagePageStateHighlight;
        }
    }
}

@end
