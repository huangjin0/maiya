//
//  MYCategoryListController.m
//  maiya002
//
//  Created by HuangJin on 16/9/26.
//  Copyright © 2016年 com. All rights reserved.
//

#import "MYCategoryListController.h"
#import "MyCategoryListCell.h"
//#import "MYSaleListItemModel.h"
#
@interface MYCategoryListController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@end


@implementation MYCategoryListController
-(void)viewDidLoad
{
    [super viewDidLoad];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    //    [_goodsListCollectionView.collectionViewLayout invalidateLayout];
    
    
        return 20;
    
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    MyCategoryListCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:CategoryListCell forIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
//    MYSaleListItemModel*model=_arrayList[indexPath.row];
//    cell.scrible.text=model.scrible;
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
{
    
    return UIEdgeInsetsMake(8, 10, 8, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    return 5;
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
{
    
    return 10;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    return  CGSizeMake(76.0, 55.0f);
}

@end
