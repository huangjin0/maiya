//
//  ClassificationViewController.h
//  IOSProject
//
//  Created by IOS002 on 15/5/30.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicTableViewController.h"

@protocol classficationDelegate <NSObject>

- (void)passgoodsid:(NSString *)goods;
- (void)passName:(NSString *)passName;
- (void)firstcartId:(NSString *)cartid;
- (void)secondcartId:(NSString *)cartid;
- (void)firstcartAtSecondId:(NSString *)cartid;
- (void)firstName:(NSString *)name;
- (void)cartid:(NSString *)cartid;
- (void)arrNameList:(NSString *)nameList;

@end

@interface ClassificationViewController : BasicTableViewController

extern NSString * strName;
extern NSString * strImage;
@property (nonatomic, strong)id<classficationDelegate>delegate;

@end
