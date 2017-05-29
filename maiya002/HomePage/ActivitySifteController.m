//
//  ActivitySifteController.m
//  maiya002
//
//  Created by HuangJin on 16/9/27.
//  Copyright © 2016年 com. All rights reserved.
//

#import "ActivitySifteController.h"

@implementation ActivitySifteController

-(void)viewDidLoad
{
    [super viewDidLoad];

}

-(void)removeView
{
    [self.navigationController removeFromParentViewController];
    [self.view removeFromSuperview];

}
- (IBAction)resetData:(id)sender {
    [self removeView];
}
- (IBAction)queure:(id)sender {
    [self removeView];
}
- (IBAction)tapTopView:(id)sender {
    [self removeView];
}

@end
