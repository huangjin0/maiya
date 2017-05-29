//
//  CCPickerView.h
//  CCFramework
//
//  Created by kiwi on 6/5/13.
//  Copyright (c) 2013 CC inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCPickerView;

@protocol CCPickerViewDelegate <NSObject>

@optional
- (void)pickerViewWillDismiss:(CCPickerView*)sender;
- (void)pickerViewDidDismiss:(CCPickerView*)sender;
- (void)pickerViewDidCancel:(CCPickerView*)sender;

@end

typedef enum CCPickerType {
    CCPickerDefault = 0,
    CCPickerWithSubSelections = 1 << 0,
    CCPickerDate = 1 << 1,
    CCPickerTime = 1 << 2,
    CCPickerTimeArea = 1 << 3
}CCPickerType;

@interface CCPickerView : UIView

@property (assign, nonatomic) id <CCPickerViewDelegate> delegate;
@property (strong, nonatomic) NSMutableArray * content;
@property (strong, nonatomic) NSMutableArray * selections;
@property (strong, nonatomic) NSDate * selectedDate;
@property (strong, nonatomic) NSDate * selectedDateOther;

@property (strong, nonatomic) NSIndexPath * indexPath;
@property (strong, nonatomic) NSString * identifier;

// For Date Time Only
@property (assign, nonatomic) NSDate * minimumDate;
@property (assign, nonatomic) NSDate * maximumDate;

- (id)initWithDel:(id)del;
- (id)initWithDel:(id)del type:(CCPickerType)ty;
- (void)addContentArray:(id)object;

- (void)show;

@end



@interface CCPickerObject : NSObject

@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSArray * subArray;

@end



@interface KNumber : NSObject

@property (nonatomic, assign) NSInteger value;

+ (KNumber*)numberWithValue:(NSInteger)val;

@end
