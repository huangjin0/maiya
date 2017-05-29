//
//  MYNetWorking.m
//  maiya002
//
//  Created by HuangJin on 16/9/15.
//  Copyright © 2016年 com. All rights reserved.
//

#import "MYNetWorking.h"
#import "MYNetWork.h"

@implementation MYNetWorking
/*
 //
 post请求网络数据
 
 */
+(void)postSendData:(NSString*)subURL paremts:(NSDictionary *)datas sucess:(Sucess) sucess Failure:(Failure) failure;
{
    @autoreleasepool {
        if (![MYNetWork isConnectionAvailable]) {
            
            [self showErrorMessage:@"无法连接网络"];
            
            return;
        }
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSMutableSet *set = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
        [set addObject:@"text/html"];
        [set addObject:@"text/plain"];
        [set addObject:@"application/json"];
        
        manager.responseSerializer.acceptableContentTypes = set;
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 15.0f;
        NSString *url=[NSString stringWithFormat:@"%@%@",BASEURL,subURL ] ;
        [manager POST:url parameters:datas success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject)
        {
            
            sucess(responseObject);
            
            
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
          
            failure(@"");
            
        }];
        
        
        
    }
}

+(void)showErrorMessage:(NSString*)title
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow.rootViewController.view animated:YES];
    
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = title;
    // Move to bottm center.
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    hud.backgroundColor=[UIColor colorWithHex:0x4c4c4c alpha:1.0];
    hud.tintColor=[UIColor whiteColor];
    [hud hideAnimated:YES afterDelay:3.f];


}

@end
