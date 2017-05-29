//
//  CCViewController+Additions.m
//  DoctorFixBao
//
//  Created by Kiwi on 11/25/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import "CCViewController+Additions.h"
#import "BasicTableViewController.h"
#import "BasicViewController.h"
#import "ViewController.h"

@implementation CCViewController (Additions)

- (void)addBackButtonToNavigation {
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 20, 31);
    [btn setImage:[UIImage imageNamed:@"iSH_Back"] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"btn_back_d"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnBackPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)addCancelButtonToNavigation {
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(btnBackPressed:)];
    self.navigationItem.leftBarButtonItem = item;
}

#pragma mark -
#pragma mark - Text Verifications
BOOL verifyText(NSString* text, NSString * name) {
    BOOL res = text.hasValue;
    if (!res) {
        NSString * msg = [NSString stringWithFormat:@"请填写%@", name];
        [CCAlertView showText:msg life:1];
    }
    return res;
}
BOOL verifyPhone(NSString* text, NSString * name) {
    BOOL res = verifyText(text, name);
    if (res) {
        res = text.isPhone;
        if (!res) {
            NSString * msg = [NSString stringWithFormat:@"请填写有效的%@", name];
            [CCAlertView showText:msg life:1];
        }
    }
    return res;
}
BOOL verifyEmail(NSString* text, NSString * name) {
    BOOL res = verifyText(text, name);
    if (res) {
        res = text.isEmail;
        if (!res) {
            NSString * msg = [NSString stringWithFormat:@"请填写有效的%@", name];
            [CCAlertView showText:msg life:1];
        }
    }
    return res;
}
BOOL verifyIDCard(NSString* text, NSString * name) {
    BOOL res = verifyText(text, name);
    if (res) {
        res = text.isChineseIDCard;
        if (!res) {
            NSString * msg = [NSString stringWithFormat:@"请填写有效的%@", name];
            [CCAlertView showText:msg life:1];
        }
    }
    return res;
}
BOOL verifyFloat(NSString* text, NSString * name) {
    BOOL res = verifyText(text, name);
    if (res) {
        NSArray * arr = [text componentsSeparatedByString:@"."];
        res = arr.count < 3;
        if (!res) {
            NSString * msg = [NSString stringWithFormat:@"请填写有效的%@", name];
            [CCAlertView showText:msg life:1];
        }
    }
    return res;
}
BOOL verifyTelephone(NSString* text, NSString * name) {
    BOOL res = verifyText(text, name);
    if (res) {
        NSString * numbers = text.numbersFormat;
        res = [numbers isEqualToString:text];
        if (!res) {
            NSString * msg = [NSString stringWithFormat:@"请填写有效的%@", name];
            [CCAlertView showText:msg life:1];
        }
    }
    return res;
}

#pragma mark - 添加Item
/**
 * 添加Item
 */
//文字
- (UIBarButtonItem *)addItemWithTitle:(NSString *)title action:(SEL)action {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
    return item;
}
//图片
- (UIBarButtonItem *)addItemWithImg:(NSString *)img action:(SEL)action {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:img] style:UIBarButtonItemStylePlain target:self action:action];
    return item;
}


@end
