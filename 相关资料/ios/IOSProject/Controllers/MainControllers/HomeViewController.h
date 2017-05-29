//
//  HomeViewController.h
//  IOSProject
//
//  Created by sfwen on 15/7/17.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicTableViewController.h"

@class ADView;


@protocol classificationDelegate <NSObject>

- (void)classificationValue:(NSArray *)arrNameCalss;

@end

@interface HomeViewController : BasicTableViewController

@property (nonatomic, strong) UIButton * imageBG;
@property (assign,nonatomic)id<classificationDelegate> delegate;


@end
