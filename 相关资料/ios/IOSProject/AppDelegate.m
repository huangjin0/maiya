//
//  AppDelegate.m
//  IOSProject
//
//  Created by Kiwi on 1/29/15.
//  Copyright (c) 2015 CC Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "BasicNavigationController.h"
#import "CCViewController+Additions.h"
#import "ChatMessage.h"
#import "AlipayConfig.h"
#import "LoginingViewController.h"
//#import "DataBase.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize splashView;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [IEngine engine];
    [Globals initializeGlobals];
    if ([IEngine engine].isSignedIn) {
        [self logIn];
    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [application setStatusBarStyle:UIStatusBarStyleDefault];
        // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [NSThread sleepForTimeInterval:3.0];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[ViewController alloc] init];
    
//    splashView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//    [splashView setImage:[UIImage imageNamed:@"qidong"]];
//    
//    [self.window addSubview:splashView];
//    [self.window bringSubviewToFront:splashView];
//    
//    [self performSelector:@selector(showWord) withObject:nil afterDelay:2.5f];
    //结束;
    
    ADD_NTF(NTF_DidSignOut, @selector(notificationUserDidSignout:));
    
    return YES;
}
-(void)scale_1
{
    UIImageView *round_1 = [[UIImageView alloc]initWithFrame:CGRectMake(100, 240, 15, 15)];
    round_1.image = [UIImage imageNamed:@"round_"];
    [splashView addSubview:round_1];
    [self setAnimation:round_1];
}

-(void)scale_2
{
    UIImageView *round_2 = [[UIImageView alloc]initWithFrame:CGRectMake(105, 210, 20, 20)];
    round_2.image = [UIImage imageNamed:@"round_"];
    [splashView addSubview:round_2];
    [self setAnimation:round_2];
}

-(void)scale_3
{
    UIImageView *round_3 = [[UIImageView alloc]initWithFrame:CGRectMake(125, 170, 30, 30)];
    round_3.image = [UIImage imageNamed:@"round_"];
    [splashView addSubview:round_3];
    [self setAnimation:round_3];
}

-(void)scale_4
{
    UIImageView *round_4 = [[UIImageView alloc]initWithFrame:CGRectMake(160, 135, 40, 40)];
    round_4.image = [UIImage imageNamed:@"round_"];
    [splashView addSubview:round_4];
    [self setAnimation:round_4];
}

-(void)scale_5
{
    UIImageView *heart_1 = [[UIImageView alloc]initWithFrame:CGRectMake(130, 180, 100, 100)];
    heart_1.image = [UIImage imageNamed:@"heart_"];
    [splashView addSubview:heart_1];
    [self setAnimation:heart_1];
}

-(void)setAnimation:(UIImageView *)nowView
{
    
    [UIView animateWithDuration:0.6f delay:0.0f options:UIViewAnimationOptionCurveLinear
                     animations:^
     {
         // 执行的动画code
         [nowView setFrame:CGRectMake(nowView.frame.origin.x- nowView.frame.size.width*0.1, nowView.frame.origin.y-nowView.frame.size.height*0.1, nowView.frame.size.width*1.2, nowView.frame.size.height*1.2)];
     }
                     completion:^(BOOL finished)
     {
         // 完成后执行code
         [nowView removeFromSuperview];
     }
     ];
    
    
}

//-(void)showWord
//{
//    
//    UIImageView *word_ = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 100, 300, 200, 200)];
//    word_.image = [UIImage imageNamed:@"yujian"];
//    [splashView addSubview:word_];
//    
//    word_.alpha = 0.0;
//    [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionCurveLinear
//                     animations:^
//     {
//         word_.alpha = 1.0;
//     }
//                     completion:^(BOOL finished)
//     {
//         // 完成后执行code
//         [NSThread sleepForTimeInterval:3.0f];
//         [splashView removeFromSuperview];
//     }
//     ];
//}
-(void)logIn {
    [[IEngine engine] readFromFile];
    NSString *accout = [IEngine engine].account;
    NSString *passWord = [IEngine engine].password;
    CCClient *client = [[CCClient alloc] initWithBlock:^(id result) {
        NSDictionary *dic = [result objectForKey:@"data"];
        [[IEngine engine] loginWithDictionary:dic];
    }];
    [client loginWithAccount:accout password:passWord];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

#pragma mark - Notifications
- (void)notificationUserDidSignout:(NSNotification*)sender {
    [[IEngine engine] signout];
    if ([sender.object integerValue] == 1) {
        [self resetControllersAndShowLogin];
    } else {
        AlertWithMessage(@"用户已在其他地方登录", ^(NSInteger buttonIndex) {
            [self resetControllersAndShowLogin];
        });
    }
}

- (void)resetControllersAndShowLogin {
    self.window.userInteractionEnabled = NO;
    self.window.rootViewController = [[ViewController alloc] init];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(500 * USEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.window.userInteractionEnabled = YES;
//        id con = [LoginingViewController controllerWithNavigation:[BasicNavigationController class]];
        LoginingViewController *loginningVC = [[LoginingViewController alloc] init];
        BasicNavigationController *navigationC = [[BasicNavigationController alloc] initWithRootViewController:loginningVC];
        loginningVC.type = 1;
        [self.window.rootViewController presentViewController:navigationC animated:YES completion:nil];
    });
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSInteger resultStatus = [resultDic getIntegerValueForKey:@"resultStatus" defaultValue:0];
            if (resultStatus == 9000) {
                POST_NTF(NTF_Alipay_Suc, nil);
            } else if (resultStatus == 6001) {
                POST_NTF(NTF_Alipay_Cancel, nil);
            } else {
                POST_NTF(NTF_Alipay_Failed, nil);
            }
        }];
//        return YES;
    }
    return YES;
}

@end
