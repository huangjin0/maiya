//
//  iSH_ServiceAgreeMentViewController.m
//  IOSProject
//
//  Created by WangShanhua on 16/6/29.
//  Copyright © 2016年 CC Inc. All rights reserved.
//

#import "iSH_ServiceAgreeMentViewController.h"
#import "CoreLabel.h"

@interface iSH_ServiceAgreeMentViewController () {
    IBOutlet CoreLabel *_serviceLab; //协议Lab
    IBOutlet NSLayoutConstraint *_scrollHeight;//可滑动高度
}

@end

@implementation iSH_ServiceAgreeMentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"服务协议";
    [self addBackButtonToNavigation];
    NSString *seriViceStr = @"1、服务条款的确认和接纳:\ni生活及i生活各项内容和服务的所有权归本公司拥有。用户在接受本服务之前，请务必仔细阅读本条款。用户使用服务，或通过完成注册程序，表示用户接受所有服务条款。\n2、用户同意：\n(1) 提供及时、详尽及准确的个人资料。\n(2) 不断更新注册资料、符合及时、详尽、准确的要求。如果用户提供的资料不准确，本网站有结束服务的权利。i生活将不公开用户的姓名、地址、电子邮箱、帐号和电话号码等信息（请阅隐私保护条款）。\n用户在i生活的任何行为必须遵循：\n(1) 传输资料时必须符合中国有关法规。\n(2) 使用信息服务不作非法用途和不道德行为。\n(3) 不干扰或混乱网络服务。\n(4) 遵守所有使用服务的网络协议、规定、程序和惯例。用户的行为准则是以因特网法规，政策、程序和惯例为根据的。\n3、服务条款的修改\ni生活有权在必要时修改条款，将会在页面公布。\n如果不接受所改动的内容，用户可以主动取消自己的会员资格。如果您不取消自己的会员资格，则视为接受服务条款的变动。\n4、 用户的帐号、密码和安全性\n一旦成功注册成为会员，您将有一个密码和用户名。\n用户将对用户名和密码的安全负全部责任。另外，每个用户都要对以其用户名进行的所有活动和事件负全责。您可以随时改变您的密码。\n用户若发现任何非法使用用户帐号或存在安全漏洞的情况，请立即通告本公司。\n5、拒绝提供担保\n用户明确同意使用本公司服务，由用户个人承担风险。\ni生活不担保服务一定满足用户的要求，也不担保服务不会中断，对服务的及时性、安全性、出错发生都不作担保。\n用户理解并接受：任何通过服务取得的信息资料的可靠性有用性取决于用户自己的判断，用户自己承担所有风险和责任。\n6、有限责任\ni生活对任何由于使用服务引发的直接、间接、偶然及继起的损害不负责任。\n这些损害可能来自（包括但不限于）：不正当使用服务，或传送的信息不符合规定等。\n7、对用户信息的存储和限制\ni生活不对用户发布信息的删除或储存失败负责，本公司有判定用户的行为是否符合服务条款的要求和精神的保留权利。如果用户违背了服务条款的规定，有中断对其提供服务的权利。\n　8、结束服务\n本公司可随时根据实际情况中断一项或多项服务，不需对任何个人或第三方负责或知会。\n同时用户若反对任何服务条款的建议或对后来的条款修改有异议，或对服务不满，用户可以行使如下权利：\n(1) 不再使用本公司的服务。\n(2) 通知本公司停止对该用户的服务。\n9、信息内容的所有权\n本公司的信息内容包括：文字、软件、声音、相片、录象、图表；以及其它信息，所有这些内容受版权、商标、标签和其它财产所有权法律的保护。\n用户只能在授权下才能使用这些内容，而不能擅自复制、再造这些内容、或创造与内容有关的派生产品。\n10、对于因不可抗力或因黑客攻击、通讯线路中断等不能控制的原因造成的网络服务中断或其他缺陷，导致用户不能正常使用APP，我公司不承担任何责任，但将尽力减少因此给用户造成的损失或影响。\n11、适用法律\n上述条款将适用中华人民共和国的法律，所有的争端将诉诸于本网所在地的人民法院。\n如发生服务条款与中华人民共和国法律相抵触时，则这些条款将完全按法律规定重新解释，而其它条款则依旧保持约束力。";
    _serviceLab.text = seriViceStr;
    [_serviceLab sizeToFit];
    //修改对齐
    _serviceLab.cl_verticalAlignment = CoreLabelVerticalAlignmentTop;
    //设置行间距
    _serviceLab.cl_lineSpacing = 2;
    //设置首行缩进
    _serviceLab.cl_firstLineHeadIndent = 24;
    //更新
    [_serviceLab updateLabelStyle];
    [self updateViewConstraints];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)updateViewConstraints {
    [super updateViewConstraints];
    _scrollHeight.constant = _serviceLab.height + 20;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
