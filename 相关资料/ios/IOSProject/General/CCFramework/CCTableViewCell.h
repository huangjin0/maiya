//
//  CCTableViewCell.h
//  CCFramework
//
//  Created by Kiwi on 10/14/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCTableViewCell : UITableViewCell

@property (strong, nonatomic) NSIndexPath * indexPath;

/**
 *	Copyright © 2013 CC Inc. All rights reserved.
 *
 *	initialize with reuse identifier
 */
- (id)initWithReuseIdentifier:(NSString*)reuseIdentifier;

/**
 *	Copyright © 2013 CC Inc. All rights reserved.
 *
 *	remove all subviews that tag == 0 on contentView
 */
- (void)cleanUpSubviews;

- (void)setSeparatorLastOne:(BOOL)lastOne leftInset:(CGFloat)left;

@end
