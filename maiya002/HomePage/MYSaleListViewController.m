    //
//  MYSaleListViewController.m
//  maiya002
//
//  Created by HuangJin on 16/9/25.
//  Copyright © 2016年 com. All rights reserved.
//

#import "MYSaleListViewController.h"
#import "MYSaleListItemCell.h"
#import "MYLayout.h"
#import "MYSaleListItemModel.h"
#import "SDCycleScrollView.h"
#import "MYSaleListHeaderView.h"

@interface MYSaleListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)NSMutableArray*arrayList;
@property (strong, nonatomic)SDCycleScrollView *bannerView;
@property(nonatomic,strong)UIButton*backBtn;
@end

@implementation MYSaleListViewController

-(SDCycleScrollView*)bannerView
{
    
    if (_bannerView==nil) {
        
        _bannerView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width,(264.0*MYWIDTH/320)) imagesGroup:@[IMAGE(@"1.jpg"),IMAGE(@"2.jpg"),IMAGE(@"3.jpg"),IMAGE(@"4.jpg")]];
    }
    
    
    //    [_bannerView setFrame:CGRectMake(0, 0, self.view.frame.size.width, 138/scre)];
    return _bannerView;
    
}

-(UIButton*)backBtn
{
    if (_backBtn==nil) {
        _backBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 25, 25, 25)];
    }
    [_backBtn setBackgroundImage:IMAGE(@"back2_ic_normal.png") forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    return  _backBtn;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
//    self.edgesForExtendedLayout=UIRectEdgeNone;
   
//      self.navigationController.navigationBarHidden = YES;

    _arrayList=[NSMutableArray array];
    for (int i=0; i<100; i++) {
        
        MYSaleListItemModel*model=[[MYSaleListItemModel alloc]init];
         if (i%2==0)
        {
            model.scrible=@"生活费涉及到环";
        
        }else
        {
        model.scrible=@"生活费涉及到环境法分开放开了房三姐夫来烦你了是甲方不方便是反";
        }
        
        [_arrayList addObject:model];
    }
    
    MYLayout * layout = [[MYLayout alloc]init];
//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset=UIEdgeInsetsMake(8, 10, 8, 10);
    layout.minimumLineSpacing=10.0f;
    layout.minimumInteritemSpacing=10.0f;
    layout.itemCount=_arrayList.count;
    layout.arrayList=_arrayList;
    
    [_collectionViewLayout setCollectionViewLayout:layout];
    [_collectionViewLayout registerClass:[MYSaleListHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.view addSubview:self.backBtn];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
      self.navigationController.navigationBarHidden = YES;
     [D5BarItem setLeftBarItemWithImage:IMAGE(@"back2_ic_normal.png") target:self action:@selector(back)];
     [self setNavigationBarTranslucent];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
    if (section==0) {
        return 1;
    }else
    return _arrayList.count;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake (MYWIDTH,203);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        [headerView addSubview:self.bannerView];
        reusableview = headerView;
        
    }
    
    
    return reusableview;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    
    if (indexPath.section==0) {
        UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"a" forIndexPath:indexPath];
        [cell addSubview:self.bannerView];
        return cell;

       
    }
    
    MYSaleListItemCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:SaleListItemCell forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    MYSaleListItemModel*model=_arrayList[indexPath.row];
    cell.scrible.text=model.scrible;
    return cell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
//
//{
//    if (indexPath.section==0) {
//       return CGSizeMake(MYWIDTH, 206);
//    }
//
//}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
{
    
    return UIEdgeInsetsMake(8, 10, 8, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    return 10;

}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
{
    
    return 10;

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
