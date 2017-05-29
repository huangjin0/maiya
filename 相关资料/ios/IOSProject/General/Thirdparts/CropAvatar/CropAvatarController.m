//
//  CropAvatarController.m
//  DoctorFixBao
//
//  Created by Wan Kiwi on 11/16/14.
//  Copyright (c) 2014 kiwiapp. All rights reserved.
//

#import "CropAvatarController.h"

@interface CropAvatarCover : UIView

@end

@implementation CropAvatarCover
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);
    CGFloat raduis = (rect.size.width - 30) / 2;
    CGFloat lineWidth = raduis * 1.4;
    CGContextSetStrokeColorWithColor(ctx, RGBACOLOR(1, 1, 1, 0.5).CGColor);
    CGContextSetLineWidth(ctx, lineWidth);
    CGFloat frameWidth = (lineWidth / 2 + raduis) * 2;
    CGContextAddRect(ctx, CGRectMake((rect.size.width - frameWidth) / 2, (rect.size.height - frameWidth) / 2 + 10, frameWidth, frameWidth));
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);
    
    CGFloat pointY = (rect.size.height / 2 - raduis) / 2 + 10;
    
    NSString * text = @"移动、缩放";
    UIFont * font = [UIFont systemFontOfSize:18];
    NSDictionary * attributes = @{NSFontAttributeName:font, NSForegroundColorAttributeName:[UIColor whiteColor]};
    CGSize size = [text sizeWithAttributes:attributes];
    CGRect textRect = CGRectMake((rect.size.width - size.width) / 2, pointY, size.width, size.height);
    [text drawInRect:textRect withAttributes:attributes];
}
@end

@interface CropAvatarController () <UIScrollViewDelegate> {
    CGRect _screenFrame;
    CGFloat _hw;
    CGFloat _std_hw;
}
@end

@implementation CropAvatarController

- (id)initWithImage:(UIImage*)image delegate:(id)delegate {
    if (self = [super initWithNib]) {
        _shouldHideNavigationBar = YES;
        self.originImage = image;
        self.delegate = delegate;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_btnBack setTitle:String(@"Cancel") forState:UIControlStateNormal];
    [_btnCommit setTitle:@"选择" forState:UIControlStateNormal];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_firstAppear) {
        CGFloat mainWidth = [UIScreen mainScreen].bounds.size.width;
        _cropCoverView.userInteractionEnabled = NO;
        CGFloat raduis = (mainWidth - 30) / 2;
        CGFloat marginTop = (self.navigationController.view.height - raduis * 2 - 30) / 2;
        CGRect frame = CGRectMake(0, 0, mainWidth, self.navigationController.view.height);
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.delegate = self;
        _scrollView.clipsToBounds = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentInset = UIEdgeInsetsMake(marginTop, 0, marginTop, 0);
        [self.view insertSubview:_scrollView belowSubview:_cropCoverView];
        frame = CGRectMake(0, 0, raduis * 2 + 30, raduis * 2 + 30);
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = _originImage;
        [_scrollView addSubview:imageView];
        _imageView = imageView;
        _screenFrame = frame;
        
        UIImage * image = self.originImage;
        if ([image isKindOfClass:[UIImage class]]) {
            _std_hw = _screenFrame.size.height/_screenFrame.size.width;
            CGFloat kw = _screenFrame.size.width;
            CGFloat kh = _screenFrame.size.height;
            _hw = image.size.height/image.size.width;
            CGFloat contentWidth = kw;
            CGFloat contentHeight = kh;
            
            CGRect frameImage = _imageView.frame;
            CGFloat minScale = 1;
            if (_hw > _std_hw) {
                contentWidth = contentHeight/_hw;
                frameImage = CGRectMake((kw-contentWidth)/2, 0, contentWidth, contentHeight);
                minScale = _screenFrame.size.width / frameImage.size.width;
            } else if (_hw < _std_hw) {
                contentHeight = contentWidth*_hw;
                frameImage = CGRectMake(0, (kh-contentHeight)/2, contentWidth, contentHeight);
                minScale = _screenFrame.size.height / frameImage.size.height;
            }
            _imageView.frame = frameImage;
            
            CGFloat biggerTime = image.size.width/kw;
            if (image.size.height/kh > biggerTime) {
                biggerTime = image.size.height/kh;
            }
            biggerTime += 0.8;
            if (biggerTime < 1.5) {
                biggerTime = 1.5;
            }
            _scrollView.maximumZoomScale = biggerTime;
            _scrollView.minimumZoomScale = minScale;
            
            [_scrollView setZoomScale:minScale animated:NO];
            CGSize contentSize = _scrollView.contentSize;
            [_scrollView setContentOffset:CGPointMake((contentSize.width - _scrollView.bounds.size.width) / 2, (contentSize.height - _scrollView.bounds.size.height) / 2) animated:NO];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (IBAction)btnBackPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)btnCommitPressed:(id)sender {
    UIImage * image = [self getShotImage];
    if ([_delegate respondsToSelector:@selector(cropAvatarControllerDidFinishWithImage:)]) {
        [_delegate cropAvatarControllerDidFinishWithImage:image];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage*)getShotImage {
    UIImage * image = self.originImage;
    CGPoint point = _scrollView.contentOffset;
    point.x += _scrollView.contentInset.left;
    point.y += _scrollView.contentInset.top;
    CGSize scrollSize = _scrollView.bounds.size;
    scrollSize.width -= _scrollView.contentInset.left + _scrollView.contentInset.right;
    scrollSize.height -= _scrollView.contentInset.top + _scrollView.contentInset.bottom;
    CGSize viewSize = _imageView.frame.size;
    CGFloat perX = point.x / viewSize.width; // 起始x点比例
    CGFloat perY = point.y / viewSize.height; // 起始y点比例
    CGFloat perW = scrollSize.width / viewSize.width; // 长度比例
    CGFloat perH = scrollSize.height / viewSize.height; // 高度比例
    CGRect rect = CGRectMake(perX * image.size.width, perY * image.size.height, perW * image.size.width, perH * image.size.height);
    UIImage * croppedImage = [_imageView.image croppedImage:rect];
    CGSize newSize = CGSizeMake(320, 320);
    croppedImage = [croppedImage resizeImageGreaterThan:newSize.width];
    newSize = CGSizeMake(320 - 30, 320 - 30);
    rect = CGRectMake(15, 15, newSize.width, newSize.height);
    croppedImage = [croppedImage croppedImage:rect];
//    UIImageWriteToSavedPhotosAlbum(croppedImage, nil, nil, nil);
    return croppedImage;
}

#pragma mark - UIStatusBarStyle
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark - UIScrollDelegate
- (UIView*)viewForZoomingInScrollView:(UIScrollView*)sender {
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView*)sender {
    UIImageView * imgView = (UIImageView*)_imageView;
    CGRect frame = imgView.frame;
    if (_hw > _std_hw) {
        frame.origin.x = (_screenFrame.size.width-frame.size.width)/2;
        if (frame.origin.x < 0) {
            frame.origin.x = 0;
        }
    } else if (_hw < _std_hw) {
        frame.origin.y = (_screenFrame.size.height-frame.size.height)/2;
        if (frame.origin.y < 0) {
            frame.origin.y = 0;
        }
    }
    [imgView setFrame:frame];
}

@end
