//
//  Globals.h
//  CRM
//
//  Created by Kiwi on 10/16/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Globals : NSObject

NSString * getAPNSIDInToken(UIApplication * application, NSData * pToken);

+ (void)initializeGlobals;

+ (void)makePhoneCall:(NSString*)phone;

UIButton * blueButtonWithTitle(NSString * title, CGRect frame);

@end
