//
//  ClassficationTableView.h
//  IOSProject
//
//  Created by IOS004 on 15/6/9.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClassficationTableViewDelegate <NSObject>

- (void)clickindexPathRow:(NSMutableArray *)row index:(NSIndexPath *)index indeXPath:(NSIndexPath *)indexPath cartId:(NSString *)cartId;

@end

@interface ClassficationTableView : UITableView

extern NSString * strLast1Name;

@property (nonatomic,strong) NSMutableArray * dockarr;

@property (weak,nonatomic) id<ClassficationTableViewDelegate>classDelegate;

@end
