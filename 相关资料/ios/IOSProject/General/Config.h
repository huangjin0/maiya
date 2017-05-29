//
//  Config.h
//  CRM
//
//  Created by Kiwi on 10/13/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#ifndef CRM_Config_h
#define CRM_Config_h

#import "Globals.h"
#import "LocationManager.h"
#import "CCFramework.h"
#import "IEngine.h"
#import "ColorHelper.h"
#import "StringHelper.h"
#import "CCClient+Requests.h"
#import "UIImageView+WebCache.h"
#import "ISH_ImgUrl.h"

#define ADD_NTF_OBJ(_name, _sel, _obj) [[NSNotificationCenter defaultCenter] addObserver:self selector:_sel name:_name object:_obj]
#define ADD_NTF(_name, _sel) ADD_NTF_OBJ(_name, _sel, nil)
#define POST_NTF(_name, _obj) [[NSNotificationCenter defaultCenter] postNotificationName:_name object:_obj]

#define NTF_DidLogin @"NTF_DidLogin"
#define NTF_DidUpdateInfo @"NTF_DidUpdateInfo"
#define NTF_UpdateBadges @"NTF_UpdateBadges"

#define Color_Navigation RGBCOLOR(215, 35, 35)
#define Color_Navigation_Title RGBCOLOR(255, 255, 255)
#define Color_Navigation_Items RGBCOLOR(255, 255, 255)
#define Color_Segment Color_Nav
#define Color_bkg_lightGray RGBCOLOR(247, 247, 247)
#define Color_bkg_blue RGBCOLOR(91, 141, 197)
#define Color_seperator RGBCOLOR(200, 199, 204)
#define Color_bkg_green RGBCOLOR(9, 186, 7)

#define Color_Text RGBCOLOR(99, 99, 99)
#define Color_Text_orange RGBCOLOR(238, 120, 69)

#define BTN_Color_Blue RGBACOLOR(245, 80, 80, 1)
#define BTN_Color_Blue_d RGBACOLOR(245, 80, 80, 0.5)
#define BTN_Blue_n [UIImage imageWithColor:BTN_Color_Blue cornerRadius:3]
#define BTN_Blue_d [UIImage imageWithColor:BTN_Color_Blue_d cornerRadius:3]

#define DeFaultURL  @"http://ishenghuo.zgcom.cn"

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define status1 ([UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.height + self.tabBarController.tabBar.height)

#define kAlphaNum @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

#define KViewWidth ScreenWidth

#endif
