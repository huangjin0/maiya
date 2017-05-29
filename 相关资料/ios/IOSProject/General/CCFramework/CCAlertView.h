//
//  CCAlertView.h
//  CCFramework
//
//  Created by kiwi on 3/4/13.
//  Copyright (c) 2013 CC inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 A floating text on the screen, it will be in the middle automatically
 */

typedef enum CCAlertType {
    CCAlertTypeNone = 0,
    CCAlertTypeStar = 1,
    CCAlertTypeCheck = 2,
    CCAlertTypeError = 3,
}CCAlertType;

@interface CCAlertView : UIView

+ (void)showText:(NSString*)text life:(NSTimeInterval)life;

+ (void)showType:(CCAlertType)type text:(NSString*)text life:(NSTimeInterval)life animated:(BOOL)animated;

@end
