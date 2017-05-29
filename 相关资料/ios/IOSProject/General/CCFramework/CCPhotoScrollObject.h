//
//  CCPhotoScrollObject.h
//  CCFramework
//
//  Created by Kiwi on 10/20/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCPhotoScrollObject : NSObject

// getters only
// you have to return an image object for each instance
// -must be implemented in sub-classes
@property (readonly, nonatomic) UIImage * image;

@end
