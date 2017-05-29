//
//  CCViewController.h
//  CCFramework
//
//  Created by Kiwi on 10/13/14.
//  Copyright (c) 2014 CC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCClient.h"
#import "CCLoadingView.h"
#import "CCRefreshControl.h"
#import "CCLoadMoreView.h"

@interface CCViewController : UIViewController {
    // if YES the controller should hide navigation bar automatically
    BOOL _shouldHideNavigationBar;
    // if YES the controller should show tool bar automatically
    BOOL _shouldShowToolBar;
    
    // if YES the controller appears the first time do not ever modify it
    BOOL _firstAppear;
    
    // if YES the controller show HUD for every request that need it
    BOOL _needLoadingHUD;
    
    // CCLoadingView instance
    CCLoadingView * _loadingHUD;
    
    // CCRefreshControl instance
    CCRefreshControl * _refreshControl;
    // CCLoadMoreView instance
    CCLoadMoreView * _loadMoreView;
    
    // CCClient instance
    CCClient * _client;
    
    // data page
    NSInteger _page;
    // number of data for each page
    NSInteger _numberOfPage;
    // the total count
    NSInteger _totalCount;
}
@property (assign, nonatomic) BOOL loading;
@property (strong, nonatomic) NSString * workingMessage;

/**
 *	Copyright © 2013 CC Inc. All rights reserved.
 *
 *	initialize a Navigation Controller instance with this controller for the rootViewController
 *
 *	@param 	class Navigation Class
 *
 *	@return	return a Navigation Controller instance
 */
+ (id)controllerWithNavigation:(Class)class;

/**
 *	Copyright © 2013 CC Inc. All rights reserved.
 *
 *	initialize an controller instance using xib with the same name of the class
 *
 *	@return	return a Controller instance
 */
- (instancetype)initWithNib;

/**
 *	Copyright © 2013 CC Inc. All rights reserved.
 *
 *	self.edgesForExtendedLayout = UIRectEdgeNone; do this in initialize methods
 */
- (void)setEdgesForExtendedLayoutNone;

/**
 *	Copyright © 2013 CC Inc. All rights reserved.
 *
 *	action for back buttons
 */
- (IBAction)btnBackPressed:(id)sender;

/**
 *	Copyright © 2013 CC Inc. All rights reserved.
 *
 *	resign first responder for all subviews on target view
 *
 *	@param  aView the target view
 */
- (void)resignAllKeyboard:(UIView*)aView;

/**
 *	Copyright © 2013 CC Inc. All rights reserved.
 *
 *	start an request using CCClient
 *
 *	@param  requestID identifier for each request
 *
 *	@return	return YES if success
 */
- (BOOL)startRequest:(NSInteger)requestID;
/**
 *	Copyright © 2013 CC Inc. All rights reserved.
 *
 *	start an request using CCClient
 *
 *	@param  sender CCClient object that execute the request
 *	@param  result result for the request (NSDictionary or NSArray)
 *
 *	@return	return YES if the request has no error
 */
- (BOOL)client:(CCClient*)sender didFinishLoadingWithResult:(id)result;

/**
 *	Copyright © 2013 CC Inc. All rights reserved.
 *
 *	release memories
 */
- (void)controllerRelease;

/**
 *	Copyright © 2013 CC Inc. All rights reserved.
 *
 *	to be implemented in sub-classes
 *
 *	@return YES if there are more data to be load
 */
- (BOOL)hasMoreData;

@end
