//
//  CommentViewCell.h
//  IOSProject
//
//  Created by IOS002 on 15/7/29.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EvalModel.h"
@class CommentViewCell;

@protocol selectEvalDelegate <NSObject>

-(void)selectEvalWithCell:(CommentViewCell *)cell tag:(NSInteger)tag isSelect:(BOOL)select;

-(void)tapTextViewWithCell:(CommentViewCell *)cell;
-(void)addContentToModelWithcell:(CommentViewCell *)cell content:(NSString *)content;

@end

@interface CommentViewCell : UITableViewCell <UITextViewDelegate> {
//    是否选择评论
    BOOL _isSelect;
}

//商品图片
@property (nonatomic,strong) UIImageView *goodsImg;
//商品标题
@property (nonatomic,strong) UILabel *titleLabel;
//商品卖出价格
@property (nonatomic,strong) UILabel *salePrice;
//商品原始价格
@property (nonatomic,strong) UILabel *oldPrice;
//评价文本框
@property (nonatomic,strong) UITextView *commentText;
//好评
@property (nonatomic,strong) UIButton *goodComment;
//中评
@property (nonatomic,strong) UIButton *mediComment;
//差评
@property (nonatomic,strong) UIButton *badsComment;
//默认显示
@property (nonatomic,strong) UILabel *placeHolderLab;
//是否重加载
@property (nonatomic,assign) BOOL isReload;
//添加代理
@property (nonatomic,strong) id<selectEvalDelegate>delegate;
//
@property (nonatomic,strong) EvalModel *item;

-(void)addEvaluSelectWithSender:(UIButton *)sender;

@end
