//
//  CCPhotoScrollView.h
//  CCFramework
//
//  Created by Kiwi on 10/20/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCPhotoScrollViewCell.h"

@class CCPhotoScrollView;

@protocol CCPhotoScrollViewDataSource <NSObject>
@required
- (NSInteger)photoScrollViewNumberOfIndexes;
- (CCPhotoScrollViewCell*)photoScrollView:(CCPhotoScrollView*)sender cellForIndex:(NSInteger)index;
@end

@protocol CCPhotoScrollViewDelegate <NSObject, UIScrollViewDelegate>
@optional
- (void)photoScrollView:(CCPhotoScrollView*)sender willDisplayCell:(CCPhotoScrollViewCell*)cell forIndex:(NSInteger)index;
@end

@interface CCPhotoScrollView : UIScrollView {
    
}

@property (unsafe_unretained, nonatomic) IBOutlet id <CCPhotoScrollViewDataSource> dataSource;
@property (unsafe_unretained, nonatomic) IBOutlet id <CCPhotoScrollViewDelegate> delegate;
@property (readonly, nonatomic) NSInteger currentIndex;
@property (assign, nonatomic) CGFloat scrollSpacing;

- (void)initializeBasic;
- (void)reloadData;
- (CCPhotoScrollViewCell*)cellForIndex:(NSInteger)index;

@end
