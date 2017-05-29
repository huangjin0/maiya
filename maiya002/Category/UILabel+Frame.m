//
//  UILabel+Frame.m
//  maiya002
//
//  Created by HuangJin on 16/9/25.
//  Copyright © 2016年 com. All rights reserved.
//

#import "UILabel+Frame.h"

@implementation UILabel (Frame)

- (CGSize)boundingRectWithSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    
    CGSize retSize = [self.text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}
@end
