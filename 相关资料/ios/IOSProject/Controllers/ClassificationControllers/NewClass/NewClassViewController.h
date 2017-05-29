//
//  NewClassViewController.h
//  IOSProject
//
//  Created by IOS002 on 16/5/27.
//  Copyright © 2016年 CC Inc. All rights reserved.
//

#import "BasicViewController.h"

//copy
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


@interface NewClassViewController : BasicViewController

extern NSString * strName;
extern NSString * strImage;
@property (nonatomic, assign)id<classficationDelegate>delegate;

@end
