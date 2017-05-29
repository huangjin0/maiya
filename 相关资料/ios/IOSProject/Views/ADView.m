//
//  ADView.m
//  Dengdao
//
//  Created by 刘sfwen on 15/7/5.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "ADView.h"
#import "ADBanner.h"
#import "UIButton+WebCache.h"
#import "BannerAndConnectionImageViewController.h"
#import "TAPageControl.h"

#define UISCREENWIDTH  self.bounds.size.width//广告的宽度
#define UISCREENHEIGHT  self.bounds.size.height//广告的高度

@interface ADView () <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet TAPageControl * pageControl;//分页控件
@property (assign, nonatomic) NSInteger currentPageIndex;//滚动视图计数
@property (strong, nonatomic) NSMutableArray * imageViewsList;
@property (strong, nonatomic) NSMutableArray * imageNamesList;
@property (strong, nonatomic) NSTimer * timer;//定制滚动时间

@end

@implementation ADView

- (void)viewDidLoad {
    //    [self initADView];
}

- (void) initADView {
    //    h = ScreenWidth / 2.56;
    //    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.width = ScreenWidth;
    //    _scrollView.frame = CGRectMake(0, 0, ScreenWidth, h);
    _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.bounds), 0);
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.bounds) * 3, CGRectGetHeight(_scrollView.bounds));
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    
    UITapGestureRecognizer *animalTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapControll:)];
    [_scrollView addGestureRecognizer:animalTap];
    
    for (int i = 0; i < 3; i ++) {
        NSInteger index = [self processIndexWithIndex:_currentPageIndex - 1 + i];
        NSString * url = _imageNamesList[index];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal completed:nil];
        UIImage *image = btn.imageView.image;
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];

        [imageView setImageWithURL:url placeholderImage:[UIImage imageWithColor:[UIColor grayColor] cornerRadius:0]];
        
        [imageView setBounds:CGRectMake(0, 0, CGRectGetWidth(_scrollView.bounds), CGRectGetHeight(_scrollView.bounds))];
        [imageView setCenter:CGPointMake(CGRectGetMidX(imageView.bounds) + i * CGRectGetWidth(_scrollView.bounds), CGRectGetMidY(_scrollView.bounds))];
        //适用于图片拉伸
        //      imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView setClipsToBounds:YES];
        [_imageViewsList addObject:imageView];
        [_scrollView addSubview:imageView];
    }
    //分页控件
    _pageControl = [[TAPageControl alloc]init];
    _pageControl.numberOfPages = _imageNamesList.count;
    _pageControl.frame = CGRectMake(UISCREENWIDTH/2 - 30, UISCREENHEIGHT - 20, 60, 10);
    
    _pageControl.currentPage = 0;
    _pageControl.enabled = NO;
    _pageControl.dotImage = [UIImage imageNamed:@"101"];
    _pageControl.currentDotImage = [UIImage imageNamed:@"100"];
    
    [self performSelector:@selector(addPageControl) withObject:nil afterDelay:0.1f];
    [self startTimer];
}

//由于PageControl这个空间必须要添加在滚动视图的父视图上(添加在滚动视图上的话会随着图片滚动,而达不到效果)
- (void)addPageControl
{
    [[self superview] addSubview:_pageControl];
}
- (NSInteger)processIndexWithIndex:(NSInteger)index{
    // 获取最大索引
    NSInteger maximumIndex = [_imageNamesList count] - 1;
    // 判断真实索引位置
    if (index > maximumIndex) {
        index = 0;
    }
    else if (index < 0) {
        index = maximumIndex;
    }
    return index;
}
- (void)updateScrollView{
    BOOL needUpdate = NO;
    CGFloat offset_x = _scrollView.contentOffset.x;
    //向左
    if (offset_x <= 0) {
        _currentPageIndex = [self processIndexWithIndex: --_currentPageIndex ];
        needUpdate = YES;
    }
    //向右
    else if (offset_x >= 2*CGRectGetWidth(_scrollView.bounds)){
        _currentPageIndex = [self processIndexWithIndex:++_currentPageIndex ];
        needUpdate = YES;
    }
    // 判断是否需要更新
    if (!needUpdate) {
        return;
    }
    [_pageControl setCurrentPage:_currentPageIndex];
    // 更新所有imageView显示的图片
    NSInteger leftIndex = [self processIndexWithIndex:_currentPageIndex - 1 ];
    NSInteger rigthIndex = [self processIndexWithIndex:_currentPageIndex + 1];
    UIImageView * imageV0 = (UIImageView *)_imageViewsList[0];
    [imageV0 setImageWithURL:_imageNamesList[leftIndex] placeholderImage:[UIImage imageNamed:_imageNamesList[leftIndex]]];
    UIImageView * imageV1 = (UIImageView *)_imageViewsList[1];
    [imageV1 setImageWithURL:_imageNamesList[_currentPageIndex] placeholderImage:[UIImage imageNamed:_imageNamesList[_currentPageIndex]]];
    UIImageView * imageV2 = (UIImageView *)_imageViewsList[2];
    [imageV2 setImageWithURL:_imageNamesList[rigthIndex] placeholderImage:[UIImage imageNamed:_imageNamesList[rigthIndex]]];
    // 恢复可见区域
    [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(_scrollView.bounds), 0)];
}
- (void) startTimer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(respondToTimer:) userInfo:nil repeats:YES];
    }
    _timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:5.0];
    
}
- (void) pauseTimer{
    if (_timer && _timer.isValid) {
        _timer.fireDate = [NSDate distantFuture];
    }
}
- (void) stopTimer{
    if (_timer && _timer.isValid) {
        [_timer invalidate];
        _timer = nil;
    }
}
- (void) respondToTimer:(NSTimer *)timer{
    //滚动视图内容的跳转
    [_scrollView setContentOffset:CGPointMake(2 * CGRectGetWidth(_scrollView.bounds), 0 ) animated:YES];
}
#pragma mark -- UIScrollViewDelegate methods
// 将开始拖拽
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self pauseTimer];
}
// 开始滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self updateScrollView];
}
// 停止拖拽
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updateScrollView];
    [self startTimer];
}
#pragma mark - 手势
- (void)tapControll:(UITapGestureRecognizer *)sender {

    if (_delegate && [_delegate respondsToSelector:@selector(clickedSomeoneOfAD:)]) {
        [_delegate clickedSomeoneOfAD:1];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(needReceiveAd_id:tag:)]) {
        [_delegate needReceiveAd_id:self tag:_currentPageIndex];
    }
}

- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    _imageNamesList = [[NSMutableArray alloc] init];
    for (ADBanner * item in _imageArray) {
        [_imageNamesList addObject:item.headURL];
    }
    if (_imageNamesList.count == 1) {
        NSString * str = _imageNamesList[0];
        [_imageNamesList addObject:str];
        [_imageNamesList addObject:str];
//    } else if (_imageNamesList.count == 2) {
//        NSString * str = _imageNamesList[0];
//        [_imageNamesList addObject:str];
    }
//        _imageNamesList = [[NSMutableArray alloc] initWithArray:@[@"home_dingdan_icon_normal"]];
    _imageViewsList = [[NSMutableArray alloc] init];
    _currentPageIndex = 0;
    [self initADView];
}

//view中取到所在当前控制器
+ (UIViewController *)viewController:(UIView *)view{
    
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    return nil;
}

@end
