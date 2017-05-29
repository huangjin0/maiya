//
//  MYHonePageController.m
//  maiya002
//
//  Created by HuangJin on 16/9/10.
//  Copyright © 2016年 com. All rights reserved.
//

#import "MYHonePageController.h"
#import "SlidingScrolleview.h"
#import "MYHomePageSalesCell.h"
#import "MYHomePageExerciseCell.h"
#import "SDCycleScrollView.h"
#import "MYSaleListViewController.h"
#import "MYActivityListController.h"


@interface MYHonePageController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic)SDCycleScrollView *bannerView;
@property(strong,nonatomic)MYSaleListViewController*saleListVc;
@property(strong,nonatomic)MYActivityListController*activityVC;

@end
@implementation MYHonePageController

-(SDCycleScrollView*)bannerView
{

    if (_bannerView==nil) {
       
        _bannerView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 138*MYWIDTH/320) imagesGroup:@[IMAGE(@"1.jpg"),IMAGE(@"2.jpg"),IMAGE(@"3.jpg"),IMAGE(@"4.jpg")]];
    }
    
    
//    [_bannerView setFrame:CGRectMake(0, 0, self.view.frame.size.width, 138/scre)];
    return _bannerView;

}

-(MYSaleListViewController*)saleListVc
{
    if (_saleListVc==nil) {
        
        _saleListVc=[STORYBOAD_HOME instantiateViewControllerWithIdentifier:SaleListViewController];
        
    }
    
    return _saleListVc;

}


-(MYActivityListController*)activityVC
{
    if(_activityVC==nil)
    {
    
        _activityVC=[STORYBOAD_HOME instantiateViewControllerWithIdentifier:ActivityListController];
    }
    
    return _activityVC;

}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self addTitileView];
    [D5BarItem addRightBarItemWithImage:IMAGE(@"xx.png") target:self action:@selector(messagecentreBox:)];
  

//    [self.bannerView setImageArr:@[@"1",@"2",@"3",@"4"] ofType:@".jpg"];
    _tableview.tableHeaderView=self.bannerView;
    _tableview.tableFooterView=[[UIView alloc]init];

    self.edgesForExtendedLayout=UIRectEdgeNone;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

/**
 * 添加titleView
*/
- (void)addTitileView
{
    
    UIButton*location=[[UIButton alloc]initWithFrame:CGRectMake(10, 12, 11, 15)];
    [location setBackgroundImage:IMAGE(@"dw") forState:UIControlStateNormal];
    UIButton*locationTitle=[[UIButton alloc]initWithFrame:CGRectMake(35, 0, 140, 40)];
   
    [locationTitle setTitle:@"华润程叔叔说" forState:UIControlStateNormal];
    [locationTitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [locationTitle.titleLabel setFont:[UIFont systemFontOfSize:15] ];
    UIView*titileview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 180, 40)];
    titileview.backgroundColor=[UIColor redColor];
    [titileview addSubview:location];
    [titileview addSubview:locationTitle];
    self.navigationItem.titleView=titileview;

}

-(IBAction)messagecentreBox:(id)sender
{
    

}

#pragma mark - UITableViewDelegate,UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0||indexPath.section==1) {
        
        return 61 * MYWIDTH / 320;
    }else
    {
        return 128.0f * MYWIDTH / 320;
    
    }

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0||indexPath.section==1) {
   
        MYHomePageExerciseCell*cell=[tableView dequeueReusableCellWithIdentifier:ExerciseCell];
        cell.selectItem=^(void)
        {
            [self pushVC:self.saleListVc animation:YES];
            
        };
        
        return cell;
    
    }else
    {
        MYHomePageSalesCell*cell=[tableView dequeueReusableCellWithIdentifier:SalesCell];
        cell.selecteItem=^(void)
        {
            [self pushVC:self.activityVC animation:YES];
            
        };

        return cell;
    
    
    
    }
    
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 6;
}
@end
