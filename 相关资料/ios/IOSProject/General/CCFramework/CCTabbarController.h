//
//  CCTabbarController.h
//  CCFramework
//
//  Created by Kiwi on 11/20/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CCTabbarItem : NSObject

@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSString * imageName;
@property (strong, nonatomic) NSString * selectedImageName;

+ (instancetype)itemWithTitle:(NSString*)title imageName:(NSString*)imageName;
+ (instancetype)itemWithTitle:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName;

@end



@interface CCTabbarController : UITabBarController

+ (instancetype)controllerWithItems:(NSArray*)items controllers:(NSArray*)controllers barColor:(UIColor*)barColor color:(UIColor*)color selectedColor:(UIColor*)selectedColor NS_DEPRECATED_IOS(2_0, 6_0);
+ (instancetype)controllerWithItems:(NSArray*)items controllers:(NSArray*)controllers barColor:(UIColor*)barColor selectedColor:(UIColor*)selectedColor;
- (id)initWithControllers:(NSArray*)controllers barColor:(UIColor*)barColor selectedColor:(UIColor*)selectedColor;

@end
