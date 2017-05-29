//
//  AddressSelectView.h
//  IOSProject
//
//  Created by IOS002 on 16/5/25.
//  Copyright © 2016年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tapAddressBlock)(NSInteger tag);
typedef void(^confirmBlock)(void);

@interface AddressSelectView : UIView

@property (strong, nonatomic) IBOutlet UILabel *cityLab;
@property (strong, nonatomic) IBOutlet UILabel *areaLab;
@property (strong, nonatomic) IBOutlet UILabel *countryLab;
@property (strong, nonatomic) IBOutlet UILabel *storeLab;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) tapAddressBlock block;
@property (strong, nonatomic) confirmBlock confirmBlock;

- (void)tapAddressWithBlock:(tapAddressBlock)block;
- (void)confirmAddressWithBlock:(confirmBlock)block;

//显示、隐藏addressSelectView
- (void)showInView:(UIView *)view;
- (void)hidenBackView;

//tableview
- (void)showTableView;

- (void)hidenTableView;

@end
