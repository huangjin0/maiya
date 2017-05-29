//
//  ADView.h
//  Dengdao
//
//  Created by 刘sfwen on 15/7/5.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ADView;
@protocol ADViewDelegate <NSObject>

@optional
- (void)clickedSomeoneOfAD:(NSInteger)uid;
- (void)needReceiveAd_id:(ADView *)view tag:(NSInteger)tag;

@end

@interface ADView : UIView

@property (assign, nonatomic) id <ADViewDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIScrollView * scrollView;
@property (strong, nonatomic) NSArray * imageArray;

- (void)viewDidLoad;

@end
