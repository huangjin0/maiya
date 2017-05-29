//
//  MYLayout.m
//  maiya002
//
//  Created by HuangJin on 16/9/25.
//  Copyright © 2016年 com. All rights reserved.
//

#import "MYLayout.h"
#import "MYSaleListItemModel.h"

@interface MYLayout()
{
    UICollectionViewLayoutAttributes*obj;
    
}

//@property(nonatomic,assign)UIEdgeInsets sectionInset;
//@property(nonatomic,assign)CGFloat minimumInteritemSpacing;
//@property(nonatomic,assign)CGFloat minimumLineSpacing;
//@property(nonatomic,assign)CGSize itemSize;
@end
@implementation MYLayout

//数组的相关设置在这个方法中
//布局前的准备会调用这个方法


-(void)prepareLayout{
    _attributeAttay = [[NSMutableArray alloc]init];
    [super prepareLayout];
    //演示方便 我们设置为静态的2列
    //计算每一个item的宽度
//    _sectionInset=UIEdgeInsetsMake(8, 10, 8, 10);
//    _minimumInteritemSpacing=10.0f;
    float WIDTH = ([UIScreen mainScreen].bounds.size.width-self.sectionInset.left-self.sectionInset.right-self.minimumInteritemSpacing)/2;
    //定义数组保存每一列的高度
    //这个数组的主要作用是保存每一列的总高度，这样在布局时，我们可以始终将下一个Item放在最短的列下面
//    obj=[UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath: [NSIndexPath indexPathForItem:0 inSection:0]];
    CGFloat colHight[2]={self.sectionInset.top,self.sectionInset.bottom};
     NSIndexPath *index = [NSIndexPath indexPathForItem: 0 inSection:0];
     UICollectionViewLayoutAttributes * attrisHeader = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:index];
    float headerH=(264.0*MYWIDTH/320);//header的高度
    [attrisHeader setFrame:CGRectMake(0, 0, MYWIDTH, headerH)];
    [_attributeAttay addObject:attrisHeader];
    //itemCount是外界传进来的item的个数 遍历来设置每一个item的布局
    for (int i=0; i<_arrayList.count; i++) {
        //设置每个item的位置等相关属性
        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:1];
        //创建一个布局属性类，通过indexPath来创建
        UICollectionViewLayoutAttributes * attris = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:index];
        //随机一个高度 在40——190之间
        CGFloat hight = arc4random()%150+40;
        
       MYSaleListItemModel*model=_arrayList[i];
      CGFloat mh=[model.scrible boundingRectWithSize:CGSizeMake((MYWIDTH-30)/2.0, 0)].height;
        hight=206-42+mh;
        //哪一列高度小 则放到那一列下面
        //标记最短的列
        int width=0;
        if (colHight[0]<colHight[1]) {
            //将新的item高度加入到短的一列
            colHight[0] = colHight[0]+hight+self.minimumLineSpacing;
            width=0;
        }else{
            colHight[1] = colHight[1]+hight+self.minimumLineSpacing;
            width=1;
        }
        
        //设置item的位置
        attris.frame = CGRectMake(self.sectionInset.left+(self.minimumInteritemSpacing+WIDTH)*width, headerH+colHight[width]-hight-self.minimumLineSpacing, WIDTH, hight);
        [_attributeAttay addObject:attris];
    }
    
    //设置itemSize来确保滑动范围的正确 这里是通过将所有的item高度平均化，计算出来的(以最高的列位标准)
    if (colHight[0]>colHight[1]) {
        self.itemSize = CGSizeMake(WIDTH, (colHight[0]-self.sectionInset.top)*2/_itemCount-self.minimumLineSpacing);
    }else{
        self.itemSize = CGSizeMake(WIDTH, (colHight[1]-self.sectionInset.top)*2/_itemCount-self.minimumLineSpacing);
    }
    
}

//这个方法中返回我们的布局数组
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return _attributeAttay;
}
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds

{
    
    return YES;
    
}

-(BOOL)sectionHeadersPinToVisibleBounds
{
    return YES;
}

-(CGSize)headerReferenceSize
{
    return CGSizeMake(10011, 100);
    
}
//setup from those initial attributes to what ends up on screen.
- (nullable UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath;
{
    UICollectionViewLayoutAttributes*attr=[self layoutAttributesForItemAtIndexPath:itemIndexPath];
    return attr;
    

}
//- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath;
//{
//    UICollectionViewLayoutAttributes*attr=[self layoutAttributesForItemAtIndexPath:indexPath];
//    return attr;
//
//}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
//- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath { }
- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath {

    return nil;
}


- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath;
{
    //设置每个item的位置等相关属性
    NSIndexPath *index = [NSIndexPath indexPathForItem:0 inSection:0];
    //创建一个布局属性类，通过indexPath来创建
    UICollectionViewLayoutAttributes * attris = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:index];
    attris.frame=CGRectMake(0, 0, MYWIDTH, 203);
    return attris;

}
@end
