//
//  Macros.h
//  Project
//
//  Created by doorxp on 14/12/23.
//  Copyright (c) 2014年 doorxp. All rights reserved.
//

#ifndef Project_Macros_h
#define Project_Macros_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NSArray+Helper.h"


typedef enum : NSUInteger {
    SearchTypeText=0,
    SearchTypeImage=1,
} SearchType;

#define XIB(xibName) [[UINib nibWithNibName:xibName bundle:nil] instantiateWithOwner:self options:nil].firstObject

#define clip(value,a,b) MIN(MAX(value,a),b)

#define NSApp() ([UIApplication sharedApplication])
#define NSWindow() NSApp().keyWindow
#define NSRooter() NSWindow().rootViewController

#define BlOCK(__block__) \
({\
    __typeof(self) __weak tmp = self;\
    __typeof(self) __weak self __unused = tmp;\
    __block__;\
})

#ifdef DEBUG

NS_INLINE void MyPrint(NSString *format, ...) NS_FORMAT_FUNCTION(1,2);

NS_INLINE void MyPrint(NSString *format, ...)
{
    @autoreleasepool {
        va_list ap;
        va_start(ap, format);
        NSString *str = [[NSString alloc] initWithFormat:format arguments:ap];
        va_end(ap);
        printf("%s\n",str.UTF8String);
    }
}

#define NSLog(format, ...) \
do{\
    NSLog(@"%s[%d]" format,strrchr(__FILE__,'/')+1, __LINE__, ##__VA_ARGS__);\
}while(0)

#else
#define NSLog(...)
#endif

#undef	AS_SINGLETON
#define AS_SINGLETON

#undef	AS_SINGLETON
#define AS_SINGLETON( ... ) \
- (instancetype)sharedInstance; \
+ (instancetype)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON \
- (instancetype)sharedInstance \
{ \
return [[self class] sharedInstance]; \
} \
+ (instancetype)sharedInstance \
{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
}

#undef	DEF_SINGLETON
#define DEF_SINGLETON( ... ) \
- (instancetype)sharedInstance \
{ \
return [[self class] sharedInstance]; \
} \
+ (instancetype)sharedInstance \
{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
}

#undef	AS_STATIC_PROPERTY_INT
#define AS_STATIC_PROPERTY_INT( __name ) \
- (NSInteger)__name; \
+ (NSInteger)__name;

#undef	DEF_STATIC_PROPERTY_INT
#define DEF_STATIC_PROPERTY_INT( __name, __value ) \
- (NSInteger)__name \
{ \
return (NSInteger)[[self class] __name]; \
} \
+ (NSInteger)__name \
{ \
return __value; \
}

#undef	AS_INT
#define AS_INT	AS_STATIC_PROPERTY_INT

#undef	DEF_INT
#define DEF_INT	DEF_STATIC_PROPERTY_INT

#define IOS8_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
#define IOS7_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS6_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
#define IOS5_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )
#define IOS4_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"4.0"] != NSOrderedAscending )
#define IOS3_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"3.0"] != NSOrderedAscending )

#define IOS7_OR_EARLIER		( !IOS8_OR_LATER )
#define IOS6_OR_EARLIER		( !IOS7_OR_LATER )
#define IOS5_OR_EARLIER		( !IOS6_OR_LATER )
#define IOS4_OR_EARLIER		( !IOS5_OR_LATER )
#define IOS3_OR_EARLIER		( !IOS4_OR_LATER )

#define IS_SCREEN_4_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_35_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//屏幕尺寸
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


#define kBundleID [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleIdentifierKey]
#define kAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey]
#define kSystemLang [[NSLocale preferredLanguages] objectAtIndex:0]
#define ScreenRect [UIScreen mainScreen].bounds
#define kDeviceModel        [[UIDevice currentDevice] model]
#define kDeviceSystem       [NSString stringWithFormat:@"%@ %@",[[UIDevice currentDevice] systemName],[[UIDevice currentDevice] systemVersion]]
#define kAppVersion         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//----------------------颜色类---------------------------
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define BACKCOLOR [UIColor colorWithRed:25.0/255.0 green:189/255.0 blue:248/255.0 alpha:1.0]//能耗管理背景色
//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

/*// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)*/

//背景色
#define BACKGROUND_COLOR [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1.0]
#define X3TintColor COLOR(238,63,0)

//清除背景色
#define CLEARCOLOR [UIColor clearColor]

#define RED [UIColor redColor]
#define GREEN [UIColor greenColor]
#define BLUE [UIColor blueColor]
#define WHITE [UIColor whiteColor]
#define BLACK [UIColor blackColor]
#define GRAY [UIColor grayColor]
#define ORANGE [UIColor orangeColor]
#define YELLOW [UIColor yellowColor]
#define PURPLE [UIColor purpleColor]

#pragma mark - color functions
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//----------------------颜色类--------------------------

#endif
