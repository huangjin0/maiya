//
//  MainPageBannerScrollView.m
//  IOSProject
//
//  Created by IOS002 on 15/6/1.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//
//
#import "MainPageBannerScrollView.h"
#import "BannerViewController.h"
#import "BannerAndConnectionImageViewController.h"
#import "UIButton+WebCache.h"
#import "BannerAndConnectionImageViewController.h"

#define UISCREENWIDTH  self.bounds.size.width//广告的宽度
#define UISCREENHEIGHT  self.bounds.size.height//广告的高度

@interface MainPageBannerScrollView () <UIScrollViewDelegate>

@property (assign, nonatomic) NSInteger currentPageIndex;//滚动视图计数
@property (strong, nonatomic) NSMutableArray * imageViewsList;
@property (strong, nonatomic) NSMutableArray * imageNamesList;
@property (strong, nonatomic) NSTimer * timer;//定制滚动时间

@end

@implementation MainPageBannerScrollView

- (void) initADView {
    h = ScreenWidth / 2.56;
    //    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.width = ScreenWidth;
    _scrollView.frame = CGRectMake(0, 0, ScreenWidth, h);
    _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.bounds), 0);
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.bounds) * 3, CGRectGetHeight(_scrollView.bounds));
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    
    UITapGestureRecognizer *animalTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCount)];
    [_scrollView addGestureRecognizer:animalTap];
    
    for (int i = 0; i < 3; i ++) {
        NSInteger index = [self processIndexWithIndex:_currentPageIndex - 1 + i];
        NSString * url = _imageNamesList[index];
        //        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [btn setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal completed:nil];
        //        UIImage *image = btn.imageView.image;
        //        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(0, 0, ScreenWidth, h);
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
    //    _pageControl = [[UIPageControl alloc] init];
    //    _pageControl.backgroundColor = [UIColor clearColor];
    //    _pageControl.bounds = CGRectMake(0, 0, 200, 20);
    //    _pageControl.center = CGPointMake(ScreenWidth/2.0, 53);
    //    _pageControl.numberOfPages = [_imageNamesList count];
    //    [_scrollView addSubview:_pageControl];
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.numberOfPages = _imageViewsList.count;
    
    _pageControl.frame = CGRectMake(UISCREENWIDTH/2 - 30, UISCREENHEIGHT -20, 60, 10);
    
    _pageControl.currentPage = 0;
    _pageControl.enabled = NO;
    
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
        _timer = [NSTimer scheduledTimerWithTimeInterval:6.0 target:self selector:@selector(respondToTimer:) userInfo:nil repeats:YES];
    }
    _timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:6.0];
    
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
//- (void)tapControll:(UITapGestureRecognizer *)sender {
//    NSLog(@"手势");
//    if (_delegate && [_delegate respondsToSelector:@selector(clickedSomeoneOfAD:)]) {
//        [_delegate clickedSomeoneOfAD:1];
//    }
//    if (_delegate && [_delegate respondsToSelector:@selector(needReceiveAd_id)]) {
//        [_delegate needReceiveAd_id];
//    }
//}

- (void)setImageArray:(NSArray *)imageArray {
    imageArray = imageArray;
    _imageNamesList = [[NSMutableArray alloc] init];
//    for (ADBanner * item in imageArray) {
//        [_imageNamesList addObject:item.headURL];
//    }
    if (_imageNamesList.count == 1) {
        NSString * str = _imageNamesList[0];
        [_imageNamesList addObject:str];
        [_imageNamesList addObject:str];
    } else if (_imageNamesList.count == 2) {
        NSString * str = _imageNamesList[0];
        [_imageNamesList addObject:str];
    }
 //       _imageNamesList = [[NSMutableArray alloc] initWithArray:@[@"home_dingdan_icon_normal",@"home_shoucang_icon_normal",@"dianhua_icon"]];
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

//
//#define UISCREENWIDTH  self.bounds.size.width//广告的宽度
//#define UISCREENHEIGHT  self.bounds.size.height//广告的高度
//
//#define HIGHT self.bounds.origin.y //由于_pageControl是添加进父视图的,所以实际位置要参考,滚动视图的y坐标
//
//static CGFloat const chageImageTime = 6.0;
//static NSUInteger currentImage = 1;//记录中间图片的下标,开始总是为1
//
//@interface MainPageBannerScrollView ()<bannerImagedelegate>{
//    //循环滚动的三个视图
//    UIButton * _leftImageView;
//    UIButton * _centerImageView;
//    UIButton * _rightImageView;
//    //循环滚动的周期时间
//    NSTimer  * _moveTime;
//    //用于确定滚动式由人导致的还是计时器到了,系统帮我们滚动的,YES,则为系统滚动,NO则为客户滚动(ps.在客户端中客户滚动一个广告后,这个广告的计时器要归0并重新计时)
//    BOOL       _isTimeUp;
//
//}
//
//@property (strong,nonatomic,readonly) UIButton * leftImageView;
//@property (strong,nonatomic,readonly) UIButton * centerImageView;
//@property (strong,nonatomic,readonly) UIButton * rightImageView;
//
//@end
//
//@implementation MainPageBannerScrollView
//
//
//#pragma mark - 自由指定广告所占的frame
//- (instancetype)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.bounces = NO;
//        
//        self.showsHorizontalScrollIndicator = NO;
//        self.showsVerticalScrollIndicator = NO;
//        self.pagingEnabled = YES;
//        self.contentOffset = CGPointMake(UISCREENWIDTH, 0);
//        self.contentSize = CGSizeMake(UISCREENWIDTH * 3, UISCREENHEIGHT);
//        self.delegate = self;
//        
//        _leftImageView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, UISCREENHEIGHT)];
//        [self addSubview:_leftImageView];
//        _centerImageView = [[UIButton alloc]initWithFrame:CGRectMake(UISCREENWIDTH, 0, UISCREENWIDTH, UISCREENHEIGHT)];
//        [self addSubview:_centerImageView];
//        _rightImageView = [[UIButton alloc]initWithFrame:CGRectMake(UISCREENWIDTH*2, 0, UISCREENWIDTH, UISCREENHEIGHT)];
//        [self addSubview:_rightImageView];
//        
//        [_leftImageView addTarget:self action:@selector(bannerImage) forControlEvents:UIControlEventTouchUpInside];
//        [_centerImageView addTarget:self action:@selector(bannerImage) forControlEvents:UIControlEventTouchUpInside];
//        [_rightImageView addTarget:self action:@selector(bannerImage) forControlEvents:UIControlEventTouchUpInside];
//        
//        _moveTime = [NSTimer scheduledTimerWithTimeInterval:chageImageTime target:self selector:@selector(animalMoveImage) userInfo:nil repeats:YES];
//        _isTimeUp = NO;
//    }
//    return self;
//}
//
//#pragma mark - 设置广告所使用的图片(名字)
//- (void)setImageNameArray:(NSArray *)imageNameArray
//{
//    _imageNameArray = imageNameArray;
//
//    [_leftImageView setImage:[UIImage imageNamed:_imageNameArray[0]] forState:UIControlStateNormal];
//    [_centerImageView setImage:[UIImage imageNamed:_imageNameArray[1]] forState:UIControlStateNormal];
//    [_rightImageView setImage:[UIImage imageNamed:_imageNameArray[2]] forState:UIControlStateNormal];
//}
//
//#pragma mark - 创建pageControl,指定其显示样式
//- (void)setPageControlShowStyle:(UIPageControlShowStyle)PageControlShowStyle
//{
//    if (PageControlShowStyle == UIPageControlShowStyleNone) {
//        return;
//    }
//    _pageControl = [[UIPageControl alloc]init];
//    _pageControl.numberOfPages = _imageNameArray.count;
////    if (PageControlShowStyle == UIPageControlShowStyleLeft) {
//    
//    _pageControl.frame = CGRectMake(UISCREENWIDTH/2 - 30, UISCREENHEIGHT -20, 60, 10);
////    }else if (PageControlShowStyle == UIPageControlShowStyleCenter){
////        _pageControl.frame = CGRectMake(0, 0, 20 * _pageControl.numberOfPages, 20);
////        _pageControl.center = CGPointMake(UISCREENWIDTH / 2, HIGHT + UISCREENWIDTH - 10);
////    }else{
////        _pageControl.frame = CGRectMake(UISCREENWIDTH - 20*_pageControl.numberOfPages, HIGHT+UISCREENHEIGHT - 20, 20*_pageControl.numberOfPages, 20);
////    }
//    
//    _pageControl.currentPage = 0;
//    _pageControl.enabled = NO;
//    
//    [self performSelector:@selector(addPageControl) withObject:nil afterDelay:0.1f];
//}
////由于PageControl这个空间必须要添加在滚动视图的父视图上(添加在滚动视图上的话会随着图片滚动,而达不到效果)
//- (void)addPageControl
//{
//    [[self superview] addSubview:_pageControl];
//}
//
//#pragma mark - 计时器到时,系统滚动图片
//- (void)animalMoveImage
//{
//    
//    [self setContentOffset:CGPointMake(UISCREENWIDTH * 2, 0) animated:YES];
//    _isTimeUp = YES;
//    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
//}
//
//#pragma mark - 图片停止时,调用该函数使得滚动视图复用
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    if (self.contentOffset.x == 0)
//    {
//        currentImage = (currentImage - 1) % _imageNameArray.count;
//        _pageControl.currentPage = (_pageControl.currentPage - 1) % _imageNameArray.count;
//    }
//    else if(self.contentOffset.x == UISCREENWIDTH * 2)
//    {
//        
//        currentImage = (currentImage + 1 ) % _imageNameArray.count;
//        _pageControl.currentPage = (_pageControl.currentPage + 1)%_imageNameArray.count;
//    }
//    else
//    {
//        return;
//    }
//
//    [_leftImageView setImage:[UIImage imageNamed:_imageNameArray[(currentImage-1)%_imageNameArray.count]] forState:UIControlStateNormal];
//    [_centerImageView setImage:[UIImage imageNamed:_imageNameArray[currentImage%_imageNameArray.count]] forState:UIControlStateNormal];
//    [_rightImageView setImage:[UIImage imageNamed:_imageNameArray[(currentImage+1)%_imageNameArray.count]] forState:UIControlStateNormal];
//    
//    self.contentOffset = CGPointMake(UISCREENWIDTH, 0);
//    
//    //手动控制图片滚动应该取消那个三秒的计时器
//    if (!_isTimeUp) {
//        [_moveTime setFireDate:[NSDate dateWithTimeIntervalSinceNow:chageImageTime]];
//    }
//    _isTimeUp = NO;
//}
//
//- (void)bannerImage{
//    NSLog(@"跳转到banner连接图");
//    UIViewController * vc = [MainPageBannerScrollView viewController:self];
//    BannerAndConnectionImageViewController * bannerImage = [[BannerAndConnectionImageViewController alloc] init];
//    [vc.navigationController pushViewController:bannerImage animated:YES];
//}
//
////神奇的东西,view中取到所在当前控制器
//+ (UIViewController *)viewController:(UIView *)view{
//    
//    UIResponder *responder = view;
//    while ((responder = [responder nextResponder]))
//        if ([responder isKindOfClass: [UIViewController class]])
//            return (UIViewController *)responder;
//    return nil;
//}

//@end
