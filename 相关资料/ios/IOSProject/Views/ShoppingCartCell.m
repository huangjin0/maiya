//
//  ShoppingCartCell.m
//  IOSProject
//
//  Created by IOS002 on 15/6/5.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "ShoppingCartCell.h"
#import "CommodityViewController.h"

#define WIDTH ([UIScreen mainScreen].bounds.size.width)

@implementation ShoppingCartCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier row:(NSInteger)row {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        是否选中按钮
        _isSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _isSelectBtn.frame = CGRectMake(0, 25, 40, 40);
        [_isSelectBtn setImage:[UIImage imageNamed:@"xuanzhong_no_ic.png"] forState:UIControlStateNormal];
        [_isSelectBtn setImage:[UIImage imageNamed:@"iSH_XuanZhong"] forState:UIControlStateSelected];
        _isSelectBtn.tag = row;
        [_isSelectBtn addTarget:self action:@selector(isSelectedBtnActionWithSender:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_isSelectBtn];
        
        UIView *tapView = [[UIView alloc] initWithFrame:CGRectMake(40, 0, ViewWidth - 40, 90)];
        tapView.backgroundColor = [UIColor clearColor];
//添加商品图片
        _goodsImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 75, 75)];
        [tapView addSubview:_goodsImgV];
        
//添加商品标题
        _goodsTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(85, 6, ViewWidth - 210, 30)];
        _goodsTitleLab.textColor = [UIColor colorFromHexCode:@"#333333"];
        _goodsTitleLab.backgroundColor = [UIColor clearColor];
        _goodsTitleLab.font = [UIFont systemFontOfSize:12];
        _goodsTitleLab.numberOfLines = 0;
        [tapView addSubview:_goodsTitleLab];
//是否有货
        _hasGoods = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth - 120, 60, 30, 20)];
        _hasGoods.layer.cornerRadius = 5.0;
        [tapView addSubview:_hasGoods];
//删除按钮
        UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(ViewWidth - 85, 42, 40, 40)];
        UIImageView *deleteImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 15, 25, 25)];
        deleteImg.image = [UIImage imageNamed:@"delete_ic_press"];
        [deleteBtn addSubview:deleteImg];
        [deleteBtn addTarget:self action:@selector(deleteBtnFromShopCart) forControlEvents:UIControlEventTouchUpInside];
        [tapView addSubview:deleteBtn];
        
        UIView *clearBackView = [[UIView alloc] initWithFrame:CGRectMake(80, 55, 84, 32)];
        clearBackView.backgroundColor = [UIColor clearColor];
        
        UIView *btnBackView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 74, 22)];
        btnBackView.backgroundColor = [UIColor blackColor];
        [clearBackView addSubview:btnBackView];
        
//购买商品的数量
        _numCountLab = [[UILabel alloc] initWithFrame:CGRectMake(22.5, 1, 29.5, 20)];
        _numCountLab.backgroundColor = [UIColor whiteColor];
        _numCountLab.textAlignment = NSTextAlignmentCenter;
        [btnBackView addSubview:_numCountLab];
        
        UIImageView *delImg = [[UIImageView alloc] initWithFrame:CGRectMake(0.5, 0.5, 21.5, 21)];
        delImg.image = [UIImage imageNamed:@"cut.png"];
        [btnBackView addSubview:delImg];
        
        UIImageView *addImg = [[UIImageView alloc] initWithFrame:CGRectMake(52, 0.5, 21.5, 21)];
        addImg.image = [UIImage imageNamed:@"add.png"];
        [btnBackView addSubview:addImg];
        
//减按钮
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(0, 0, 26, 32);
        [_deleteBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.tag = 11;
        _deleteBtn.backgroundColor = [UIColor clearColor];
        [clearBackView addSubview:_deleteBtn];
        
//加按钮
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.frame = CGRectMake(58, 0, 26, 32);
        [_addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _addBtn.tag = 12;
        _addBtn.backgroundColor = [UIColor clearColor];
        [clearBackView addSubview:_addBtn];
        [tapView addSubview:clearBackView];
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 90, ViewWidth, 10)];
        backView.backgroundColor = Color_bkg_lightGray;
        [self.contentView addSubview:backView];
        [self.contentView addSubview:tapView];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapcellAction)];
        [tapView addGestureRecognizer:tapGesture];
    }
    return self;
}


/**
 * 点击cell
 */
-(void)tapcellAction {
    if (_delegate != nil && [_delegate respondsToSelector:@selector(tapcellActionWith:)]) {
        [_delegate tapcellActionWith:self];
    }
}

/**
 * 点击删除按钮
 */
-(void)deleteBtnFromShopCart {
    if (_delegate != nil && [_delegate respondsToSelector:@selector(deleteGoods:)]) {
        [_delegate deleteGoods:self];
    }
}

/**
 *  给单元格赋值
 *
 *  @param goodsModel 里面存放各个控件需要的数值
 */
-(void)addTheValue:(ShoppingCartModel *)goodsModel
{
    NSString *imgStr;
    if ([goodsModel.imageName hasPrefix:@"http"]) {
        imgStr = goodsModel.imageName;
    } else {
        imgStr = [NSString stringWithFormat:@"%@%@",DeFaultURL,goodsModel.imageName];
    }
    [_goodsImgV setImageWithURL:imgStr placeholderImage:[UIImage imageNamed:@"goodsdef"]];
    _goodsTitleLab.text = goodsModel.goodsTitle;
    NSString *salePrice = [NSString stringWithFormat:@"￥%@",goodsModel.goodsPrice];
    NSString *oldPrice  = [NSString stringWithFormat:@"￥%@",goodsModel.oldPrice];
    
    UILabel *salepriceLabel = [UILabel singleLineText:salePrice font:[UIFont systemFontOfSize:15] wid:ViewWidth - 120 color:[UIColor colorFromHexCode:@"#ff0000"]];
    salepriceLabel.origin = CGPointMake(ViewWidth - salepriceLabel.width - 15, 6);
    [self.contentView addSubview:salepriceLabel];
    UILabel *oldPriceLabel = [UILabel singleLineText:oldPrice font:[UIFont systemFontOfSize:14] wid:ViewWidth - 120 color:[UIColor colorFromHexCode:@"#dfdfdd"]];
    oldPriceLabel.origin = CGPointMake(ViewWidth - oldPriceLabel.width - 15, 30);
    [self.contentView addSubview:oldPriceLabel];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(ViewWidth - oldPriceLabel.width - 20, 38, oldPriceLabel.width + 10, 0.5)];
    lineView.backgroundColor = [UIColor colorFromHexCode:@"dfdfdd"];
    [self.contentView addSubview:lineView];
    if (goodsModel.goodsPrice.floatValue == goodsModel.oldPrice.floatValue) {
        oldPriceLabel.hidden = YES;
        lineView.hidden = YES;
    } else {
        oldPriceLabel.hidden = NO;
        lineView.hidden = NO;
    }
    _numCountLab.text = [NSString stringWithFormat:@"%ld",(long)goodsModel.goodsNum];
    if (goodsModel.hasGoods) {
        _hasGoods.image = [UIImage imageNamed:@"iSH_hasGoods"];
        if (goodsModel.selectState)
        {
            _selectState = YES;
            _isSelectBtn.selected = YES;
        }else{
            _selectState = NO;
            _isSelectBtn.selected = NO;
        }
    } else {
        _hasGoods.image = [UIImage imageNamed:@"hasnoGoods"];
        _selectState = NO;
        _isSelectBtn.selected = NO;
        _isSelectBtn.userInteractionEnabled = NO;
    }
    NSArray *arr = @[@"#4fb6d0",@"#4fd1aa",@"#e7bc56"];
//    标签数组
    NSArray *tallyArr = goodsModel.tallyCount;
    UIFont *font = [UIFont systemFontOfSize:13];
    CGFloat labelX = 125;
    if (goodsModel.tallyCount.count > 3) {
        for (int i = 0; i < 3; i ++) {
            UILabel *label = [UILabel singleLineText:[tallyArr objectAtIndex:i] font:font wid:ViewWidth - 200 color:[UIColor whiteColor]];
            label.backgroundColor = [UIColor colorFromHexCode:[arr objectAtIndex:i]];
            label.origin = CGPointMake(labelX, 40);
            label.layer.cornerRadius = 3.0;
            label.layer.masksToBounds = YES;
            labelX += label.width + 5;
            if (labelX - 5 > ViewWidth - lineView.width - 10) {
                return;
            } else {
                [self.contentView addSubview:label];
            }
        }
    } else {
        for (int i = 0; i < goodsModel.tallyCount.count; i ++) {
            UILabel *label = [UILabel singleLineText:[tallyArr objectAtIndex:i] font:font wid:ViewWidth - 200 color:[UIColor whiteColor]];
            label.backgroundColor = [UIColor colorFromHexCode:[arr objectAtIndex:i]];
            label.layer.cornerRadius = 3.0;
            label.layer.masksToBounds = YES;
            label.origin = CGPointMake(labelX, 40);
            labelX += label.width + 5;
            if (labelX - 5 > ViewWidth - lineView.width - 10) {
                return;
            } else {
                [self.contentView addSubview:label];
            }
        }
    }
}

/**
 *  点击减按钮实现数量的减少
 *
 *  @param sender 减按钮
 */
-(void)deleteBtnAction:(UIButton *)sender
{
    [self.delegate Clickbtn:self andFlag:(int)sender.tag];
    
}
/**
 *  点击加按钮实现数量的增加
 *
 *  @param sender 加按钮
 */
-(void)addBtnAction:(UIButton *)sender
{
    [self.delegate Clickbtn:self andFlag:(int)sender.tag];
}

/**
 *  点击是否选中按钮
 */
-(void)isSelectedBtnActionWithSender:(UIButton *)sender {
    if (_delegate != nil && [_delegate respondsToSelector:@selector(isSelectedGoodsWithRow:)]) {
        [_delegate isSelectedGoodsWithRow:sender.tag];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
