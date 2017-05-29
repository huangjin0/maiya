//
//  MYLayout.h
//  maiya002
//
//  Created by HuangJin on 16/9/25.
//  Copyright © 2016年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYLayout : UICollectionViewFlowLayout
{
    //这个数组就是我们自定义的布局配置数组
    NSMutableArray * _attributeAttay;
}

@property(nonatomic,assign)int itemCount;
@property(nonatomic,strong)NSArray*arrayList;
@end
