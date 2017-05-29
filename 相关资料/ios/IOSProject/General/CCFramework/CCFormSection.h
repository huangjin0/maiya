//
//  CCFormSection.h
//  CRM
//
//  Created by Kiwi on 10/21/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCFormSection : NSObject

@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSArray * elements;

@property (assign, nonatomic) NSInteger section;

+ (id)sectionWithTitle:(NSString*)title elements:(NSArray*)elements;

@end
