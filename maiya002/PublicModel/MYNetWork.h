//
//  MYNetWork.h
//  maiya002
//
//  Created by HuangJin on 16/9/15.
//  Copyright © 2016年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYNetWork : NSObject
+ (BOOL) isConnectionAvailable;
+ (BOOL)valiMobile:(NSString *)mobile;
@end
