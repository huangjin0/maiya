//
//  SettlementViewController.m
//  IOSProject
//
//  Created by IOS002 on 15/6/5.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "SettlementViewController.h"
#import "SettlementCell.h"

@interface SettlementViewController ()<UITableViewDataSource,UITableViewDelegate>{
//    UITableView    * _inTableView;
    NSMutableArray * _infoArr;
    UIButton       * _adressbtn;
}

@end

@implementation SettlementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButtonToNavigation];
    
    self.navigationItem.title = @"结算";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//返回单元格个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

//定制单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identify = @"indentify";
    SettlementCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[SettlementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.settlementIndexPath = indexPath;
    [cell setSettlementCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//设置高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.row)
        return 69;
    else if (1 == indexPath.row)
        return 10;
    else if (2 == indexPath.row)
        return 90;
    else if (3 == indexPath.row)
        return 90;
    else if (4 == indexPath.row)
        return 90;
    else if (5 == indexPath.row)
        return 15;
    else if (6 == indexPath.row)
        return 55;
    else if (7 == indexPath.row)
        return 50;
    else if (8 == indexPath.row)
        return 100;
    else
        return 80;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CCRequest
-(BOOL)startRequest:(NSInteger)requestID {
    if ([super startRequest:requestID]) {
        if (requestID == 0) {
//            [_client getListOfUserAddress];
        }
        return YES;
    }
    return NO;
}

-(BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result {
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 0) {
            NSArray *dataArr = [result objectForKey:@"data"];
            for (NSDictionary *dic in dataArr) {
            NSMutableDictionary *addressInfo = [NSMutableDictionary dictionary];
            [addressInfo setObject:[dic objectForKey:@"link_uname"] forKey:@"consignee"];
            [addressInfo setObject:[dic objectForKey:@"tel"] forKey:@"connetNum"];
            [addressInfo setObject:[dic objectForKey:@"extend1"] forKey:@"area"];
            [addressInfo setObject:[dic objectForKey:@"address"] forKey:@"address"];
            [addressInfo setObject:[dic objectForKey:@"addr_id"] forKey:@"addrId"];
//            [_adressArr addObject:addressInfo];
            }

        }
        return YES;
    }
    return NO;
}

@end
