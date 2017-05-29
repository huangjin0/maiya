//
//  MsgCenViewController.h
//  IOSProject
//
//  Created by IOS002 on 15/6/24.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicViewController.h"
#import "EGORefreshTableHeaderView.h"

@interface MsgCenViewController : BasicViewController {
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}
//头像
@property (nonatomic,strong) NSString *headImg;


@end
