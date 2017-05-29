//
//  CCFormViewCell.h
//  CRM
//
//  Created by Kiwi on 10/22/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCFormElement.h"

@class CCFormViewCell;

@protocol CCFormViewCellDelegate <NSObject>
@optional
- (void)formCellTriggered:(CCFormViewCell*)sender;
- (void)formCellDidBeginEditing:(CCFormViewCell*)sender;
- (void)formCellFieldWillReturn:(CCFormViewCell*)sender;
@end

@interface CCFormViewCell : UIView

@property (strong, nonatomic) CCFormElement * element;
@property (strong, nonatomic) UITextView * textView;
@property (strong, nonatomic) UITextField * textField;
@property (strong, nonatomic) UIImageView * imageView;
@property (unsafe_unretained, nonatomic) id <CCFormViewCellDelegate> delegate;

@property (assign, nonatomic) id value;

+ (id)cellWithFrame:(CGRect)frame element:(CCFormElement*)element;

@end
