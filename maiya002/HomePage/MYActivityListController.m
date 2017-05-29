//
//  MYActivityListController.m
//  maiya002
//
//  Created by HuangJin on 16/9/25.
//  Copyright © 2016年 com. All rights reserved.
//

#import "MYActivityListController.h"
#import "MYSaleListItemCell.h"
#import "MYSaleListItemModel.h"
#import "MYLayout.h"
#import "MYActivityListLayout.h"
#import "MYCategoryListController.h"
#import "ActivitySifteController.h"

@interface MYActivityListController()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *goodsListCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *categoryCollectionView;
@property(nonatomic,strong)NSMutableArray*arrayList;
@property(nonatomic,strong)MYCategoryListController*categoryListVC;
@property(nonatomic,strong)ActivitySifteController *activitySifteVC;

@end
@implementation MYActivityListController


-(MYCategoryListController*)categoryListVC
{
    if (_categoryListVC==nil) {
        
        _categoryListVC=[STORYBOAD_HOME instantiateViewControllerWithIdentifier:CategoryListController];
    }
    [_categoryListVC.view setFrame:CGRectMake(0, 0, MYWIDTH, 55.0f)];
    
    return _categoryListVC;

}

-(ActivitySifteController*)activitySifteVC
{
    if (_activitySifteVC==nil) {
      
        
        _activitySifteVC=[STORYBOAD_HOME instantiateViewControllerWithIdentifier:ActivitySifteControllerIdentifer];
    }
    
    [_activitySifteVC.view setFrame:CGRectMake(0, -64, MYWIDTH, MYHEIGHT+64)];

    return _activitySifteVC;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
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
    
    MYActivityListLayout * layout = [[MYActivityListLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset=UIEdgeInsetsMake(8, 10, 8, 10);
    layout.minimumLineSpacing=10.0f;
    layout.minimumInteritemSpacing=10.0f;
    layout.itemCount=_arrayList.count;
    layout.arrayList=_arrayList;
    
    [_goodsListCollectionView setCollectionViewLayout:layout];
//    [_goodsListCollectionView reloadData];
    _goodsListCollectionView.delegate=self;
    _goodsListCollectionView.dataSource=self;
    [self setbackButton];
    [self setRighttButton];


}


-(void)setRighttButton
{
     UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 220, 44)];
    float width= IMAGE(@"gwc").size.width;
     float height= IMAGE(@"gwc").size.height;
    float y=(44-height)/2.0;
    
    UIButton*buyCar=[[UIButton alloc]initWithFrame:CGRectMake(220-width, y, width, height)];
    [buyCar setImage:IMAGE(@"gwc") forState:UIControlStateNormal];
    [buyCar addTarget:self action:@selector(buyCarAction) forControlEvents:UIControlEventTouchUpInside];
    UIButton*search=[[UIButton alloc]initWithFrame:CGRectMake(220-width*2-10.0f, y, width, height)];
    [search setImage:IMAGE(@"ss") forState:UIControlStateNormal];
      [search addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];

    UIButton*select=[[UIButton alloc]initWithFrame:CGRectMake(220-width*3-20.0f, y, width, height)];
    [select setImage:IMAGE(@"sx") forState:UIControlStateNormal];
    [select addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];

    [view addSubview:buyCar];
    [view addSubview:search];
    [view addSubview:select];
     UIBarButtonItem*right=[[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.rightBarButtonItem=right;
    
    

}

#pragma mark --用户点击

-(void)buyCarAction
{

}
-(void)searchAction
{

}
-(IBAction)selectAction:(id)sender
{
    [self.navigationController.view insertSubview:self.activitySifteVC.view atIndex:self.view.subviews.count];
    

}


-(void)setbackButton
{
   
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 160, 44)];
        UIButton*button=[[UIButton alloc]initWithFrame:CGRectMake(0, 5, 25, 34)];
//    [button setBackgroundImage: IMAGE(@"back2_ic_normal.png") forState:UIControlStateNormal];
//    UIBarButtonItem*backItem=[[UIBarButtonItem alloc]initWithCustomView:back];
//    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
//    [view seted:UIEdgeInsetsMake(0, -10, 0, 0)];
    [button setImage:IMAGE(@"back2_ic_normal.png") forState:UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [D5BarItem setLeftBarItemWithImage: IMAGE(@"back2_ic_normal.png") target:self action:@selector(back)];
//    [D5BarItem setLeftBarItemWithTitle:@"新鲜蔬菜水果" color: [UIColor blackColor] target:self action:@selector(back)];
//    [self.navigationItem.backBarButtonItem setTitle:@"新鲜蔬菜水果"];
    UIButton*buttonTitle=[[UIButton alloc]initWithFrame:CGRectMake(25, 5, 120, 34)];
    [buttonTitle setTitle:@"新鲜蔬菜水果" forState:UIControlStateNormal];
    [buttonTitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [buttonTitle.titleLabel setTextAlignment:NSTextAlignmentLeft];
    buttonTitle.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [buttonTitle.titleLabel setFont:[UIFont systemFontOfSize:16]];
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"新鲜蔬菜水果" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [view addSubview:button];
    [view addSubview:buttonTitle];
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem=backItem;
//    UIBarButtonItem*backButton = [[UIBarButtonItem alloc] initWithTitle:@" fan hui " style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
//    self.navigationItem.leftBarButtonItem= backButton;

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
//    [_goodsListCollectionView.collectionViewLayout invalidateLayout];
    
        if (section==0) {
            return 1;
        }else
            return 100;
    
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==0) {
        UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"categoryListIndentifer" forIndexPath:indexPath];
        [cell addSubview:self.categoryListVC.view];
        return cell;
        
        
    }
    
    MYSaleListItemCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"MYACTIVITYLIST" forIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    MYSaleListItemModel*model=_arrayList[indexPath.row];
    cell.scrible.text=model.scrible;
    return cell;
}

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
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
//    [self.goodsListCollectionView performBatchUpdates:nil completion:^(BOOL finished)
//     {
//         NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:kSaleSection];
//         PromoFeedCollectionCell *cell = (PromoFeedCollectionCell *) [self.collectionView cellForItemAtIndexPath:indexPath];
//         
//         if (cell)
//         {
//             [cell resizeCellView];
//         }
//         finished = YES;
//     }];
}


@end
