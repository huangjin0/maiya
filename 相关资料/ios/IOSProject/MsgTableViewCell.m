//
//  MsgTableViewCell.m
//  IOSProject
//
//  Created by IOS002 on 15/6/24.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "MsgTableViewCell.h"

static const CGFloat HeadImageWidth = 35;
static const CGFloat ConImageHeightMin = 50;
//static const CGFloat ConLocationHeight = 78;
//static const CGFloat ConShareHeight = 75;

@interface MsgTableViewCell () {
    UILabel * _labTime;
    UILabel * _lab;
}
@property (strong, nonatomic) UIImageView * messageBubble;
@end

@implementation MsgTableViewCell

CGSize contentImageSize(CGSize size) {
    CGFloat widthMain = [UIScreen mainScreen].bounds.size.width;
    CGFloat maxWidth = widthMain - (32 + HeadImageWidth) * 2 - 32;
    maxWidth = maxWidth * 0.7f;
    CGFloat maxHeight = maxWidth;
    CGSize res = CGSizeMake(size.width / 2, size.height / 2);
    if (size.height > size.width) {
        if (res.height > maxHeight) {
            CGFloat w_h = size.width / size.height;
            res.width = maxHeight * w_h;
            res.height = maxHeight;
        }
    } else {
        if (res.width > maxWidth) {
            CGFloat h_w = size.height / size.width;
            res.height = maxWidth * h_w;
            res.width = maxWidth;
        }
    }
    if (res.height < ConImageHeightMin) {
        CGFloat w_h = size.width / size.height;
        res.width = ConImageHeightMin * w_h;
        res.height = ConImageHeightMin;
    }
    if (res.width > maxWidth) {
        res.width = maxWidth;
    }
    return res;
}

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = [UIView new];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView * headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 10, HeadImageWidth, HeadImageWidth)];
        headImageView.tag = 600;
//        headImageView.image = [UIImage imageNamed:@"head_default"];
        [self.contentView addSubview:headImageView];
        headImageView.layer.cornerRadius = 17.5;
        headImageView.layer.masksToBounds = YES;
        self.headImageView = headImageView;
        
        UILabel * labTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 16)];
        labTime.tag = 601;
//        labTime.backgroundColor = RGBACOLOR(195, 195, 195, 0.8);
        labTime.font = [UIFont systemFontOfSize:10];
        labTime.textAlignment = NSTextAlignmentCenter;
        labTime.textColor = RGBACOLOR(111, 111, 111, 1);//RGBCOLOR(255, 255, 255);
        labTime.layer.masksToBounds = YES;
        labTime.layer.cornerRadius = 8;
        labTime.hidden = YES;
        [self.contentView addSubview:labTime];
        _labTime = labTime;
        
        UIImageView * imageContentView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, HeadImageWidth, HeadImageWidth)];
        imageContentView.tag = 602;
        imageContentView.layer.masksToBounds = YES;
        imageContentView.layer.cornerRadius = 4;
//        imageContentView.backgroundColor = [UIColor clearColor];
        imageContentView.clipsToBounds = YES;
        imageContentView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:imageContentView];
        self.contentImageView = imageContentView;
        UIImageView * messageBubble = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, HeadImageWidth, HeadImageWidth)];
        messageBubble.tag = 602;
        [self.contentView addSubview:messageBubble];
        messageBubble.userInteractionEnabled = YES;
        self.messageBubble = messageBubble;
    }
    return self;
}

-(void)setItem:(ChatMessage *)item {
    _item = item;
    [_lab removeFromSuperview];
    [self cleanUpSubviews];
    CGFloat widthMain = [UIScreen mainScreen].bounds.size.width;
    CGFloat maxWidth = widthMain - (32 + HeadImageWidth) * 2;

    CGFloat pointY = 10;
    _labTime.hidden = !item.needTimeLabel;
    if (item.needTimeLabel) {
        NSString *str = [NSDate simpleTextFromTimeInterval:item.interval];
        CGSize size = TextSize(str, _labTime.font);
        size.width += 16;
        _labTime.frame = CGRectMake((widthMain - size.width) / 2, pointY, size.width, _labTime.height);
        _labTime.text = str;
        pointY += 23;
    }
    if (item.status == 1) {
        _headImageView.frame = CGRectMake(widthMain - 16 - HeadImageWidth, pointY, HeadImageWidth, HeadImageWidth);
        NSString *headImgStr;
        if ([[IEngine engine].headImage hasPrefix:@"http"]) {
            headImgStr = [IEngine engine].headImage;
        } else {
            headImgStr = [NSString stringWithFormat:@"%@%@",DeFaultURL,[IEngine engine].headImage];
        }
        [_headImageView setImageWithURL:headImgStr placeholderImage:[UIImage imageNamed:@"iSH_HomeLogo"]];
    } else {
        _headImageView.frame = CGRectMake(16, pointY, HeadImageWidth, HeadImageWidth);
        [_headImageView setImage:[UIImage imageNamed:@"iSH_HomeLogo"]];
    }
    CGRect bkgFrame, conFrame; UIImage * cellBkg = nil;
    [_contentImageView removeFromSuperview];_messageBubble.hidden = YES;
    CGSize size = CGSizeMake(maxWidth - 18 - 6, 3000);
    UIFont * font = [UIFont systemFontOfSize:19];
    NSString * str = item.text;
    size = TextSize_MutiLine(str, font, size);
    NSInteger wid = size.width * 2.0f / 2, hei = size.height * 2.0f / 2;
    if (item.status == 1) {
        cellBkg = [[UIImage imageNamed:@"bkg_message_msg_R"] resizableImageWithCapInsets:UIEdgeInsetsMake(25, 6, 6, 12)];
        conFrame = CGRectMake(widthMain - (16 + 10 + HeadImageWidth) - 9 - 5 - wid, pointY + 9, size.width, size.height);
        bkgFrame = CGRectMake(conFrame.origin.x - 9, pointY, wid + 18 + 6, hei + 18);
    } else {
        cellBkg = [[UIImage imageNamed:@"bkg_message_msg_L"] resizableImageWithCapInsets:UIEdgeInsetsMake(25, 12, 6, 6)];
        conFrame = CGRectMake((16 + 10 + HeadImageWidth) + 6 + 9, pointY + 9, size.width, size.height);
        bkgFrame = CGRectMake(conFrame.origin.x - 9 - 6, pointY, wid + 18 + 6, hei + 18);
    }
    _messageBubble.image = cellBkg;
    _messageBubble.frame = bkgFrame;
    _messageBubble.hidden = NO;
    _lab = [UILabel multLinesText:str font:font wid:conFrame.size.width color:RGBCOLOR(1, 1, 1)];
    _lab.frame = conFrame;
    [self addSubview:_lab];
}

+ (CGFloat)heightForMessage:(ChatMessage *)message {
    CGFloat widthMain = [UIScreen mainScreen].bounds.size.width;
    CGFloat maxWidth = widthMain - (32 + HeadImageWidth) * 2;
    CGFloat pointY = 10;
    if (message.needTimeLabel) {
        pointY += 23;
    }
    CGSize size = CGSizeMake(maxWidth - 18 - 6, 3000);
    UIFont * font = [UIFont systemFontOfSize:19];
    NSString * str = message.text;
    size = TextSize_MutiLine(str, font, size);
    pointY += size.height + 18;
    pointY += 16;
    return pointY;
}

- (void)cleanUpSubviews {
    self.textLabel.text = nil;
    self.detailTextLabel.text = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
