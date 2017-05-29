//
//  CCViewController+Additions.h
//  DoctorFixBao
//
//  Created by Kiwi on 11/25/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import "CCViewController.h"
#import "BasicNavigationController.h"
//#import "TouchableLabel.h"

@interface CCViewController (Additions)

- (void)addBackButtonToNavigation;
- (void)addCancelButtonToNavigation;

BOOL verifyText(NSString* text, NSString * name);
BOOL verifyPhone(NSString* text, NSString * name);
BOOL verifyEmail(NSString* text, NSString * name);
BOOL verifyIDCard(NSString* text, NSString * name);
BOOL verifyFloat(NSString* text, NSString * name);
BOOL verifyTelephone(NSString* text, NSString * name);

- (UIBarButtonItem *)addItemWithTitle:(NSString *)title action:(SEL)action;

- (UIBarButtonItem *)addItemWithImg:(NSString *)img action:(SEL)action;


@end
