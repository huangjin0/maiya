//
//  CCFormView.h
//  CRM
//
//  Created by Kiwi on 10/21/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCFormSection.h"
#import "CCFormBasicElement.h"
#import "CCFormElement.h"
#import "CCFormViewCell.h"

@protocol CCFormViewDelegate <NSObject>
@optional
- (void)formViewDidTriggerCell:(CCFormViewCell*)cell;
- (void)formViewDidBeginEditingCell:(CCFormViewCell*)cell;
@end

@interface CCFormView : UIView

@property (unsafe_unretained, nonatomic) id <CCFormViewDelegate> delegate;
@property (strong, nonatomic) NSArray * sections;

+ (id)viewWithSections:(NSArray*)sections width:(CGFloat)width;

- (void)viewWillAppear;
- (void)viewWillDisappear;

- (id)cellForIndexPath:(NSIndexPath*)indexPath;
- (id)cellForKey:(NSString*)key;

- (void)addKeyboardControlForScrollView:(UIScrollView*)scrollView;

@end
