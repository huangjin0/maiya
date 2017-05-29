//
//  CCFormElement.h
//  CRM
//
//  Created by Kiwi on 10/21/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import "CCFormBasicElement.h"

#define CCFormCellHeightNormal 44
#define CCFormCellHeightMuti 80
#define CCFormCellHeightImage 80

typedef NS_ENUM(NSUInteger, CCFormElementType) {
    CCFETypeText = 0,
    CCFETypeMultText = 1,
    CCFETypePicker = 2,
    CCFETypeDatePicker = 3,
    CCFETypeImagePicker = 4
};

@interface CCFormElement : CCFormBasicElement

@property (assign, nonatomic) CCFormElementType type;
@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSString * iconName;
@property (strong, nonatomic) NSString * accessoryIconName;
@property (strong, nonatomic) NSString * placeholder;
@property (strong, nonatomic) id value;
@property (assign, nonatomic) BOOL secureTextEntry;
@property (assign, nonatomic) UIKeyboardType keyboardType;
@property (assign, nonatomic) UITextAutocapitalizationType autocapitalizationType;

+ (CCFormElement*)elementWithType:(CCFormElementType)type title:(NSString*)title iconName:(NSString*)iconName key:(NSString*)key defaultValue:(NSString*)defaultValue;

@end
