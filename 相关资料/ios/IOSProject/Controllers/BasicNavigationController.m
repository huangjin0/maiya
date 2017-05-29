//
//  BasicNavigationController.m
//  DoctorFixBao
//
//  Created by Kiwi on 11/24/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import "BasicNavigationController.h"
#import <QuartzCore/QuartzCore.h>
#import <math.h>

#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height

@interface BasicNavigationController () {
    CGPoint _startTouch;
    UIImageView * _lastScreenShotView;
    UIView * _blackMask;
}

@property (nonatomic,retain) UIView *backgroundView;
@property (nonatomic,retain) NSMutableArray *screenShotsList;

@property (nonatomic,assign) BOOL isMoving;

@end

@implementation BasicNavigationController

//- (id)initWithRootViewController:(UIViewController *)rootViewController {
//    return [self initWithRootViewController:rootViewController barColor:Color_Navigation titleColor:Color_Navigation_Title itemsColor:Color_Navigation_Items];
//}
- (id)initWithRootViewController:(UIViewController *)rootViewController {
    return [self initWithRootViewController:rootViewController barColor:[UIColor whiteColor] titleColor:[UIColor blackColor] itemsColor:RGBCOLOR(255, 95, 5)];
}

- (void)dealloc {
    self.screenShotsList = nil;
    
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //屏蔽掉iOS7以后自带的滑动返回手势 否则有BUG
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    self.screenShotsList = [[NSMutableArray alloc]initWithCapacity:2];
    self.canDragBack = YES;
    self.specialPop = NO;
    _firstTouch = YES;
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self
                                                                                action:@selector(paningGestureReceive:)];
    [recognizer delaysTouchesBegan];
    [self.view addGestureRecognizer:recognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.screenShotsList addObject:[self capture]];
    
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    [self.screenShotsList removeLastObject];
    return [super popViewControllerAnimated:animated];
    //    if (self.specialPop) {
    //        [self pop];
    //        return [super popViewControllerAnimated:NO];
    //    }else{
    //        return [super popViewControllerAnimated:animated];
    //    }
}

#pragma mark - Utility Methods -

- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    return img;
}

- (void)moveViewWithX:(float)x
{
    float balpha = x < 0 ? -x : x;
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform,(M_PI/180*(x/kDeviceWidth)*50), 0, 0, 1);
    [self.view.layer setTransform:transform];
    float alpha = 0.4 - (balpha/800);
    _blackMask.alpha = alpha;
    
}



-(BOOL)isBlurryImg:(CGFloat)tmp
{
    return YES;
}

#pragma mark - Gesture Recognizer -

- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer
{
    if (self.viewControllers.count <= 1 || !self.canDragBack) return;
    
    CGPoint touchPoint = [recoginzer locationInView:KEY_WINDOW];
    
    if (recoginzer.state == UIGestureRecognizerStateBegan) {
        
        if (_firstTouch) {
            CALayer *layer = [self.view layer];
            CGPoint oldAnchorPoint = layer.anchorPoint;
            [layer setAnchorPoint:CGPointMake(0.5, 1.0)];
            [layer setPosition:CGPointMake(layer.position.x + layer.bounds.size.width * (layer.anchorPoint.x - oldAnchorPoint.x), layer.position.y + layer.bounds.size.height * (layer.anchorPoint.y - oldAnchorPoint.y))];
            _firstTouch = NO;
        }
        _isMoving = YES;
        _startTouch = touchPoint;
        CGRect frame = [UIScreen mainScreen].bounds;
        
        if (!self.backgroundView)
        {
            self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            [self.view.superview insertSubview:self.backgroundView belowSubview:self.view];
            
            _blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            _blackMask.backgroundColor = [UIColor blackColor];
            [self.backgroundView addSubview:_blackMask];
        }
        
        self.backgroundView.hidden = NO;
        
        if (_lastScreenShotView) [_lastScreenShotView removeFromSuperview];
        
        
        UIImage *lastScreenShot = [self.screenShotsList lastObject];
        
        _lastScreenShotView = [[UIImageView alloc]initWithImage:lastScreenShot];
        
        
        
        //[lastScreenShotView setBackgroundColor:[UIColor purpleColor]];
        
        _startBackViewX = startX;
        [_lastScreenShotView setFrame:frame];
        //[self.backgroundView addSubview:lastScreenShotView];
        
        [self.backgroundView insertSubview:_lastScreenShotView belowSubview:_blackMask];
        
    }else if (recoginzer.state == UIGestureRecognizerStateEnded){
        
        if (touchPoint.x - _startTouch.x > 150)
        {
            [self pop];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                _isMoving = NO;
                self.backgroundView.hidden = YES;
            }];
            
        }
        return;
        
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
        
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            _isMoving = NO;
            self.backgroundView.hidden = YES;
        }];
        return;
    }
    if (_isMoving) {
        [self moveViewWithX:touchPoint.x - _startTouch.x];
    }
}

- (void)pop
{
    [UIView animateWithDuration:0.4 animations:^{
        [self moveViewWithX:kDeviceWidth*2];
        CGRect frame = self.view.bounds;
        frame.origin.x = kDeviceWidth;
        frame.origin.y += 250;
        [self.view setFrame:frame];
    } completion:^(BOOL finished){
        [self popViewControllerAnimated:NO];
        CATransform3D transform = CATransform3DIdentity;
        [self.view.layer setTransform:transform];
        CGRect frame = [UIScreen mainScreen].bounds;
        frame.origin.x = 0;
        self.view.frame = frame;
        _isMoving = NO;
    }];
}

@end
