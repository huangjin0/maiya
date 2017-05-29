//
//  UIImageAdditions.h
//  CCFramework
//
//  Created by kiwi on 6/5/13.
//  Copyright (c) 2013 Kiwi Private. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Additions)

+ (UIImage *)imageWithNoCache:(NSString*)name;
+ (UIImage *)rotateImage:(UIImage *)aImage;

- (UIImage *) renderAtSize:(const CGSize) size;
- (UIImage *) maskWithImage:(const UIImage *) maskImage;

+ (UIImage *)imageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

@end
