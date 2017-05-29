//
//  SearchPageViewController.h
//  IOSProject
//
//  Created by IOS002 on 15/6/4.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicTableViewController.h"

@protocol searchText <NSObject>

- (void)searchResultText;

@end


@interface SearchPageViewController : BasicTableViewController

extern NSString * selecet;

@end
