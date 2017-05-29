//
//  ClassficationTableViewCell.h
//  IOSProject
//
//  Created by IOS004 on 15/6/9.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicCell.h"

@interface ClassficationTableViewCell : BasicCell

@property (nonatomic,weak) NSString    * categoryText;
@property (nonatomic,weak) NSString    * imagetitle;
@property (nonatomic,weak) UIImageView * logoImage;
@property (nonatomic,weak) UILabel     * category;
@property (nonatomic,weak) UIView      * viewShow1;
+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end
