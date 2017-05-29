//
//  RightTableView.h
//  IOSProject
//
//  Created by IOS004 on 15/6/10.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RightTableViewDelegate <NSObject>

- (void)quantity:(NSInteger)quantity money:(NSInteger)money key:(NSString *)key;
- (void)clicklogWithSender:(UIButton *)sender;

@end

@interface RightTableView : UITableView

@property (nonatomic ,strong) NSString *secondArray;
@property (nonatomic ,strong) NSMutableArray *rightArray;
@property (nonatomic ,weak) id<RightTableViewDelegate>rightDelegate;
- (void)classifiedSection;


@end
