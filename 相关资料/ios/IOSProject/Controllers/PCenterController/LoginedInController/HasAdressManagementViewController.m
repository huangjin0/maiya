//
//  HasAdressManagementViewController.m
//  IOSProject
//
//  Created by IOS004 on 15/6/15.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//
/**
 *  地址管理
 */

#import "HasAdressManagementViewController.h"
#import "AddAdressViewController.h"

@interface HasAdressManagementViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation HasAdressManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButtonToNavigation];
    
    self.navigationItem.title = @"地址管理";
    
    UIButton * loadbtn = [UIButton roundedRectButtonWithTitle:@"+添加收货地址" color:[UIColor colorFromHexCode:@"#489925"] raduis:5.0];
    loadbtn.frame = CGRectMake(self.view.width/2 - 145, 270, 290, 45);
    [loadbtn addTarget:self action:@selector(backAddaddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadbtn];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

//每个sections有多少个cell，默认为1；
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIButton * defaultbtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width - 120, 25, 100, 20)];
        [defaultbtn setTitle:@"设为默认" forState:UIControlStateNormal];
        [defaultbtn setTitleColor:[UIColor colorFromHexCode:@"#489925"] forState:UIControlStateNormal];
        defaultbtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [cell addSubview:defaultbtn];
        
        UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 50, 20)];
        lab1.text = @"郑强";
        [cell addSubview:lab1];
        UILabel * lab2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 200, 20)];
        lab2.text = @"18722345567";
        [cell addSubview:lab2];
        UILabel * lab3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 25, 300, 20)];
        lab3.text = @"四川省成都市锦江区莲花小区";
        [cell addSubview:lab3];
        UILabel * lab4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, 300, 20)];
        lab4.text = @"2栋1单元2603号";
        [cell addSubview:lab4];
    }
    return cell;
}

//设置height;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 69;
}

//设置footer;
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

/**
 *  点击cell跳转页面
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击tableviewcell时颜色一闪而过
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    AddAdressViewController * addadress = [[AddAdressViewController alloc] init];
    [self.navigationController pushViewController:addadress animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backAddaddress{
    AddAdressViewController * addadress = [[AddAdressViewController alloc] init];
    [self.navigationController  pushViewController:addadress animated:YES];//popToViewController:addadress animated:YES];
}

@end
