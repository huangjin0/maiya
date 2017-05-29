//
//  CCFilterView.h
//  DoctorFixBao
//
//  Created by Kiwi on 11/26/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCFilterObject : NSObject

@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSMutableArray * contentArray;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (assign, nonatomic) BOOL hasAllOption; // Default is YES;

+ (id)objectWithTitle:(NSString*)title content:(NSArray*)array;
+ (id)objectWithTitle:(NSString*)title content:(NSArray*)array hasAllOption:(BOOL)hasAllOption;

@end



@protocol CCFilterViewDelegate <NSObject>
@optional
- (void)filterViewWillShowUp;
- (void)filterViewDidShowUp;
- (void)filterViewWillDismiss:(BOOL)modified;
- (void)filterViewDidDismiss:(BOOL)modified;
@end


@interface CCFilterView : UIView

@property (unsafe_unretained, nonatomic) IBOutlet id <CCFilterViewDelegate> delegate;
@property (strong, nonatomic) NSMutableArray * contentArray;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (strong, nonatomic) UIColor * tintColor;

- (void)addFilterObject:(CCFilterObject*)object;
- (void)reloadData;

- (NSInteger)selectedIndexAtIndex:(NSInteger)index;
- (NSString*)selectedValueAtIndex:(NSInteger)index;

@end
