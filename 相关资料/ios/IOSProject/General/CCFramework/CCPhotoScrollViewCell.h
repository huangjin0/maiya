//
//  CCPhotoScrollViewCell.h
//  CCFramework
//
//  Created by Kiwi on 10/20/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCPhotoScrollViewCell : UIView {
    
    CGRect _screenFrame;
    CGFloat _hw;
    CGFloat _std_hw;
}

@property (assign, nonatomic) id delegate;
@property (readonly, nonatomic) NSInteger index;

@property (strong, nonatomic) UIScrollView * scrollView;
@property (strong, nonatomic) UIImageView * imageView;
@property (assign, nonatomic) UIImage * image;

- (id)initWithIndex:(NSInteger)idx frame:(CGRect)frame;

@end
