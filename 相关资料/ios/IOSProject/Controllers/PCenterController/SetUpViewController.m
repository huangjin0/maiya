//
//  SetUpViewController.m
//  IOSProject
//
//  Created by IOS004 on 15/6/8.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//
/**
 设置
 */

#import "SetUpViewController.h"
//#import "PersonalCenterViewController.h"
#import "AboutUsViewController.h"
#import "ServiceAgreementViewController.h"
#import "iSH_ServiceAgreeMentViewController.h"

@interface SetUpViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView * _tableview;
    NSString    * _content;
    NSString    * _contentUs;
}

@end

@implementation SetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButtonToNavigation];
    self.navigationItem.title = @"设置";

}

/**
 *  tableview一共有多少组
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

/**
 *  返回行数，每组有多少行
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

/**
 *  定制单元格内容、每行显示内容
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [_tableview dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
    }
    //判断是第几组的第几行
    if (0 == indexPath.row) {
        cell.textLabel.text = @"关于我们";
        cell.textLabel.textColor = [UIColor colorFromHexCode:@"#333333"];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (1 == indexPath.row){
        cell.textLabel.text = @"服务协议";
        cell.textLabel.textColor = [UIColor colorFromHexCode:@"#333333"];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (2 == indexPath.row){
        cell.textLabel.text = @"联系客服";
        cell.textLabel.textColor = [UIColor colorFromHexCode:@"#333333"];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width - 170, 10, 160, 20)];
        lab.text = @"0834-3283366";
        lab.textColor = [UIColor colorFromHexCode:@"#dfdfdd"];
        [cell addSubview:lab];
        //            }
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc] init];
//    view.frame = CGRectMake(0, 0, self.view.width, self.view.width);
    if (section == 0) {
        UIImageView * logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width/2 - 80, 50, 160, 80)];
        logoImage.image = [UIImage imageNamed:@"iSH_HomeLogo"];
        [view addSubview:logoImage];
        
        view.userInteractionEnabled = YES;
        logoImage.userInteractionEnabled = YES;
        
        UIButton * exitbtn = [UIButton roundedRectButtonWithTitle:@"退出当前登录" color:RGBCOLOR(255, 95, 5) raduis:5.0];
        if ([IEngine engine].isSignedIn) {
            exitbtn.hidden = NO;
        } else {
            exitbtn.hidden = YES;
        }
        exitbtn.frame = CGRectMake(16, 170, ViewWidth - 32, 44);
        [exitbtn addTarget:self action:@selector(exitloginAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:exitbtn];
        view.height = 200;
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 200;
    } else return 0;
}

/**
 *  点击cell时跳转页面
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击颜色一闪
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
        if (0 == indexPath.row){
            AboutUsViewController * aboutus = [[AboutUsViewController alloc] init];
            [self.navigationController pushViewController:aboutus animated:YES];
        }
        if (1 == indexPath.row) {
             iSH_ServiceAgreeMentViewController * serviceagreement = [[iSH_ServiceAgreeMentViewController alloc] init];
            [self.navigationController pushViewController:serviceagreement animated:YES];
        }
        if (2 == indexPath.row) {
            UIWebView * callWebview = [[UIWebView alloc] init];
            NSURL * telURL = [NSURL URLWithString:@"tel://0834-3283366"];
            [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
            [self.view addSubview:callWebview];
        }
}

/**
 *  点击退出登录跳转到登录界面
 */
- (void)exitloginAction:(UIButton *)sender {
    [[IEngine engine] signout];
    if (_delegate != nil && [_delegate respondsToSelector:@selector(logOutToRootVC)]) {
        [self.navigationController popViewControllerAnimated:YES];
        [_delegate logOutToRootVC];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cartNum" object:nil userInfo:@{@"cartNum":@"0"}];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Requests服务协议、关于我们

- (BOOL)startRequest:(NSInteger)requestID{
    if ([super startRequest:requestID]) {
        //调用接口API
        if (requestID == 111) {
            [_client theServiceAgreement:_content];
        }
        if (requestID == 101){
            [_client aboutUs:_contentUs];
        }
        return YES;
    }
    return NO;
}

- (BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result{
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 111) {
            NSDictionary * dic = [result getDictionaryForKey:@"data"];
            DeviceLogPrint(YES, @"=====%@",[dic objectForKey:@"content"]);
            _content = [dic objectForKey:@"content"];
      //      [self startRequest:101];
        }
        if (sender.requestID == 101) {
            NSDictionary * data = [result getDictionaryForKey:@"data"];
            DeviceLogPrint(YES, @"-----%@",[data objectForKey:@"content"]);
            _contentUs = [data objectForKey:@"content"];
        }
        return YES;
    }
    return NO;
}
@end
