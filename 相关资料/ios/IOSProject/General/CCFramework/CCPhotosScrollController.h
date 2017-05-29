//
//  CCPhotosScrollController.h
//  CCFramework
//
//  Created by Kiwi on 10/20/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import "CCViewController.h"
#import "CCPhotoScrollView.h"
#import "CCPhotoScrollObject.h"

@interface CCPhotosScrollController : CCViewController

- (id)initWithPhotos:(NSArray*)photos currentIndex:(NSInteger)currentIndex;

/**
 *	Copyright © 2013 CC Inc. All rights reserved.
 *
 *	to be implemented in sub-classes
 */
- (void)singleTapOnPhoto;

@end
