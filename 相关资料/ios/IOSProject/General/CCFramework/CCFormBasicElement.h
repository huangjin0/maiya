//
//  CCFormBasicElement.h
//  CCFramework
//
//  Created by Kiwi on 1/14/15.
//  Copyright (c) 2015 CC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CCFormBasicElement : NSObject

@property (strong, nonatomic) NSString * key;
@property (strong, nonatomic) NSIndexPath * indexPath;
@property (assign, nonatomic) CGFloat heightForRow;
@property (strong, nonatomic) UIView * customView;
@property (assign, nonatomic) BOOL editable;

+ (instancetype)elementWithKey:(NSString*)key;

@end
