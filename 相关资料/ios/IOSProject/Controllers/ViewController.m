//
//  ViewController.m
//  IOSProject
//
//  Created by Kiwi on 1/29/15.
//  Copyright (c) 2015 CC Inc. All rights reserved.
//

#import "ViewController.h"
#import "BasicNavigationController.h"
#import "MainPageViewController.h"
#import "ClassificationViewController.h"
#import "PersonalCenterViewController.h"
#import "ShoppingCartViewController.h"
#import "PCenterViewController.h"
#import "PersonalCenterMainPage.h"
#import "PerCenViewController.h"
//#import "CCClient.h"
#import "HomeViewController.h"
#import "MessageManger.h"
#import "ChatMessage.h"
#import "EAIntroView.h"
#import "ISH_MainViewController.h"
#import "NewClassViewController.h"


@interface ViewController ()<EAIntroDelegate>{
    BOOL _firstAppear;
    CCClient *_clientLoc;
    
}

@property (strong, nonatomic) NSThread * threadHeartBeats;
@property (strong, nonatomic) NSThread * commentStatusHeartBeats;

@end

@implementation ViewController

- (id)init{
//    BasicNavigationController * nav = [[BasicNavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
     BasicNavigationController * nav = [[BasicNavigationController alloc] initWithRootViewController:[[ISH_MainViewController alloc] init]];
    nav.ccTabbarItem = [CCTabbarItem itemWithTitle:@"首页" imageName:@"home_ic_normal" selectedImageName:@"iSH_HomeTab"];

    BasicNavigationController * nav1 = [[BasicNavigationController alloc]initWithRootViewController:[[NewClassViewController alloc] init]];
    nav1.ccTabbarItem = [CCTabbarItem itemWithTitle:@"分类" imageName:@"fenlei_ic_normal" selectedImageName:@"iSH_ClassTab"];
    BasicNavigationController *nav2 = [[BasicNavigationController alloc] initWithRootViewController:[[PerCenViewController alloc] init]];
    nav2.ccTabbarItem = [CCTabbarItem itemWithTitle:@"个人中心" imageName:@"grcenter_ic_normal" selectedImageName:@"iSH_PersonTab"];
    
    ShoppingCartViewController * vc = [[ShoppingCartViewController alloc] init];
    vc.type = 1;
    BasicNavigationController * nav3 = [[BasicNavigationController alloc] initWithRootViewController:vc];
    nav3.ccTabbarItem = [CCTabbarItem itemWithTitle:@"购物车" imageName:@"gouwuche_ic_normal" selectedImageName:@"iSH_CartTab"];
    
    if (self = [super initWithControllers:@[nav,nav1,nav2,nav3] barColor:[UIColor whiteColor] selectedColor:RGBCOLOR(255, 107, 1)]) {
        _firstAppear = YES;
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasRecivedNewMessageWithnotification:) name:@"heartBeat" object:nil];
        [MessageManger sharedManager];
        }
    return self;
}

+(NSDictionary *)userInfo {
    return [NSDictionary dictionary];
}

/**
 * 消息监听
 */
-(void)hasRecivedNewMessageWithnotification:(NSNotification *)notification {

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self showIntroWithCrossDissolve];
}

- (void)showIntroWithCrossDissolve {
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"welcome"]) {//guidepage_
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"welcome"];
        EAIntroPage *page1 = [EAIntroPage page];
        page1.title = @"";
        page1.desc = @"";
        page1.bgImage = [UIImage imageNamed:@"first.jpg"];
        page1.titleImage = [UIImage imageNamed:@"original"];
        
        EAIntroPage *page2 = [EAIntroPage page];
        page2.title = @"";
        page2.desc = @"";
        page2.bgImage = [UIImage imageNamed:@"second.jpg"];
        page2.titleImage = [UIImage imageNamed:@"supportcat"];
        
        EAIntroPage *page3 = [EAIntroPage page];
        page3.title = @"";
        page3.desc = @"";
        page3.bgImage = [UIImage imageNamed:@"third.jpg"];
        page3.titleImage = [UIImage imageNamed:@"femalecodertocat"];
        
        EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3]];
        
        [intro setDelegate:self];
        [intro showInView:self.view animateDuration:0.0];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

@end
