//
//  SettlementCell.h
//  IOSProject
//
//  Created by IOS002 on 15/6/5.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicCell.h"

@protocol settlementcellDelegate <NSObject>

- (void)receivingAddress;
- (void)submitOrders;

@end

@interface SettlementCell : BasicCell

@property (strong,nonatomic) NSIndexPath * settlementIndexPath;
- (void) setSettlementCell;
@property(assign,nonatomic)id<settlementcellDelegate> delegate;

@end
