//
//  ClassficationTableView.m
//  IOSProject
//
//  Created by IOS004 on 15/6/9.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "ClassficationTableView.h"
#import "ClassficationTableViewCell.h"
#import "ClassificationViewController.h"

@interface ClassficationTableView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSIndexPath * path;
@property(nonatomic,assign) BOOL is;

@end

NSString * strLast1Name = @"";

@implementation ClassficationTableView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (!_is) {
        NSInteger selectedIndex = 0;
        NSIndexPath * selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        [self tableView:self didSelectRowAtIndexPath:selectedIndexPath];
        _is=YES;
    }
}

-(void)setDockArray:(NSMutableArray *)dockarr {
 //   _dockarr = dockarr;
 //   [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dockarr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ClassficationTableViewCell *cell =[ClassficationTableViewCell cellWithTableView:tableView];
    cell.categoryText = _dockarr[indexPath.row][@"dockName"];
    cell.imagetitle = _dockarr[indexPath.row][@"imageName"];
    cell.backgroundColor=[UIColor colorFromHexCode:@"#ececec"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_path!=nil) {
        ClassficationTableViewCell *cell = (ClassficationTableViewCell *)[tableView cellForRowAtIndexPath:_path];
        cell.backgroundColor = [UIColor colorFromHexCode:@"#ececec"];
        cell.category.textColor = [UIColor blackColor];
        cell.viewShow1.hidden = YES;
        cell.logoImage.backgroundColor = [UIColor clearColor];
    }
    NSDictionary *dic = [_dockarr objectAtIndex:indexPath.row];
    NSString *cartId = [dic getStringValueForKey:@"cart_id" defaultValue:nil];
    if ([_classDelegate respondsToSelector:@selector(clickindexPathRow:index:indeXPath:cartId:)]) {
        [_classDelegate clickindexPathRow:_dockarr[indexPath.row][@"right"]  index:_path indeXPath:indexPath cartId:cartId];
    }
    //选中颜色
    ClassficationTableViewCell *cell = (ClassficationTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.category.textColor = RGBCOLOR(255, 95, 5);
    cell.backgroundColor = [UIColor whiteColor];
    cell.viewShow1.hidden = NO;
    _path=indexPath;
}

@end
