//
//  AddressManagementViewController.m
//  IOSProject
//
//  Created by IOS004 on 15/6/9.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//


#import "AddressManagementViewController.h"
#import "AddAdressViewController.h"
#import "AddressViewCell.h"

@interface AddressManagementViewController ()<SaveAddressDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,SWTableViewCellDelegate,defAddressDelegate> {
    //    地址列表
    NSMutableArray *_adressArr;
    NSInteger _sec;
    UIButton * _loadbtn;
    UITableView *_tableView;
//    UIScrollView *_scrollView;
//    地址Id
    NSString *_addId;
}

@end

@implementation AddressManagementViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _adressArr = [NSMutableArray array];
    [self startRequest:0];
    // Do any additional setup after loading the view.
    [self addBackButtonToNavigation];
    self.navigationItem.title = @"地址管理";
}

//地址为空，界面布局
-(void)emptyAddressLoadView {
    UIImageView * adressImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width / 2 - 60, 35, 120, 125)];
    adressImage.image = [UIImage imageNamed:@"dizhi_pic"];
    [self.view addSubview:adressImage];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width / 2 - 56, 185, 112, 20)];
//    label.backgroundColor = [UIColor redColor];
    label.text = @"还没有收货地址哦";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorFromHexCode:@"#999999"];
    [self.view addSubview:label];
    [self addAddressButton];
}


/*
 **添加地址按钮
 */
-(void)addAddressButton {
    _loadbtn = [UIButton roundedRectButtonWithTitle:@"+添加收货地址" color:RGBCOLOR(255,95,5) raduis:5.0];
    [self loadBtnFrame];
}

-(void)loadBtnFrame {
    _loadbtn.frame = CGRectMake(self.view.width/2 - 145, 245, 290, 45);
    [_loadbtn addTarget:self action:@selector(addAdress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loadbtn];
}


/**
 * 添加tableView
 */
-(void)loadTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.backgroundColor = Color_bkg_lightGray;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}


//TODO
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_adressArr count] + 1;
}

//每个sections有多少个cell，默认为1；
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier1 = @"identifier1";
    static NSString * identifier2 = @"identifier2";
    if (indexPath.section == [_adressArr count]) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
            cell.backgroundColor = [UIColor clearColor];
           }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        UIButton * addAddressBtn = [UIButton roundedRectButtonWithTitle:@"+添加收货地址" color:RGBCOLOR(255,95,5) raduis:5.0];
        addAddressBtn.frame = CGRectMake(self.view.width / 2 - 145, 30, 290, 45);
        [addAddressBtn addTarget:self action:@selector(addAdress) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:addAddressBtn];
        return cell;
    } else {
        NSMutableArray *rightUtilityButton = [NSMutableArray array];
        [rightUtilityButton addUtilityButtonWithColor:RGBCOLOR(255, 95, 5) icon:[UIImage imageNamed:@"delete_pic.png"]];
        AddressViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        if (!cell) {
            cell = [[AddressViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2 containingTableView:_tableView leftUtilityButtons:nil rightUtilityButtons:rightUtilityButton];
        }
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell hideUtilityButtonsAnimated:NO];
        cell.delegate = self;
        cell.defDelegate = self;
        NSDictionary *dic = [_adressArr objectAtIndex:indexPath.section];
        cell.item = dic;
        return cell;
    }
}


//设置height;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == _adressArr.count) {
        return 105;
    }
    return 69;
}

//设置footer;
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == _adressArr.count) {
        return 0;
    } else {
        return 10;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = Color_bkg_lightGray;
    return backView;
}

/**
 *  点击cell跳转页面
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击tableviewcell时颜色一闪而过
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section != [_adressArr count]) {
        NSDictionary *adddic = [_adressArr objectAtIndex:indexPath.section];
        if (_type == 1) {
            if (_delegate != nil && [_delegate respondsToSelector:@selector(backToSettleVCWithDic:)]) {
                [_delegate backToSettleVCWithDic:adddic];
                [self.navigationController popViewControllerAnimated:YES];
                _addId = [adddic getStringValueForKey:@"addrId" defaultValue:nil];
                [self startRequest:2];
            }
        } else {
            AddAdressViewController * addadress = [[AddAdressViewController alloc] init];
            NSDictionary *dic = [_adressArr objectAtIndex:indexPath.section];
            addadress.cossigneNam = [dic getStringValueForKey:@"consignee" defaultValue:nil];
            addadress.linkPhone = [dic getStringValueForKey:@"connetNum" defaultValue:nil];
            addadress.sendArea = [dic getStringValueForKey:@"area" defaultValue:nil];
            addadress.detailAddress = [dic getStringValueForKey:@"address" defaultValue:nil];
            addadress.delegate = self;
            addadress.type = 1;
            addadress.addrid = [adddic getStringValueForKey:@"addrId" defaultValue:nil];
            [self.navigationController pushViewController:addadress animated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addAdress{
    AddAdressViewController * addadress = [[AddAdressViewController alloc] init];
//    addadress.ucode = self.ucode;
    addadress.delegate = self;
    addadress.type = 2;
    [self.navigationController pushViewController:addadress animated:YES];
}

#pragma mark - CCRequest
-(BOOL)startRequest:(NSInteger)requestID {
    if ([super startRequest:requestID]) {
        if (requestID == 0) {
            [_client getListOfUserAddress];
        } else if (requestID == 1) {
            [_client cancelAddressWithAddId:[_addId intValue]];
        } else if (requestID == 2) {
            [_client setDefaultsAddressWithAddrId:[_addId intValue]];
        } else if (requestID == 3) {
            [_client cancelDefaultsAddressWithAddrId:[_addId intValue]];
        }
        return YES;
    }
    return NO;
}

-(BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result {
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 0) {
            [_adressArr removeAllObjects];
            NSArray *dataArr = [result objectForKey:@"data"];
            for (NSDictionary *dic in dataArr) {
                NSMutableDictionary *addressInfo = [NSMutableDictionary dictionary];
                [addressInfo setObject:[dic objectForKey:@"link_uname"] forKey:@"consignee"];
                [addressInfo setObject:[dic objectForKey:@"tel"] forKey:@"connetNum"];
                [addressInfo setObject:[dic objectForKey:@"extend1"] forKey:@"area"];
                [addressInfo setObject:[dic objectForKey:@"address"] forKey:@"address"];
                [addressInfo setObject:[dic objectForKey:@"addr_id"] forKey:@"addrId"];
                [addressInfo setObject:[dic getStringValueForKey:@"is_default" defaultValue:nil] forKey:@"isDefult"];
                [_adressArr addObject:addressInfo];
            }
                if (_adressArr.count == 0) {
                    [self.view removeAllSubviews];
                    [self emptyAddressLoadView];
                } else {
                    [self.view removeAllSubviews];
                    [self loadTableView];
                }
        }
        if (sender.requestID == 2 || sender.requestID == 3) {
            [self startRequest:0];
        }
        return YES;
    }
    return NO;
}

#pragma mark - SaveAddressDelegate
-(void)backAddressViewControllerWithDic:(NSDictionary *)dic {
    NSMutableDictionary *addressInfo = [NSMutableDictionary dictionary];
    [addressInfo setObject:[dic objectForKey:@"link_uname"] forKey:@"consignee"];
    [addressInfo setObject:[dic objectForKey:@"tel"] forKey:@"connetNum"];
    [addressInfo setObject:[dic objectForKey:@"extend1"] forKey:@"area"];
    [addressInfo setObject:[dic objectForKey:@"address"] forKey:@"address"];
    [addressInfo setObject:[dic objectForKey:@"addr_id"] forKey:@"addrId"];
    if (_adressArr.count == 0) {
        [self.view removeAllSubviews];
        [_adressArr addObject:addressInfo];
        [self loadTableView];
    } else {
        [_adressArr addObject:addressInfo];
        [_loadbtn removeFromSuperview];
        [_tableView reloadData];
        [self.view addSubview:_tableView];
    }
}

-(void)backaddressForEdit {
    [self startRequest:0];
}

#pragma mark - SWTableViewCellDelegate
- (void)swippableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    NSDictionary *dic = [_adressArr objectAtIndex:indexPath.section];
    _addId = [dic getStringValueForKey:@"addrId" defaultValue:nil];
    [_adressArr removeObjectAtIndex:indexPath.section];
    [_tableView deleteSections:[[NSIndexSet alloc] initWithIndex:indexPath.section]  withRowAnimation:UITableViewRowAnimationAutomatic];
    if (_adressArr.count == 0) {
        [self.view removeAllSubviews];
        [self emptyAddressLoadView];
    }
    [self startRequest:1];
    
}

#pragma mark - defAddressDelegate 
-(void)setDefaultAddressWithIsDefault:(BOOL)isDefault cell:(AddressViewCell *)cell {
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    NSDictionary *dic = [_adressArr objectAtIndex:indexPath.section];
    _addId = [dic getStringValueForKey:@"addrId" defaultValue:nil];
    if (isDefault) {
        [self startRequest:2];
    } else {
        [self startRequest:3];
    }
}


@end
