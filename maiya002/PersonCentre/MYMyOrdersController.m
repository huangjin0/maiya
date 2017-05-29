//
//  MYMyOrdersController.m
//  maiya002
//
//  Created by HuangJin on 16/9/17.
//  Copyright © 2016年 com. All rights reserved.
//

#import "MYMyOrdersController.h"
#define MYORDERSVC @"MYMyOrdersController"
@interface MYMyOrdersController()
@property (weak, nonatomic) IBOutlet UIView *myslideView;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIButton *all;

@property (weak, nonatomic) IBOutlet UIButton *prePay;
@property (weak, nonatomic) IBOutlet UIButton *preRevice;
@property (weak, nonatomic) IBOutlet UIButton *completed;
@property (weak, nonatomic) IBOutlet UIButton *refund;

@end
@implementation MYMyOrdersController
- (IBAction)tap:(UIButton *)sender forEvent:(UIEvent *)event {
    NSInteger tag=sender.tag;
  
    [self setSiledViewFrame:tag];

}

//滑动动画
-(void)setSiledViewFrame:(NSInteger)tag
{
    float width=[self getWidth];
    float height=_topView.frame.size.height;
    float x;
    if (tag==1) {
        x=11;
    }else
    {
        x=width*(tag-1)+(tag-1)*10+11;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.4f animations:^{
            
            [_myslideView setFrame:CGRectMake(x, height-2, width-5, 2)];
            
        }];
        
    });


}

-(CGFloat)getWidth
{

    
    return (kScreenWitdth-50)/5.0;

}
- (IBAction)slideAction:(id)btn {
     }

@end
