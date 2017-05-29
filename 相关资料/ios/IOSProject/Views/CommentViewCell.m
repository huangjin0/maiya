//
//  CommentViewCell.m
//  IOSProject
//
//  Created by IOS002 on 15/7/29.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "CommentViewCell.h"

@interface CommentViewCell ()<UITextViewDelegate>

@end

@implementation CommentViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *topBackImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, 10)];
        topBackImg.backgroundColor = Color_bkg_lightGray;
        [self.contentView addSubview:topBackImg];
        _goodsImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 80, 80)];
        [self.contentView addSubview:_goodsImg];
        
        _goodComment = [UIButton buttonWithType:UIButtonTypeCustom];
        _goodComment.frame = CGRectMake(110, 80, 20, 20);
        [_goodComment setBackgroundImage:[UIImage imageNamed:@"xuanzhong_no_ic"] forState:UIControlStateNormal];
        [_goodComment setBackgroundImage:[UIImage imageNamed:@"iSH_XuanZhong"] forState:UIControlStateSelected];
        _goodComment.tag = 1;
        [_goodComment addTarget:self action:@selector(addEvaluSelectWithSender:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_goodComment];
        
        _mediComment = [UIButton buttonWithType:UIButtonTypeCustom];
        _mediComment.frame = CGRectMake((ViewWidth - 260) / 3  + 160, 80, 20, 20);
        [_mediComment setBackgroundImage:[UIImage imageNamed:@"xuanzhong_no_ic"] forState:UIControlStateNormal];
        [_mediComment setBackgroundImage:[UIImage imageNamed:@"iSH_XuanZhong"] forState:UIControlStateSelected];
        _mediComment.tag = 2;
        [_mediComment addTarget:self action:@selector(addEvaluSelectWithSender:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_mediComment];
        
        _badsComment = [UIButton buttonWithType:UIButtonTypeCustom];
        _badsComment.frame = CGRectMake((ViewWidth - 260) / 3 * 2 + 210, 80, 20, 20);
        [_badsComment setBackgroundImage:[UIImage imageNamed:@"xuanzhong_no_ic"] forState:UIControlStateNormal];
        [_badsComment setBackgroundImage:[UIImage imageNamed:@"iSH_XuanZhong"] forState:UIControlStateSelected];
        _badsComment.tag = 3;
        [_badsComment addTarget:self action:@selector(addEvaluSelectWithSender:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_badsComment];
        NSArray *commentArr = @[@"好评",@"中评",@"差评"];
        for (int i = 0; i < 3; i ++) {
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(130 + i * ((ViewWidth - 260) / 3 + 50), 80, 30, 20)];
            label.text = commentArr[i];
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = RGBCOLOR(255, 95, 5);
            [self.contentView addSubview:label];
        }
        UIView *longlineView = [[UIView alloc] initWithFrame:CGRectMake(20, 110, ViewWidth - 40, 0.5)];
        longlineView.backgroundColor = Color_bkg_lightGray;
        [self.contentView addSubview:longlineView];
        
        _placeHolderLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 110.5, ViewWidth - 40, 30)];
        _placeHolderLab.text = @"请输入评价详细内容";
        _placeHolderLab.backgroundColor = [UIColor clearColor];
        _placeHolderLab.textColor = [UIColor colorFromHexCode:@"#757575"];
        _placeHolderLab.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_placeHolderLab];
        
        _commentText = [[UITextView alloc] initWithFrame:CGRectMake(20, 110.5, ViewWidth - 40, 85)];
        _commentText.backgroundColor = [UIColor clearColor];
        _commentText.font = [UIFont systemFontOfSize:16];
        _commentText.delegate = self;
        [self.contentView addSubview:_commentText];
    }
    return self;
}

-(void)setItem:(EvalModel *)item {
    _commentText.text = nil;
    _goodComment.selected = NO;
    _mediComment.selected = NO;
    _badsComment.selected = NO;
    [_salePrice removeFromSuperview];
    [_oldPrice removeFromSuperview];
    [_titleLabel removeFromSuperview];
    [_goodsImg setImageWithURL:item.goodsImg placeholderImage:[UIImage imageNamed:@"goodsdef"]];
    _titleLabel = [UILabel linesText:item.goodsTitle font:[UIFont systemFontOfSize:15] wid:ViewWidth - 180 lines:2];
    _titleLabel.origin = CGPointMake(100, 15);
    [self.contentView addSubview:_titleLabel];
    NSString *salePrice = [NSString stringWithFormat:@"￥%@",item.salesPrice];
    NSString *oldPrice = [NSString stringWithFormat:@"￥%@",item.oldPrice];
//    商品卖出价格
    _salePrice = [UILabel singleLineText:salePrice font:[UIFont systemFontOfSize:15] wid:ViewWidth - 120 color:[UIColor colorFromHexCode:@"#ff0000"]];
    _salePrice.origin = CGPointMake(ViewWidth - _salePrice.width - 15, 16);
    [self.contentView addSubview:_salePrice];
//    商品原始价格
    _oldPrice = [UILabel singleLineText:oldPrice font:[UIFont systemFontOfSize:14] wid:ViewWidth - 120 color:[UIColor colorFromHexCode:@"#dfdfdd"]];
    _oldPrice.origin = CGPointMake(ViewWidth - _oldPrice.width - 15, 46);
    [self.contentView addSubview:_oldPrice];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(ViewWidth - _oldPrice.width - 20, 54, _oldPrice.width + 10, 0.5)];
    lineView.backgroundColor = [UIColor colorFromHexCode:@"dfdfdd"];
    [self.contentView addSubview:lineView];
    if (item.salesPrice.floatValue == item.oldPrice.floatValue) {
        _oldPrice.hidden = YES;
        lineView.hidden = YES;
    } else {
        _oldPrice.hidden = NO;
        lineView.hidden = NO;
    }
    _isSelect = item.isEvalu;
    if (item.isEvalu) {
        switch ([item.evaluMass intValue]) {
            case 1:
                _goodComment.selected = YES;
                _mediComment.selected = NO;
                _badsComment.selected = NO;
                break;
            case 2:
                _mediComment.selected = YES;
                _goodComment.selected = NO;
                _badsComment.selected = NO;
                break;
            case 3:
                _badsComment.selected = YES;
                _goodComment.selected = NO;
                _mediComment.selected = NO;
                break;
            default:
                break;
        }
    }
    _commentText.text = item.content;
    if (_commentText.text.length == 0) {
        _placeHolderLab.hidden = NO;
    } else {
        _placeHolderLab.hidden = YES;
    }
}

-(void)addEvaluSelectWithSender:(UIButton *)sender {
    if (!_isSelect) {
        switch (sender.tag) {
            case 1:
                _goodComment.selected = YES;
                _isSelect = YES;
                break;
            case 2:
                _mediComment.selected = YES;
                _isSelect = YES;
                break;
            default:
                _badsComment.selected = YES;
                _isSelect = YES;
                break;
        }
    } else {
        switch (sender.tag) {
            case 1:
                if (_goodComment.selected) {
                    _goodComment.selected = NO;
                    _isSelect = NO;
                } else {
                    _goodComment.selected = YES;
                    _mediComment.selected = NO;
                    _badsComment.selected = NO;
                }
                break;
            case 2:
                if (_mediComment.selected) {
                    _mediComment.selected = NO;
                    _isSelect = NO;
                } else {
                    _mediComment.selected = YES;
                    _goodComment.selected = NO;
                    _badsComment.selected = NO;
                }
                break;
            default:
                if (_badsComment.selected) {
                    _badsComment.selected = NO;
                    _isSelect = NO;
                } else {
                    _badsComment.selected = YES;
                    _goodComment.selected = NO;
                    _mediComment.selected = NO;
                }
                break;
        }
    }
//    [self.commentText becomeFirstResponder];
    if (_delegate != nil && [_delegate respondsToSelector:@selector(selectEvalWithCell:tag:isSelect:)]) {
        [_delegate selectEvalWithCell:self tag:sender.tag isSelect:_isSelect];
    }
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1 ) {
//    if ([_commentText.text isEqualToString:@""]) {
        _placeHolderLab.hidden = NO;
    } else {
        _placeHolderLab.hidden = YES;
    }
        return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (_delegate !=nil && [_delegate respondsToSelector:@selector(addContentToModelWithcell:content:)]) {
        [_delegate addContentToModelWithcell:self content:_commentText.text];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
