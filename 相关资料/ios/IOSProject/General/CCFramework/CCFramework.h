//
//  CCFramework.h
//  CCFramework
//
//  Created by Kiwi on 10/13/14.
//  Copyright (c) 2014 Kiwi Private. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef __IPHONE_7_0
#warning "This project uses features only available in iOS SDK 7.0 and later."
#endif

#import "CCTabbarController.h"
#import "CCNavigationController.h"
#import "CCViewController.h"
#import "CCTableViewController.h"
#import "CCWebViewController.h"
#import "CCPhotosScrollController.h"
#import "CCClient.h"
#import "CCModel.h"
#import "CCLoadingView.h"
#import "CCAlertView.h"
#import "CCPickerView.h"
#import "CCSegmentedControl.h"
#import "CCFilterView.h"
#import "CCFormView.h"

#import "DBConnection.h"
#import "CCFrameworkSystem.h"
#import "CCDeviceLog.h"

// Categories
#import "NSDataAdditions.h"
#import "NSDateAdditions.h"
#import "NSDictionaryAdditions.h"
#import "NSStringAdditions.h"
#import "UIActionSheet+Block.h"
#import "UIAlertView+Block.h"
#import "UIButtonAdditions.h"
#import "UIColorAdditions.h"
#import "UIImage+Alpha.h"
#import "UIImage+ImageEffects.h"
#import "UIImage+Resize.h"
#import "UIImage+RoundedCorner.h"
#import "UIImageAdditions.h"
#import "UILabelAdditions.h"
#import "UIViewAdditions.h"

// Notifications
// to be implemented in root view controller to receive signout notification
#define NTF_DidSignOut @"NotificationDidSignout"
