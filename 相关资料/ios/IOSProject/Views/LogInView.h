//
//  LogInView.h
//  IOSProject
//
//  Created by IOS002 on 15/7/22.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LogOrRegisterDelegate <NSObject>

-(void)clickLogInOrRegistertag:(NSInteger)tag;

@end

@interface LogInView : UIView

@property (weak,nonatomic) id<LogOrRegisterDelegate>delegate;
-(void)unlogInviewDidLoad;
@end
