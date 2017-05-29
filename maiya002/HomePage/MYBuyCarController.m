//
//  MYBuyCarController.m
//  maiya002
//
//  Created by HuangJin on 16/9/10.
//  Copyright © 2016年 com. All rights reserved.
//

#import "MYBuyCarController.h"
#import "MYBuycarShowCell.h"
@interface MYBuyCarController()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation MYBuyCarController
-(void)viewDidLoad
{
    [super viewDidLoad];
    

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;

}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MYBuycarShowCell *cell=[tableView dequeueReusableCellWithIdentifier:BUYCARSHOWCELL];
    if (cell) {
        
        
    }
    
    if(indexPath.section==0)
    {
        cell.nowPrice.text=@"1222.03";
        cell.oldPrice.text=@"1992.03";
        cell.title.text=@"Hisense/海信 LED55EC760UC 55吋曲面4K超清HDR液晶电视机平板60";
        
    
    }else if (indexPath.section==1)
    {
        cell.nowPrice.text=@"12.03";
        cell.oldPrice.text=@"92.03";
        cell.title.text=@"美赞臣蓝臻Enfinitas 3段婴儿奶粉900g双罐(1-3岁) 荷兰进口";
        
    }else if (indexPath.section==2)
    {
        cell.nowPrice.text=@"35553.03";
        cell.oldPrice.text=@"92223.03";
        cell.title.text=@"男童T恤长袖普哆衣2016春秋装童装中大童韩版宽松体恤儿童打底衫男童T恤长袖普哆衣2016春秋装童装中大童韩版宽松体恤儿童打底衫";
        
    }
    
    return cell;

}

@end
