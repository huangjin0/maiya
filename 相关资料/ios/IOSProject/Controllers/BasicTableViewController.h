//
//  BasicTableViewController.h
//  DoctorFixBao
//
//  Created by Kiwi on 11/25/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import "CCTableViewController.h"
#import "CCViewController+Additions.h"
#import "BasicNavigationController.h"
//#import "PhotosScrollController.h"
#import "BasicCell.h"
#import "DataListControl.h"

@interface BasicTableViewController : CCTableViewController {
    BOOL _isLoadMore;
}
@property (strong, nonatomic) DataListControl * selectedControl;

@end
