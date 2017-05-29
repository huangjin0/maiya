//
//  ColorHelpers.h
//  DrivingNeighborSchool
//
//  Created by Wan Kiwi on 14-5-14.
//  Copyright (c) 2014年 Kiwi Private. All rights reserved.
//

#ifndef Memories_ColorHelpers_h
#define Memories_ColorHelpers_h


#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RGBHex(__obj) [UIColor colorFromHexCode:__obj]



#define BKGColorMain RGBCOLOR(248, 248, 248)
#define TintColorNormal RGBCOLOR(235, 235, 235)
#define TintColorSelected RGBCOLOR(255, 122, 0)
#define ViewWidth [[UIScreen mainScreen]bounds].size.width



#endif
