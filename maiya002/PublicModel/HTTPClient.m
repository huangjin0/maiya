//
//  HTTPClient.m
//  DengDao
//
//  Created by WangShanhua on 16/6/15.
//  Copyright © 2016年 choucheng. All rights reserved.
//

#import "HTTPClient.h"



@implementation HTTPClient

#pragma mark -Common

+ (instancetype)shareAFNetClient {
    static HTTPClient *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[HTTPClient alloc] init];
    });
    return shareInstance;
}

- (void)postWithMethod:(NSString *)method params:(NSDictionary *)params sucess:(success)sucess faile:(faile)faile{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"application/json", @"text/javascript",@"application/xml", nil];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASEURL,method];
    NSLog(@"%@",urlStr);
    [manager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *jsonResponse = [NSObject toJsonStrWithData:responseObject];
        NSLog(@"%@",jsonResponse);
        id response = [jsonResponse toDicOrArrWithStr:jsonResponse];
        NSDictionary *status = [response objectForKey:@"status"];
        NSNumber *code = [status objectForKey:@"code"];
        if (code.integerValue == 0) {
            sucess(response);
        } else if (code.integerValue == 10001) {
            faile([status objectForKey:@"msg"]);
#warning 异地登录
//            POST_NTF(NTF_DIFPLACELOGIN, nil);
        } else {
            faile([status objectForKey:@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        NSString *faileStr;
        if ([[[error valueForKeyPath:@"_userInfo"] valueForKeyPath:@"_kCFStreamErrorDomainKey"] intValue]==12&&[[[error valueForKeyPath:@"_userInfo"] valueForKeyPath:@"_kCFStreamErrorCodeKey"] intValue]==8) {
            faileStr = @"你的网络出了点问题，请检测网络或重试";
        } else {
            faileStr = [[[error valueForKeyPath:@"_userInfo"] valueForKeyPath:@"NSLocalizedDescription"] description];
        }
        faile(faileStr);
    }];
}

- (void)postWithMethod:(NSString *)method params:(NSDictionary *)params uploadFile:(NSData *)file fileKey:(NSString *)fileKey sucess:(success)sucess faile:(faile)faile {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"application/json", @"text/javascript",@"application/xml", nil];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASEURL,method];
    [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (file && fileKey) {
            [formData appendPartWithFileData:file name:fileKey fileName:@".jpeg" mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//        NSLog(@"%@",[responseObject toJsonStr]);
        NSDictionary *status = [responseObject objectForKey:@"status"];
        NSNumber *code = [status objectForKey:@"code"];
        //            NSLog(@"%d",code.integerValue);
        if (code.integerValue == 0) {
            sucess(responseObject);
        } else if (code.integerValue == 10001) {
            
        } else {
            faile([status objectForKey:@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        NSString *faileStr;
        if ([[[error valueForKeyPath:@"_userInfo"] valueForKeyPath:@"_kCFStreamErrorDomainKey"] intValue]==12&&[[[error valueForKeyPath:@"_userInfo"] valueForKeyPath:@"_kCFStreamErrorCodeKey"] intValue]==8) {
            faileStr = @"你的网络出了点问题，请检测网络或重试";
        } else {
            faileStr = [[[error valueForKeyPath:@"_userInfo"] valueForKeyPath:@"NSLocalizedDescription"] description];
        }
        faile(faileStr);
    }];
}


#pragma mark - LogIn

//注册 - 获取验证码
- (void)userGetRegistCodeWithPhone:(NSString *)phone success:(success)success progress:(progress)progress faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:phone forKey:@"phone"];
    [self postWithMethod:@"/api.php/regist/code" params:params sucess:success faile:faile];
}

//注册
- (void)userRegistWithPhone:(NSString *)phone passWord:(NSString *)passWord verifyCode:(NSString *)verifyCode success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:phone forKey:@"phone"];
    [params setObject:passWord forKey:@"password"];
    [params setObject:verifyCode forKey:@"sms_code"];
    [self postWithMethod:@"/api.php/regist/regist" params:params sucess:success faile:faile];
}

//登录
- (void)userLogInWithPhone:(NSString *)phone password:(NSString *)password success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:phone forKey:@"phone"];
    [params setObject:password forKey:@"password"];
    [self postWithMethod:@"/api.php/login/login" params:params sucess:success faile:faile];
}

//用户忘记密码获取验证码
- (void)userGetForgetCodeWithPhone:(NSString *)phone group:(NSInteger)group success:(success)success faile:(faile)faile{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:phone forKey:@"phone"];
    [params setObject:[NSNumber numberWithInteger:group] forKey:@"group"];
    [self postWithMethod:@"/api.php/useredit/password_code" params:params sucess:success faile:faile];
}

//用户忘记密码重置密码
- (void)userForgetPassWordWithPhone:(NSString *)phone password:(NSString *)password code:(NSString *)code group:(NSInteger)group success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:phone forKey:@"phone"];
    [params setObject:password forKey:@"password"];
    [params setObject:code forKey:@"code"];
    [params setObject:[NSNumber numberWithInteger:group] forKey:@"group"];
    [self postWithMethod:@"/api.php/useredit/find_password" params:params sucess:success faile:faile];
}

#pragma mark - Main
//获取banner图
- (void)userGetBannerWithType:(NSString *)type Success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:type forKey:@"type"];
    [self postWithMethod:@"/api.php/Ad/banner" params:params sucess:success faile:faile];
}

#pragma mark - Shop
//获取商家列表
- (void)ShopListWithPage:(NSInteger)page pageSize:(NSInteger)pageSize type_id:(NSInteger)type_id coordinate2D:(CLLocationCoordinate2D)coordinate2D city:(NSString *)city success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [params setObject:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"pagesize"];
//    if (type_id != 0) {
//        [params setObject:[NSNumber numberWithInteger:type_id] forKey:@"type_id"];
//    }
    [params setObject:[NSString stringWithFormat:@"%.6f",coordinate2D.longitude] forKey:@"lng"];
    [params setObject:[NSString stringWithFormat:@"%.6f",coordinate2D.latitude] forKey:@"lat"];
    [params setObject:city forKey:@"city"];
    [self postWithMethod:@"/api.php/Shoplists/lists" params:params sucess:success faile:faile];
}

//商铺评论
- (void)userGetShopCommetWithShop_id:(NSInteger)shop_id page:(NSInteger)page pagesize:(NSInteger)pagesize score:(NSInteger)score success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:shop_id] forKey:@"shop_id"];
    [params setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInteger:pagesize] forKey:@"pagesize"];
    [params setObject:[NSNumber numberWithInteger:score] forKey:@"score"];
    [self postWithMethod:@"/api.php/Shoplists/gbookList" params:params sucess:success faile:faile];
}

//搜索商家
- (void)userSearchShopWithPage:(NSInteger)page pagesize:(NSInteger)pagesize coordinate2D:(CLLocationCoordinate2D)coordinate2D city:(NSString *)city key:(NSString *)key success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInteger:pagesize] forKey:@"pagesize"];
    [params setObject:[NSString stringWithFormat:@"%.6f",coordinate2D.longitude] forKey:@"lng"];
    [params setObject:[NSString stringWithFormat:@"%.6f",coordinate2D.latitude] forKey:@"lat"];
    [params setObject:city forKey:@"city"];
    [params setObject:key forKey:@"key"];
    [self postWithMethod:@"/api.php/Shoplists/search" params:params sucess:success faile:faile];
}

//产品列表
- (void)goodsListWithShop_id:(NSInteger)shop_id success:(success)success faile:(faile)faile {
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    [parmas setObject:[NSNumber numberWithInteger:shop_id] forKey:@"shop_id"];
    [self postWithMethod:@"/api.php/goodslists/lists" params:parmas sucess:success faile:faile];
}

//附近商家
- (void)userGetNearlyShopWithCoordinate2D:(CLLocationCoordinate2D)coordinate2D city:(NSString *)city success:(success)success faile:(faile)faile {
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    [parmas setObject:[NSString stringWithFormat:@"%.6f",coordinate2D.latitude] forKey:@"lat"];
    [parmas setObject:[NSString stringWithFormat:@"%.6f",coordinate2D.longitude] forKey:@"lng"];
    [parmas setObject:city forKey:@"city"];
    [self postWithMethod:@"/api.php/Shoplists/indexlists" params:parmas sucess:success faile:faile];
}

#pragma mark - Person
//获取个人资料
- (void)userGetInfoWithUcode:(NSString *)ucode success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:ucode forKey:@"ucode"];
    [self postWithMethod:@"/api.php/userinfo/my" params:params sucess:success faile:faile];
//    [self postWithMethod:@"/api.php/userinfo/my" params:params uploadFile:nil fileKey:nil sucess:success faile:faile];
}

//修改个人资料
- (void)userEditInfoWithUcode:(NSString *)ucode real_name:(NSString *)real_name nack_name:(NSString *)nack_name sex:(NSInteger)sex head_img:(NSData *)head_img tel:(NSString *)tel birthday:(NSString *)birthday success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:ucode forKey:@"ucode"];
    if (![Uinits isEmptyText:real_name]) {
        [params setObject:real_name forKey:@"real_name"];
    }
    if (![Uinits isEmptyText:nack_name]) {
        [params setObject:nack_name forKey:@"nack_name"];
    }
    if (sex != 0) {
        [params setObject:[NSNumber numberWithInteger:sex] forKey:@"sex"];
    }
    if (![Uinits isEmptyText:tel]) {
        [params setObject:tel forKey:@"tel"];
    }
    if (![Uinits isEmptyText:birthday]) {
        [params setObject:birthday forKey:@"birthday"];
    }
//    [self postWithMethod:@"/api.php/useredit/edit_info" params:params sucess:success faile:faile];
    [self postWithMethod:@"/api.php/useredit/edit_info" params:params uploadFile:head_img fileKey:@"head_img" sucess:success faile:faile];
}

//获取地址列表
- (void)userGetAddressListWithUcode:(NSString *)ucode success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:ucode forKey:@"ucode"];
    [self postWithMethod:@"/api.php/useraddress/lists" params:params sucess:success faile:faile];
}

//添加收货地址
- (void)userAddAddressWithUcode:(NSString *)ucode coordinate2D:(CLLocationCoordinate2D)coordinate2D link_uname:(NSString *)link_uname tel:(NSString *)tel address:(NSString *)address extend1:(NSString *)extend1 address_more:(NSString *)address_more success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:ucode forKey:@"ucode"];
    [params setObject:[NSString stringWithFormat:@"%.6f",coordinate2D.latitude] forKey:@"lat"];
    [params setObject:[NSString stringWithFormat:@"%.6f",coordinate2D.longitude] forKey:@"lng"];
    [params setObject:link_uname forKey:@"link_uname"];
    [params setObject:tel forKey:@"tel"];
    [params setObject:address forKey:@"address"];
    [params setObject:extend1 forKey:@"extend1"];
    [params setObject:address_more forKey:@"address_more"];
    [self postWithMethod:@"/api.php/useraddress/add" params:params sucess:success faile:faile];
}

//设置默认收货地址
- (void)userSetDefaultAddressWithUcode:(NSString *)ucode addr_id:(NSInteger)addr_id success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:ucode forKey:@"ucode"];
    [params setObject:[NSNumber numberWithInteger:addr_id] forKey:@"addr_id"];
    [self postWithMethod:@"/api.php/useraddress/set_default" params:params sucess:success faile:faile];
}

//编辑收货地址
- (void)userEditAddressWithUcode:(NSString *)ucode addr_id:(NSInteger)addr_id coordinate2D:(CLLocationCoordinate2D)coordinate2D link_uname:(NSString *)link_uname tel:(NSString *)tel address:(NSString *)address extend1:(NSString *)extend1 address_more:(NSString *)address_more success:(success)sucess faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:ucode forKey:@"ucode"];
    [params setObject:[NSNumber numberWithInteger:addr_id] forKey:@"addr_id"];
    [params setObject:[NSString stringWithFormat:@"%.6f",coordinate2D.latitude] forKey:@"lat"];
    [params setObject:[NSString stringWithFormat:@"%.6f",coordinate2D.longitude] forKey:@"lng"];
    [params setObject:link_uname forKey:@"link_uname"];
    [params setObject:tel forKey:@"tel"];
    [params setObject:address forKey:@"address"];
    [params setObject:extend1 forKey:@"extend1"];
    [params setObject:address_more forKey:@"address_more"];
    [self postWithMethod:@"/api.php/useraddress/edit" params:params sucess:sucess faile:faile];
}

//删除收货地址
- (void)userDeleteAddressWithUcode:(NSString *)ucode addr_id:(NSInteger)addr_id success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:ucode forKey:@"ucode"];
    [params setObject:[NSNumber numberWithInteger:addr_id] forKey:@"addr_id"];
    [self postWithMethod:@"/api.php/useraddress/cancel" params:params sucess:success faile:faile];
}

//优惠券列表
- (void)userGetCouponsListWithUcode:(NSString *)ucode success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:ucode forKey:@"ucode"];
    [self postWithMethod:@"/api.php/Voucher/voucherList" params:params sucess:success faile:faile];
}

//获取消息列表
- (void)userGetMessageListWithUcode:(NSString *)ucode success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:ucode forKey:@"ucode"];
    [self postWithMethod:@"/api.php/leavemsg/msg" params:params sucess:success faile:faile];
}

//用户充值
- (void)userReChargeWithUcode:(NSString *)ucode money:(NSString *)money paytype:(NSInteger)paytype success:(success)success faile:(faile)faile {
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    [parmas setObject:ucode forKey:@"ucode"];
    [parmas setObject:money forKey:@"money"];
    [parmas setObject:[NSNumber numberWithInteger:paytype] forKey:@"paytype"];
    [self postWithMethod:@"/api.php/Withdraw/recharge" params:parmas sucess:success faile:faile];
}

//用户流水列表
- (void)userGetDrawListWithUcode:(NSString *)ucode page:(NSInteger)page pagesize:(NSInteger)pagesize success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:ucode forKey:@"ucode"];
    [params setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInteger:pagesize] forKey:@"pagesize"];
    [self postWithMethod:@"/api.php/Withdraw/paylist" params:params sucess:success faile:faile];
}

#pragma mark - Order
//寄件订单价格计算
- (void)countPriceWithHair_coordinate2D:(CLLocationCoordinate2D)hair_coordinate2D hair_city:(NSString *)hair_city take_coordinate2D:(CLLocationCoordinate2D)take_coordinate2D take_city:(NSString *)take_city weight:(NSInteger)weight price_pay:(NSInteger)parice_pay success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSString stringWithFormat:@"%.6f",hair_coordinate2D.longitude] forKey:@"hair_lng"];
    [params setObject:[NSString stringWithFormat:@"%.6f",hair_coordinate2D.latitude] forKey:@"hair_lat"];
    [params setObject:hair_city forKey:@"hair_city"];
    [params setObject:[NSString stringWithFormat:@"%.6f",take_coordinate2D.longitude] forKey:@"take_lng"];
    [params setObject:[NSString stringWithFormat:@"%.6f",take_coordinate2D.latitude] forKey:@"take_lat"];
    [params setObject:take_city forKey:@"take_city"];
    [params setObject:[NSNumber numberWithInteger:weight] forKey:@"weight"];
    [params setObject:[NSNumber numberWithInteger:parice_pay] forKey:@"price_pay"];
    [self postWithMethod:@"/api.php/DdorderOther/getjjddPrice" params:params sucess:success faile:faile];
}

//美食订单价格计算
- (void)countFoodOrderPriceWithShop_id:(NSInteger)shop_id take_coordinate2D:(CLLocationCoordinate2D)take_coordinte2D take_city:(NSString *)take_city goods:(NSString *)goods success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:shop_id] forKey:@"shop_id"];
    [params setObject:[NSString stringWithFormat:@"%.6f",take_coordinte2D.longitude] forKey:@"take_lng"];
    [params setObject:[NSString stringWithFormat:@"%.6f",take_coordinte2D.latitude] forKey:@"take_lat"];
    [params setObject:take_city forKey:@"take_city"];
    [params setObject:goods forKey:@"goods"];
    [self postWithMethod:@"/api.php/DdorderOther/gethzsjPrice" params:params sucess:success faile:faile];
}

//代购订单价格计算
- (void)countRelaceBuyOrderPriceWithHair_coordinate2D:(CLLocationCoordinate2D)hair_coordinate2D hair_city:(NSString *)hair_city take_coordinate2D:(CLLocationCoordinate2D)take_coordinate2D take_city:(NSString *)take_city success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSString stringWithFormat:@"%.6f",hair_coordinate2D.longitude] forKey:@"hair_lng"];
    [params setObject:[NSString stringWithFormat:@"%.6f",hair_coordinate2D.latitude] forKey:@"hair_lat"];
    [params setObject:hair_city forKey:@"hair_city"];
    [params setObject:[NSString stringWithFormat:@"%.6f",take_coordinate2D.longitude] forKey:@"take_lng"];
    [params setObject:[NSString stringWithFormat:@"%.6f",take_coordinate2D.latitude] forKey:@"take_lat"];
    [params setObject:take_city forKey:@"take_city"];
    [self postWithMethod:@"/api.php/DdorderOther/getzdgPrice" params:params sucess:success faile:faile];
}

//提交订单同意下单接口
- (void)commitOrderWithUcode:(NSString *)ucode model:(NSString *)model pay_type:(NSInteger)pay_type price_serve:(NSString *)price_serve price_weather:(NSString *)price_weather price_pay:(NSString *)price_pay distance:(NSInteger)distance goodtype_id:(NSInteger)goodtype_id goodtype_title:(NSString *)goodtype_title hair_coordinate2D:(CLLocationCoordinate2D)hair_coordinate2D hair_city:(NSString *)hari_city hari_name:(NSString *)hair_name hair_phone:(NSString *)hair_phone hair_address:(NSString *)hair_address take_coordinate2D:(CLLocationCoordinate2D)take_coordinate2D take_city:(NSString *)take_city take_name:(NSString *)take_name take_phone:(NSString *)take_phone take_address:(NSString *)take_address desc:(NSString *)desc mp3:(NSData *)mp3 shop_id:(NSInteger)shop_id goods:(NSString *)goods weight:(NSInteger)weight take_address_more:(NSString *)take_address_more hair_address_more:(NSString *)hair_address_more voucher_id:(NSInteger)voucher_id pick_up_time:(NSInteger)pick_up_time success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:ucode forKey:@"ucode"];
    [params setObject:model forKey:@"model"];
    [params setObject:[NSNumber numberWithInteger:pay_type] forKey:@"pay_type"];
    [params setObject:price_serve forKey:@"price_serve"];
    [params setObject:price_weather forKey:@"price_weather"];
    [params setObject:price_pay forKey:@"price_pay"];
    [params setObject:[NSNumber numberWithInteger:distance] forKey:@"distance"];
    if (goodtype_id != 0) {
        [params setObject:[NSNumber numberWithInteger:goodtype_id] forKey:@"goodtype_id"];
    }
    if (![Uinits isEmptyText:goodtype_title]) {
        [params setObject:goodtype_title forKey:@"goodtype_title"];
    }
    [params setObject:[NSString stringWithFormat:@"%.6f",hair_coordinate2D.longitude] forKey:@"hair_lng"];
    [params setObject:[NSString stringWithFormat:@"%.6f",hair_coordinate2D.latitude] forKey:@"hair_lat"];
    if (![Uinits isEmptyText:hari_city]) {
        [params setObject:hari_city forKey:@"hair_city"];
    }
    if (![Uinits isEmptyText:hair_name]) {
        [params setObject:hair_name forKey:@"hair_name"];
    }
    if (![Uinits isEmptyText:hair_phone]) {
        [params setObject:hair_phone forKey:@"hair_phone"];
    }
    if (![Uinits isEmptyText:hair_address]) {
        [params setObject:hair_address forKey:@"hair_address"];
    }
    [params setObject:[NSString stringWithFormat:@"%.6f",take_coordinate2D.longitude] forKey:@"take_lng"];
    [params setObject:[NSString stringWithFormat:@"%.6f",take_coordinate2D.latitude] forKey:@"take_lat"];
    [params setObject:take_city forKey:@"take_city"];
    [params setObject:take_name forKey:@"take_name"];
    [params setObject:take_phone forKey:@"take_phone"];
    [params setObject:take_address forKey:@"take_address"];
    if (![Uinits isEmptyText:desc]) {
        [params setObject:desc forKey:@"desc"];
    }
    if (mp3 != nil) {
        [params setObject:mp3 forKey:@"mp3"];
    }
    if (shop_id != 0) {
        [params setObject:[NSNumber numberWithInteger:shop_id] forKey:@"shop_id"];
    }
    if (![Uinits isEmptyText:goods]) {
        [params setObject:goods forKey:@"goods"];
    }
    if (weight != 0) {
        [params setObject:[NSNumber numberWithInteger:weight] forKey:@"weight"];
    }
    if (![Uinits isEmptyText:take_address_more]) {
        [params setObject:take_address_more forKey:@"take_address_more"];
    }
    if (![Uinits isEmptyText:hair_address_more]) {
        [params setObject:hair_address_more forKey:@"hair_address_more"];
    }
    if (voucher_id != 0) {
        [params setObject:[NSNumber numberWithInteger:voucher_id] forKey:@"voucher_id"];
    }
    if (pick_up_time != 0) {
        [params setObject:[NSNumber numberWithInteger:pick_up_time] forKey:@"pick_up_time"];
    } 
    [self postWithMethod:@"/api.php/Ddorder/sendOrder" params:params sucess:success faile:faile];
}

//我的订单列表
- (void)userGetOrderListWithUcode:(NSString *)ucode type:(NSInteger)type page:(NSInteger)page pagesize:(NSInteger)pagesize success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:ucode forKey:@"ucode"];
    [params setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    [params setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInteger:pagesize] forKey:@"pagesize"];
    [self postWithMethod:@"/api.php/Ddorder/orderList" params:params sucess:success faile:faile];
}

//订单状态描述
- (void)userGetOrderStateWithOrder_number:(NSString *)order_number success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:order_number forKey:@"order_number"];
    [self postWithMethod:@"/api.php/DdorderOther/orderStatus" params:params sucess:success faile:faile];
}

//用户确认支付订单
- (void)userConfirmPayWithUcode:(NSString *)ucode order_id:(NSInteger)order_id paytype:(NSInteger)paytype success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:ucode forKey:@"ucode"];
    [params setObject:[NSNumber numberWithInteger:order_id] forKey:@"order_id"];
    [params setObject:[NSNumber numberWithInteger:paytype] forKey:@"paytype"];
    [self postWithMethod:@"/api.php/Ddorder/payOrder" params:params sucess:success faile:faile];
}

//订单详细
- (void)orderDetailWithUcode:(NSString *)ucode order_id:(NSInteger)order_id success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:ucode forKey:@"ucode"];
    [params setObject:[NSNumber numberWithInteger:order_id] forKey:@"order_id"];
    [self postWithMethod:@"/api.php/Ddorder/orderView" params:params sucess:success faile:faile];
}

//取消订单
- (void)userCancelOrderWithUcode:(NSString *)ucode order_id:(NSInteger)order_id success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:ucode forKey:@"ucode"];
    [params setObject:[NSNumber numberWithInteger:order_id] forKey:@"order_id"];
    [self postWithMethod:@"/api.php/Ddorder/cancelOrder" params:params sucess:success faile:faile];
}

#pragma mark - Other
//意见反馈
- (void)userFeedBackWithUcode:(NSString *)ucode content:(NSString *)content success:(success)success faile:(faile)faile {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:ucode forKey:@"ucode"];
    [params setObject:content forKey:@"content"];
    [self postWithMethod:@"/api.php/Other/addfeedback" params:params sucess:success faile:faile];
}

@end
