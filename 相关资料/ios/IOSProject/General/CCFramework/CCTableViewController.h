//
//  CCTableViewController.h
//  CCFramework
//
//  Created by Kiwi on 10/14/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import "CCViewController.h"
#import "CCTableViewCell.h"

@interface CCTableViewController : CCViewController {
    // data model storage
    NSMutableArray * _contentArray;
    
    // UITableView must be load from xib
    IBOutlet UITableView * _tableView;
}

/**
 *	Copyright © 2013 CC Inc. All rights reserved.
 *
 *	add refresh control for this controller
 */
- (void)addRefreshControl;

/**
 *	Copyright © 2013 CC Inc. All rights reserved.
 *
 *	start refresh from refresh control
 */
- (void)beginRefreshing:(NSInteger)requestID;
/**
 *	Copyright © 2013 CC Inc. All rights reserved.
 *
 *	to be implemented in sub-classes 
 *
 *  send this event when users trigger an refresh action
 */
- (void)refreshControlDidRefresh:(id)sender;

/**
 *	Copyright © 2013 CC Inc. All rights reserved.
 *
 *	add load more control for this controller
 */
- (void)addLoadMoreView;
/**
 *	Copyright © 2013 CC Inc. All rights reserved.
 *
 *	to be implemented in sub-classes
 *
 *  send this event when users trigger an load more action
 */
- (void)loadMoreViewDidLoad:(id)sender;

@end
