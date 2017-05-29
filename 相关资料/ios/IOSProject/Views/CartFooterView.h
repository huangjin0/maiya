//
//  CartFooterView.h
//  IOSProject
//
//  Created by IOS002 on 15/7/13.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//


#import <UIKit/UIKit.h>

//添加代理，实现结算和全选功能
@protocol footerViewDelegate<NSObject>
@optional
-(void)settlementOrderList;
-(void)allSelectedOrderListWithState:(BOOL)state;
@end

@interface CartFooterView : UIView
//添加全选图片按钮
@property (nonatomic,strong)UIButton *allSelectbtn;
//添加总价格文本框，用于显示总价
@property (nonatomic,strong)UILabel  *allPricelabel;
//添加运费框，用于显示价格
@property (nonatomic,strong)UILabel  *allFreight;
//添加最大有运费框，用于显示最小免运费金额
@property (nonatomic,strong)UILabel *maxPrice;
//添加一个结算按钮
@property (nonatomic,strong)UIButton *settlementBtn;
//添加delegate
@property (nonatomic,weak) id<footerViewDelegate>delegate;

@end
