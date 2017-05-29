//
//  SetUpViewController.h
//  IOSProject
//
//  Created by IOS004 on 15/6/8.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicTableViewController.h"

@protocol logOutDelegate <NSObject>

-(void)logOutToRootVC;

@end

@interface SetUpViewController : BasicTableViewController

@property (nonatomic,weak) id<logOutDelegate>delegate;

@end
