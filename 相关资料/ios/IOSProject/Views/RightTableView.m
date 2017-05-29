//
//  RightTableView.m
//  IOSProject
//
//  Created by IOS004 on 15/6/10.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "RightTableView.h"
#import "RightTableViewCell.h"
#import "ClassificationOfGoodsViewController.h"

@interface RightTableView ()<UITableViewDataSource,UITableViewDelegate, RightTableViewcellDelegate,RightTableViewDelegate>

@end

@implementation RightTableView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"identifier";
 //   RightTableViewCell * cell = [RightTableViewCell cellWithTableView:tableView];
    RightTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[RightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.backgroundColor = [UIColor colorFromHexCode:@"#ececec"];
    cell.delegate = self;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone; //取消cell点击效果

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray * arr = @[@"1",@"2",@"3"];
    return [arr objectAtIndex:section];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * myview = [[UIView alloc] init];
    UIButton * clickbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.width, 20)];
    [clickbtn addTarget:self action:@selector(clicklogWithSender:) forControlEvents:UIControlEventTouchUpInside];
    [myview addSubview:clickbtn];
    
    UILabel * textlab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 50, 20)];
    textlab.text = @"123";
    [clickbtn addSubview:textlab];
    return myview;
}

#pragma mark - Scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat sectionHeaderHeight = 100;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }else if (scrollView.contentOffset.y >= sectionHeaderHeight){
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (void)clicklogWithSender:(UIButton *)sender{
    if (_rightDelegate && [_rightDelegate respondsToSelector:@selector(clicklogWithSender:)]) {
        [_rightDelegate clicklogWithSender:sender];
    }
    
    UIViewController * viewcontroller = [RightTableView viewController:self];
    ClassificationOfGoodsViewController * goods = [[ClassificationOfGoodsViewController alloc] init];
    [viewcontroller.navigationController pushViewController:goods animated:YES];
}

+ (UIViewController *)viewController:(UIView *)view{
    
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    return nil;
}

- (void)quantity:(NSInteger)quantity money:(NSInteger)money key:(NSString *)key{
}
- (void)classifiedSection{
}
@end
