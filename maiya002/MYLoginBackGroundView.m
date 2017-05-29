//
//  MYLoginBackGroundView.m
//  maiya002
//
//  Created by HuangJin on 16/9/12.
//  Copyright © 2016年 com. All rights reserved.
//

#import "MYLoginBackGroundView.h"

@implementation MYLoginBackGroundView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
//    self.layer.cornerRadius=5.0f;
//    self.layer.borderWidth=1.0;
//    self.layer.borderColor=self.backgroundColor.CGColor;
    

}
- (void)drawRect:(CGRect)rect
{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat width=rect.size.width;
    CGFloat height=rect.size.height;
    CGFloat radius = (width + height) * 0.05;
     CGContextSetLineWidth(ctx, 2.0);
     CGContextSetLineJoin(ctx, kCGLineJoinRound);
     CGContextSetRGBStrokeColor(ctx, 0, 1, 0, 1);
    
    CGContextMoveToPoint(ctx, 0, height-15);
    
//    self.
    
    CGContextAddLineToPoint(ctx, 0, height);
//    CGContextAddArc(ctx, 5, height-5, 5, -0.5 * M_PI, 0.0, 1);
    // 渲染一次
//
      CGContextClosePath(ctx);
    // 3.绘制图形
//      CGContextStrokePath(ctx);
    
      CGContextMoveToPoint(ctx, 0, height);
    
    CGContextAddLineToPoint(ctx, width, height);
    CGContextClosePath(ctx);
    // 3.绘制图形
//    CGContextStrokePath(ctx);
    
    CGContextMoveToPoint(ctx, width, height);
//     CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextAddLineToPoint(ctx, width, height-15);
    // 关闭路径(连接起点和最后一个点)
    CGContextClosePath(ctx);
   
    //
   
    
    // 3.绘制图形
    CGContextStrokePath(ctx);
    
    
}


@end
