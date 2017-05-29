//
//  CCClient+Requests.m
//  DoctorFixBao
//
//  Created by Kiwi on 11/11/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

#import "CCClient+Requests.h"

@implementation CCClient (Requests)

#pragma mark -
#pragma mark - Account

-(void)getTheProduct {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [self postWithMethodName:@"goodscate/lists" params:params];
}

/**
 * 产品描述,产品详情页
 */
- (void)productDescription:(NSInteger)goods_id{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:goods_id] forKey:@"goods_id"];
    [self postWithMethodName:@"goodsinfo/description" params:params];
}

/**
 * 取ad_id ,首页某个广告详情(不调)
 */
- (void)mainPageadlists:(NSInteger)ad_id{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:ad_id] forKey:@"ad_id"];
    [self postWithMethodName:@"adlists/info" params:params];
}

/**
 *type_id = 1 首页头部广告位
 */
- (void)bannerAdvertising:(NSInteger)type_id{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:@"1" forKey:@"type_id"];
    [self postWithMethodName:@"adlists/lists" params:params];
}

/**
 *type_id = 2 首页中部广告位
 */
- (void)advertisementsCentral:(NSInteger)type_id{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:@"2" forKey:@"type_id"];
    [self postWithMethodName:@"adlists/lists" params:params];
}

/**
 *type_id = 3 首页尾部广告位
 */
- (void)advertisementsTail:(NSInteger)type_id{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:@"3" forKey:@"type_id"];
    [self postWithMethodName:@"adlists/lists" params:params];
}

/**
 * ad_id获取广告下的产品
 */
- (void)mainPageDeals:(NSInteger)ad_id{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:ad_id] forKey:@"ad_id"];
    [self postWithMethodName:@"adgoods/lists" params:params];
}

/**
 * 产品评价数量
 */
- (void)productEvaluationCount:(NSInteger)goods_id levelValueCount:(NSInteger)levelValueCount{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:goods_id] forKey:@"goods_id"];
    [params setObject:[NSNumber numberWithInteger:levelValueCount] forKey:@"level"];
    [self postWithMethodName:@"goodsevaluation/contents_number" params:params];
}
/**
 *产品评价列表
 */
- (void)productEvaluationList:(NSInteger)goods_id level:(NSInteger)level pageing:(NSInteger)paging{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:goods_id] forKey:@"goods_id"];
    [params setObject:[NSNumber numberWithInteger:level] forKey:@"level"];
    [params setObject:[NSNumber numberWithInteger:paging] forKey:@"page"];
    [self postWithMethodName:@"goodsevaluation/lists" params:params];
}

/**
 *产品详情
 */
- (void)goodsInfo:(NSInteger)goods_id{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:goods_id] forKey:@"goods_id"];
    [self postWithMethodName:@"goodsinfo/info" params:params];
}

/**
 *产品列表
 */
- (void)productList:(NSInteger)cate_id searchselect:(NSString *)select page:(NSInteger)page{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:cate_id] forKey:@"cate_id"];
    [params setObject:select forKey:@"select"];
    [params setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    [self postWithMethodName:@"goodslists/lists" params:params];
}
//价格排序
- (void)productList:(NSInteger)sort_price cate_id:(NSInteger)cate_id page:(NSInteger)page{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:sort_price] forKey:@"sort_price"];
    [params setObject:[NSNumber numberWithInteger:cate_id] forKey:@"cate_id"];
    [params setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    [self postWithMethodName:@"goodslists/lists" params:params];
}
//销量排序
- (void)productListsales:(NSInteger)sort_sales cate_id:(NSInteger)cate_id page:(NSInteger)page{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:sort_sales] forKey:@"sort_sales"];
    [params setObject:[NSNumber numberWithInteger:cate_id] forKey:@"cate_id"];
    [params setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    [self postWithMethodName:@"goodslists/lists" params:params];
}
//搜索
- (void)productListselect:(NSString *)sort_select page:(NSInteger)page{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:sort_select forKey:@"select"];
    [params setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    [self postWithMethodName:@"goodslists/lists" params:params];
}
//搜索结果价格排序
- (void)productListselect:(NSString *)select price:(NSInteger)sort_price page:(NSInteger)page{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:select forKey:@"select"];
    [params setObject:[NSNumber numberWithInteger:sort_price] forKey:@"sort_price"];
    [params setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    [self postWithMethodName:@"goodslists/lists" params:params];
}
//搜索结果销量排序
- (void)productListselect:(NSString *)select sales:(NSInteger)sort_sales page:(NSInteger)page{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:select forKey:@"select"];
    [params setObject:[NSNumber numberWithInteger:sort_sales] forKey:@"sort_sales"];
    [params setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    [self postWithMethodName:@"goodslists/lists" params:params];
}
/**
 *  分类列表
 */
- (void)classificationList:(NSInteger)cate_id{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:cate_id] forKey:@"cart_id"];
    [self postWithMethodName:@"goodscate/lists" params:params];
}
- (void)classificationListDif:(NSInteger)cate_id{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:cate_id] forKey:@"cate_id"];
    [self postWithMethodName:@"goodscate/lists" params:params];
}

/**
 *  关于我们
 */
- (void)aboutUs:(NSString *)content{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [self postWithMethodName:@"Commonarticle/about_us" params:params];
}
/**
 *  服务协议
 */
- (void)theServiceAgreement:(NSString *)content{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [self postWithMethodName:@"Commonarticle/regist_protocol" params:params];
}

/**
 *  注册协议
 */
- (void)theRegisterAgreement{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [self postWithMethodName:@"Commonarticle/regist_protocol" params:params];
}

/**
 *  修改密码
 */
-(void)changePassWordWithPhone:(NSString *)phone code:(NSString *)code passWord:(NSString *)passWord {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:phone forKey:@"phone"];
    [params setObject:code forKey:@"code"];
    [params setObject:passWord forKey:@"password"];
    [self postWithMethodName:@"useredit/find_password" params:params];
}

/**
 *忘记密码获取验证码
 */
- (void)clickGetCodePhone:(NSString *)phone{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:phone forKey:@"phone"];
    [self postWithMethodName:@"useredit/password_code" params:params];
}

/**
 *注册
 *获取注册验证码
 */
- (void)getRegisterVerifyCodeWithPhone:(NSString *)phone{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:phone forKey:@"phone"];
    [self postWithMethodName:@"regist/code" params:params];
}

//验证手机号是否注册
-(void)checkPhoneNumRegistOrNotWithPhome:(NSString *)phone {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:phone forKey:@"phone"];
    [self postWithMethodName:@"regist/check_phone" params:params];
}

//验证手机验证码
- (void)getCode:(NSString *)code phone:(NSString *)phone{
    _needLogin = NO;
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:code forKey:@"code"];
    [params setObject:phone forKey:@"phone"];
    [self postWithMethodName:@"regist/check_code" params:params];
}

/**
 *验证手机号是否注册
 */
-(void)registAcountWithPhone:(NSString *)phonenum passWord:(NSString *)passWord {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:phonenum forKey:@"phone"];
    [params setObject:passWord forKey:@"password"];
    [self postWithMethodName:@"regist/regist" params:params];
}

/*
 *忘记密码
 *重置密码
 */
-(void)findPsdWithPhone:(NSString *)phone code:(NSString *)code newPsd:(NSString *)newPsd {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:phone forKey:@"phone"];
    [params setObject:code forKey:@"code"];
    [params setObject:newPsd forKey:@"password"];
    [self postWithMethodName:@"useredit/find_password" params:params];
}

/*
 **获取完成订单数
 */
-(void)getTheNumOfOverOrder {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [self postWithMethodName:@"orderlists/over_number" params:params];
}

/**
 * 获取个人基本信息
 */
-(void)getUserBaseInfo {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //    [params setObject:ucode forKey:@"ucode"];
    [self postWithMethodName:@"userinfo/my" params:params];
}

/*
 ***保存修改个人资料
 */
-(void)saveOrChangeInfoWithUcode:(NSString *)ucode headImg:(NSString *)headImg nickName:(NSString *)nickName sex:(int)sex birthdate:(int)birthdate phone:(NSString *)phone {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //    [params setObject:ucode forKey:@"ucode"];
    [params setObject:headImg forKey:@"head_img"];
    [params setObject:nickName forKey:@"nack_name"];
    if (sex != 0) {
        [params setObject:[NSNumber numberWithInt:sex] forKey:@"sex"];
    }
    if (birthdate != 0) {
        [params setObject:[NSNumber numberWithDouble:birthdate] forKey:@"birthday"];
    }
    if (phone.hasValue) {
        [params setObject:phone forKey:@"tel"];
    }
    [self postWithMethodName:@"useredit/edit_info" params:params];
}

/*
 ***获取用户收藏列表
 */
-(void)getListOfCollectGoods {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:[NSNumber numberWithInt:1] forKey:@"page"];
//    [params setObject:[NSNumber numberWithInt:20] forKey:@"pagesize"];
    [self postWithMethodName:@"collectgoods/lists" params:params];
}

/**
 * 添加用户收藏
 * params goodsID
 */
-(void)addCollectGoodsWithGoodsId:(int)goodsId {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:goodsId] forKey:@"goods_id"];
    [self postWithMethodName:@"collectgoods/collect" params:params];
}
/**
 *检查产品是否收藏
 */
- (void)collectionGoods:(int)goodsId{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:goodsId] forKeyedSubscript:@"goods_id"];
    [self postWithMethodName:@"collectgoods/is_collect" params:params];
}
/**
 * 取消用户收藏
 */
-(void)cancelCollectGoodsWithGoodsId:(int)goodsId {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:goodsId] forKey:@"goods_id"];
    [self postWithMethodName:@"collectgoods/cancel" params:params];
}

/*
 ***获取用户地址裂变
 */
-(void)getListOfUserAddress {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //    [params setObject:ucode forKey:@"ucode"];
    [self postWithMethodName:@"useraddress/lists" params:params];
}


/*
 ***获取用户购物车列表
 */
-(void)getListOfUserCart {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [self postWithMethodName:@"shopcartlists/lists" params:params];
}

/**
 * 获取运费信息
 */
-(void)getInformationOfShippingfee {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [self postWithMethodName:@"shippingfee/fee" params:params];
}

/**
 * 用户获取购物车数量
 */
-(void)userGetCartNum {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [self postWithMethodName:@"shopcartlists/cart_number" params:params];
}
/**
 * 修改购物车数量
 */
-(void)editTheQuantityOfCartWithQuantity:(int)quantity cartId:(NSString *)cartId {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:cartId forKey:@"cart_id"];
    [params setObject:[NSNumber numberWithInt:quantity] forKey:@"quantity"];
    [self postWithMethodName:@"" params:params];
}

/**
 * 删除购物车
 */
-(void)cancelShopcartWithCartId:(NSString *)cartId {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:cartId forKeyedSubscript:@"cart_id"];
    [self postWithMethodName:@"shopcartcancel/delete_selected" params:params];
}

/*
 ***添加收货地址
 */
-(void)addAddressWithUcode:(NSString *)ucode userName:(NSString *)userName tel:(NSString *)tel area:(NSString *)area address:(NSString *)address {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:ucode forKey:@"ucode"];
    [params setObject:userName forKey:@"link_uname"];
    [params setObject:tel forKey:@"tel"];
    [params setObject:area forKey:@"extend1"];
    [params setObject:address forKey:@"address"];
    [self postWithMethodName:@"useraddress/add" params:params];
}

/**
 * 获取小区列表
 */
-(void)getTheListWithArea:(NSString *)area {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:area forKey:@"area"];
    [self postWithMethodName:@"area/lists" params:params];
}

/**
 * 删除收货地址
 */
-(void)cancelAddressWithAddId:(int)addId {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:addId] forKey:@"addr_id"];
    [self postWithMethodName:@"useraddress/cancel" params:params];
}

/**
 * 编辑收货地址
 */
-(void)editAddressWithAddrId:(int)addId area:(NSString *)area linkName:(NSString *)linkName tel:(NSString *)tel adress:(NSString *)adress {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:addId] forKey:@"addr_id"];
    [params setObject:area forKey:@"extend1"];
    [params setObject:linkName forKey:@"link_uname"];
    [params setObject:tel forKey:@"tel"];
    [params setObject:adress forKey:@"adress"];
    [self postWithMethodName:@"useraddress/edit" params:params];
}


/**
 * 添加默认地址
 */
-(void)setDefaultsAddressWithAddrId:(int)addrId {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:addrId] forKey:@"addr_id"];
    [self postWithMethodName:@"useraddress/set_default" params:params];
}

/**
 * 取消默认地址
 */
-(void)cancelDefaultsAddressWithAddrId:(int)addrId {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:addrId] forKey:@"addr_id"];
    [self postWithMethodName:@"useraddress/cancel_default" params:params];
}

/**
 * 获取默认地址详情
 */
-(void)getDefaultsDetail {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [self postWithMethodName:@"useraddress/default_info" params:params];
}

/*
 *登陆
 */
- (void)loginWithAccount:(NSString*)account password:(NSString*)password {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:account forKey:@"phone"];
    [params setObject:password forKey:@"password"];
    [self postWithMethodName:@"login/login" params:params];
}

/**
 * 用户添加购物车
 * params
 * ucode 用户校验码
 * goodsId 产品id
 * sperId 规格id
 * spercification 规格
 * shopId 商店id
 * goodsName 产品名
 * goodsImg 产品图片
 * quantity 数量
 */
-(void)userAddShopcartWithGoodsId:(int)goodsId sperId:(int)sperId shopId:(int)shopId goodsName:(NSString *)goodsName goodsImg:(NSString *)goodsImg quantity:(int)quantity {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setValue:ucode forKey:@"ucode"];
    [params setValue:[NSNumber numberWithInteger:goodsId] forKey:@"goods_id"];
    [params setValue:[NSNumber numberWithInteger:sperId] forKey:@"spec_id"];
    [params setValue:[NSNumber numberWithInteger:shopId] forKey:@"shop_id"];
    [params setValue:goodsName forKey:@"goods_name"];
    [params setValue:goodsImg forKey:@"goods_image"];
    [params setValue:[NSNumber numberWithInteger:quantity] forKey:@"quantity"];
    [self postWithMethodName:@"shopcartadd/add" params:params];
}

//-(void)registAcountWithPhone:(NSString *)phonenum passWord:(NSString *)passWord {
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:phonenum forKey:@"phone"];
//    [params setObject:passWord forKey:@"password"];
//    [self postWithMethodName:@"regist/regist" params:params];
//}

/**
 * 获取商家运营时间
 */
-(void)getTheTimeOfShopOpen {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [self postWithMethodName:@"shop/in_time" params:params];
}

/**
 * 获取用户所有订单列表
 */
-(void)getUserAllOrderListWithPage:(int)page {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
//    [params setObject:[NSNumber numberWithInt:30] forKey:@"pagesize"];
    [self postWithMethodName:@"orderlists/all" params:params];
}

/**
 * 获取用户未支付订单列表
 */
-(void)getUserNoPayOrderListWithPage:(int)page {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
//    [params setObject:[NSNumber numberWithInt:30] forKey:@"pagesize"];
    [self postWithMethodName:@"orderlists/no_pay" params:params];
}

/**
 * 获取用户为收货订单列表
 */
-(void)getUserNoGetOrderListWithPage:(int)page {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
//    [params setObject:[NSNumber numberWithInt:30] forKey:@"pagesize"];
    [self postWithMethodName:@"orderlists/no_get" params:params];
}

/**
 * 获取用户未评价订单列表
 */
-(void)getUserNoContentOrderListWithPage:(int)page {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
//    [params setObject:[NSNumber numberWithInt:30] forKey:@"pagesize"];
    [self postWithMethodName:@"orderlists/no_contents" params:params];
}

/**
 * 获取用户完成订单列表
 */
-(void)getUserIsOverOrderListWithPage:(int)page {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
//    [params setObject:[NSNumber numberWithInt:30] forKey:@"pagesize"];
    [self postWithMethodName:@"orderlists/is_over" params:params];
}

/**
 * 获取用户申请退款订单列表
 */
-(void)getUserrefundOrderListWithPage:(int)page{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
//    [params setObject:[NSNumber numberWithInt:30] forKey:@"pagesize"];
    [self postWithMethodName:@"orderlists/apply_ing" params:params];
}

/**
 * 添加订单
 * params
 * 购物车id
 * 支付方式
 * 配送方式
 * 对商家的备注
 * 联系人
 * 电话
 * 地址
 */
-(void)addOrderWithcartId:(NSString *)cartId payWay:(int)payWay deliverType:(int)deliverType mack:(NSString *)mack linkName:(NSString *)linkName tel:(NSString *)tel address:(NSString *)address area:(NSString *)area bestStartTime:(NSInteger)bestStartTime bestEndTime:(NSInteger)bestEndTime{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:cartId forKey:@"cart_id"];
    [params setObject:[NSNumber numberWithInt:payWay] forKey:@"pay_way"];
    [params setObject:[NSNumber numberWithInt:deliverType] forKey:@"delivery_type"];
    if (mack.hasValue) {
        [params setObject:mack forKey:@"mark"];
    } if (linkName.hasValue) {
        [params setObject:linkName forKey:@"link_name"];
    } if (tel.hasValue) {
        [params setObject:tel forKey:@"tel"];
    } if (address.hasValue) {
        [params setObject:address forKey:@"address"];
    } if (area.hasValue) {
        [params setObject:area forKey:@"area"];
    }
    if (bestStartTime != 0) {
        [params setObject:[NSNumber numberWithInteger:bestStartTime] forKey:@"best_start_time"];
    }
    if (bestEndTime != 0) {
        [params setObject:[NSNumber numberWithInteger:bestEndTime] forKey:@"best_end_time"];
    }
    [self postWithMethodName:@"orderadd/add" params:params];
}

/**
 * 获取订单详情
 */
-(void)getOrderDetailsWithOrderId:(int)orderId {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:orderId] forKey:@"order_id"];
    [self postWithMethodName:@"orderinfo/info" params:params];
}

/**
 * 获取购买订单数
 */
-(void)getOverOrderListNum {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [self postWithMethodName:@"orderlists/over_number" params:params];
}

/**
 * 取消订单
 */
-(void)cancelOrderWithOrderId:(int)orderId {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:orderId] forKey:@"order_id"];
    [self postWithMethodName:@"orderstatus/order_cancel" params:params];
}

/**
 * 删除订单
 */
-(void)deleteOrderWithOrderId:(int)orderId {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:orderId] forKey:@"order_id"];
    [self postWithMethodName:@"orderstatus/hide" params:params];
}

/**
 * 确认收货
 */
-(void)takeOverGoodsWithOrderId:(int)orderId {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:orderId] forKey:@"order_id"];
    [self postWithMethodName:@"ordersure/sure" params:params];
}

/**
 * 申请退款
 */
-(void)refundOrderWithOrderId:(int)orderId content:(NSString *)content {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:orderId] forKey:@"order_id"];
    if (content.hasValue) {
        [params setObject:content forKeyedSubscript:@"content"];
    }
    [self postWithMethodName:@"orderapply/applying" params:params];
}

/**
 * 取消申请退款
 */
-(void)cancelRefundOrderWithOrderId:(int)orderId {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:orderId] forKey:@"order_id"];
    [self postWithMethodName:@"orderapply/cancel_apply" params:params];
}

/**
 * 再次购买
 */
-(void)orderOfBuyAgainWithOrderId:(int)orderId {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:orderId] forKey:@"order_id"];
    [self postWithMethodName:@"orderadd/buy_again" params:params];
}

/**
 * 获取信息列表
 */
-(void)getListOfMessage {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:[NSNumber numberWithInt:1] forKey:@"shop_id"];
    [self postWithMethodName:@"leavemsg/msg" params:params];
}

/**
 * 发送信息
 * params
 * shopId 商家id
 * shopName 商家名称
 * shoplogo 商家logo
 * content 内容
 * title 标题
 */
-(void)postMessegeWithShopId:(int)shopId shopName:(NSString *)shopName shopLogo:(NSString *)shopLogo content:(NSString *)content title:(NSString *)title {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:shopId] forKey:@"shop_id"];
    //    [params setObject:shopName forKey:@"shop_name"];
    //    [params setObject:shopLogo forKey:@"Shop_logo"];
    [params setObject:content forKey:@"content"];
    //    [params setObject:title forKey:@"title"];
    [self postWithMethodName:@"leavemsg/send_msg" params:params];
}

/**
 * 评价商品
 */
-(void)addGoodsEvalWithOrderId:(int)orderId goodsId:(NSString *)goodsId specId:(NSString *)specId level:(NSString *)level content:(NSString *)content {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:orderId] forKey:@"order_id"];
    [params setObject:goodsId forKey:@"goods_id"];
    [params setObject:specId forKey:@"spec_id"];
    [params setObject:level forKey:@"level"];
    if (content.hasValue) {
        [params setObject:content forKey:@"content"];
    }
    [self postWithMethodName:@"goodsevaluationadd/add" params:params];
}

/**
 * 支付
 */
-(void)payOrderWithOrderNum:(NSString *)orderNum {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:orderNum forKey:@"order_number"];
    [self postWithMethodName:@"payalipay/do_encrypt" params:params];
}

/**
 * 订单失效时间
 */
-(void)getTheTimeOfLoseTime {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [self postWithMethodName:@"order/lose_time" params:params];
}

- (void)getUserInfo {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [self postWithMethodName:@"userInfo/my"
                      params:params];
}

- (void)sendVerifyCodeWithPhone:(NSString*)phone type:(NSInteger)type {
    _needLogin = NO;
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:phone forKey:@"phone"];
    [params setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    [self getWithMethodName:@"/other/getCode"
                     params:params];
}
- (void)checkVerifyCodeWithPhone:(NSString*)phone code:(NSString*)code {
    _needLogin = NO;
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:phone forKey:@"phone"];
    [params setObject:code forKey:@"code"];
    [self getWithMethodName:@"/other/checkCode"
                     params:params];
}
- (void)registerWithAccount:(NSString*)account password:(NSString*)password userName:(NSString*)userName inviteCode:(NSString*)inviteCode {
    _needLogin = NO;
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:account forKey:@"phone"];
    [params setObject:password forKey:@"password"];
    [params setObject:userName forKey:@"username"];
    if (inviteCode.hasValue) [params setObject:inviteCode forKey:@"invitecode"];
    [self getWithMethodName:@"/user/regist"
                     params:params];
}
- (void)resetPasswordWithPhone:(NSString*)phone password:(NSString*)password {
    _needLogin = NO;
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:phone forKey:@"phone"];
    [params setObject:password forKey:@"password"];
    [self getWithMethodName:@"/other/resetPasswod"
                     params:params];
}
- (void)editPassword:(NSString*)oldpass newPassword:(NSString*)newpass {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:oldpass forKey:@"oldpassword"];
    [params setObject:newpass forKey:@"newpassword"];
    [self postWithMethodName:@"/user/editPassword"
                      params:params];
}
- (void)editPhone:(NSString*)oldPhone newPhone:(NSString*)newPhone verifyCode:(NSString*)verifyCode password:(NSString*)password {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:oldPhone forKey:@"oldphone"];
    [params setObject:newPhone forKey:@"phone"];
    [params setObject:verifyCode forKey:@"code"];
    [params setObject:password forKey:@"password"];
    [self postWithMethodName:@"/user/editPhone"
                      params:params];
}
- (void)editUserName:(NSString*)username name:(NSString*)name email:(NSString*)email headImage:(UIImage*)headImage {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    if (username.hasValue) [params setObject:username forKey:@"username"];
    if (name.hasValue) [params setObject:name forKey:@"name"];
    if (email.hasValue) [params setObject:email forKey:@"email"];
    if (headImage) [params setObject:headImage forKey:@"head"];
    [self postWithMethodName:@"/user/editUser"
                      params:params];
}
- (void)getUserDetail {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [self getWithMethodName:@"/user/detail"
                     params:params];
}
- (void)applyIndividualVerificationWithName:(NSString*)name gender:(NSString*)gender phone:(NSString*)phone paperType:(NSString*)paperType paperNo:(NSString*)paperNo email:(NSString*)email organization:(NSString*)organization work:(NSString*)work cardFront:(UIImage*)cardFront cardBack:(UIImage*)cardBack cardInHand:(UIImage*)cardInHand {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:@"1" forKey:@"type"];
    if (name.hasValue) [params setObject:name forKey:@"name"];
    if (gender.hasValue) [params setObject:gender forKey:@"gender"];
    if (phone.hasValue) [params setObject:phone forKey:@"phone"];
    if (paperType.hasValue) [params setObject:paperType forKey:@"paperwork"];
    if (paperNo.hasValue) [params setObject:paperNo forKey:@"paperworknumber"];
    if (email.hasValue) [params setObject:email forKey:@"email"];
    if (organization.hasValue) [params setObject:organization forKey:@"firm"];
    if (work.hasValue) [params setObject:work forKey:@"description"];
    if (cardFront) [params setObject:cardFront forKey:@"paperfront"];
    if (cardBack) [params setObject:cardBack forKey:@"paperback"];
    if (cardInHand) [params setObject:cardInHand forKey:@"handheldpaperwork"];
    [self postWithMethodName:@"/user/auth"
                      params:params];
}
- (void)applyEnterpriseVerificationWithName:(NSString*)name gender:(NSString*)gender phone:(NSString*)phone paperType:(NSString*)paperType paperNo:(NSString*)paperNo email:(NSString*)email cardFront:(UIImage*)cardFront cardBack:(UIImage*)cardBack cardInHand:(UIImage*)cardInHand organization:(NSString*)organization memberSize:(NSString*)memberSize address:(NSString*)address work:(NSString*)work nameRM:(NSString*)nameRM cardNoRM:(NSString*)cardNoRM cardFrontRM:(UIImage*)cardFrontRM cardBackRM:(UIImage*)cardBackRM orgPaperType:(NSString*)orgPaperType orgPaperNo:(NSString*)orgPaperNo orgPaperImage:(UIImage*)orgPaperImage orgPaperType:(NSString*)orgPaperType2 orgPaperNo:(NSString*)orgPaperNo2 orgPaperImage:(UIImage*)orgPaperImage2 orgPaperType:(NSString*)orgPaperType3 orgPaperNo:(NSString*)orgPaperNo3 orgPaperImage:(UIImage*)orgPaperImage3 {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:@"2" forKey:@"type"];
    if (name.hasValue) [params setObject:name forKey:@"name"];
    if (gender.hasValue) [params setObject:gender forKey:@"gender"];
    if (phone.hasValue) [params setObject:phone forKey:@"phone"];
    if (paperType.hasValue) [params setObject:paperType forKey:@"paperwork"];
    if (paperNo.hasValue) [params setObject:paperNo forKey:@"paperworknumber"];
    if (email.hasValue) [params setObject:email forKey:@"email"];
    if (cardFront) [params setObject:cardFront forKey:@"paperfront"];
    if (cardBack) [params setObject:cardBack forKey:@"paperback"];
    if (cardInHand) [params setObject:cardInHand forKey:@"handheldpaperwork"];
    // ----- For Enterprise
    if (organization.hasValue) [params setObject:organization forKey:@"firm"];
    if (memberSize.hasValue) [params setObject:memberSize forKey:@"companysize"];
    if (address.hasValue) [params setObject:address forKey:@"address"];
    if (work.hasValue) [params setObject:work forKey:@"description"];
    if (nameRM.hasValue) [params setObject:nameRM forKey:@"legalname"];
    if (cardNoRM.hasValue) [params setObject:cardNoRM forKey:@"idcard"];
    if (cardFrontRM) [params setObject:cardFrontRM forKey:@"idcardfront"];
    if (cardBackRM) [params setObject:cardBackRM forKey:@"idcardback"];
    if (orgPaperType.hasValue && orgPaperNo.hasValue && orgPaperImage) {
        [params setObject:orgPaperType forKey:@"firmpaperworktype1"];
        [params setObject:orgPaperNo forKey:@"firmpaperworknumber1"];
        [params setObject:orgPaperImage forKey:@"firmpaper1"];
    }
    if (orgPaperType2.hasValue && orgPaperNo2.hasValue && orgPaperImage2) {
        [params setObject:orgPaperType2 forKey:@"firmpaperworktype2"];
        [params setObject:orgPaperNo2 forKey:@"firmpaperworknumber2"];
        [params setObject:orgPaperImage2 forKey:@"firmpaper2"];
    }
    if (orgPaperType3.hasValue && orgPaperNo3.hasValue && orgPaperImage3) {
        [params setObject:orgPaperType3 forKey:@"firmpaperworktype3"];
        [params setObject:orgPaperNo3 forKey:@"firmpaperworknumber3"];
        [params setObject:orgPaperImage3 forKey:@"firmpaper3"];
    }
    [self postWithMethodName:@"/user/auth"
                      params:params];
}
- (void)getVerificationStatus {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [self postWithMethodName:@"/user/authdetail"
                      params:params];
}
- (void)feedbackWithContent:(NSString*)content image:(UIImage*)image {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:@"医修哥" forKey:@"from"];
    [params setObject:content forKey:@"content"];
    if (image) [params setObject:image forKey:@"picture"];
    [self postWithMethodName:@"/user/feedback"
                      params:params];
}

#pragma mark -
#pragma mark - Notifications
- (void)setupAPNS:(NSString*)deviceID {
    _workWithNoRespond = NO;
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:deviceID forKey:@"udid"];
    [params setObject:@"1" forKey:@"app"];
    [self postWithMethodName:@"/user/addNotice" params:params];
}
- (void)removeAPNS {
    _workWithNoRespond = NO;
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:@"1" forKey:@"app"];
    [self postWithMethodName:@"/user/removeNotice" params:params];
}
- (void)getNotificationsWithType:(NSInteger)type maxID:(NSInteger)maxID count:(NSInteger)count {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    [params setObject:@"1" forKey:@"app"];
    if (maxID > 0) [params setObject:[NSNumber numberWithInteger:maxID] forKey:@"maxid"];
    if (count > 0) [params setObject:[NSNumber numberWithInteger:count] forKey:@"pageSize"];
    [self postWithMethodName:@"/user/msglist" params:params];
}
- (void)getUserUnreadCount {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:@"1" forKey:@"app"];
    [self postWithMethodName:@"/user/msgCount" params:params];
}
- (void)markAsHandledWithID:(NSInteger)msgID {
    _workWithNoRespond = YES;
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:msgID] forKey:@"messageid"];
    [self postWithMethodName:@"/user/handle" params:params];
}

#pragma mark -
#pragma mark - Funding
- (void)getFunding {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [self postWithMethodName:@"/employee/funding"
                      params:params];
}
- (void)getStatisticsWithDateStart:(NSTimeInterval)start end:(NSTimeInterval)end {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSString stringWithFormat:@"%.0f", start] forKey:@"start"];
    [params setObject:[NSString stringWithFormat:@"%.0f", end] forKey:@"end"];
    [self postWithMethodName:@"/employee/statistics"
                      params:params];
}
- (void)getUngainOrders {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:@"0" forKey:@"type"];
    [self postWithMethodName:@"/workorder/bill"
                      params:params];
}
- (void)getGainOrders {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:@"1" forKey:@"type"];
    [self postWithMethodName:@"/workorder/bill"
                      params:params];
}

#pragma mark -
#pragma mark - Credits
- (void)getUserCreditsWithName:(NSString*)name phone:(NSString*)phone enterprice:(NSString*)enterprice {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    if (enterprice.hasValue) [params setObject:@"2" forKey:@"type"];
    else if (name.hasValue) [params setObject:@"1" forKey:@"type"];
    else [params setObject:@"0" forKey:@"type"];
    if (name.hasValue) [params setObject:name forKey:@"name"];
    if (phone.hasValue) [params setObject:phone forKey:@"phone"];
    if (enterprice.hasValue) [params setObject:enterprice forKey:@"firm"];
    [self postWithMethodName:@"/user/credit"
                      params:params];
}

#pragma mark -
#pragma mark - Wealth
- (void)getUnpaidOrdersWithType:(NSInteger)type {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:@"0" forKey:@"type"];
    if (type == 0) [params setObject:@"spareparts" forKey:@"action"];
    else [params setObject:@"Repair" forKey:@"action"];
    [self postWithMethodName:@"/user/payingList"
                      params:params];
}
- (void)getUndoneOrdersWithType:(NSInteger)type {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:@"0" forKey:@"type"];
    if (type == 0) [params setObject:@"spareparts" forKey:@"action"];
    else [params setObject:@"Repair" forKey:@"action"];
    [self postWithMethodName:@"/user/receivableList"
                      params:params];
}
- (void)getPaidOrdersWithType:(NSInteger)type {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:@"1" forKey:@"type"];
    if (type == 0) [params setObject:@"spareparts" forKey:@"action"];
    else [params setObject:@"Repair" forKey:@"action"];
    [self postWithMethodName:@"/user/payingList"
                      params:params];
}
- (void)getDoneOrdersWithType:(NSInteger)type {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:@"1" forKey:@"type"];
    if (type == 0) [params setObject:@"spareparts" forKey:@"action"];
    else [params setObject:@"Repair" forKey:@"action"];
    [self postWithMethodName:@"/user/receivableList"
                      params:params];
}
- (void)payOrderWithType:(NSInteger)type payment:(NSInteger)payment orderID:(NSInteger)orderID {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    if (type == 0) [params setObject:@"spareparts" forKey:@"action"];
    else [params setObject:@"Repair" forKey:@"action"];
    [params setObject:[NSNumber numberWithInteger:payment] forKey:@"type"];
    [params setObject:[NSNumber numberWithInteger:orderID] forKey:@"id"];
    [self postWithMethodName:@"/user/paying"
                      params:params];
}
- (void)doneOrderWithType:(NSInteger)type orderID:(NSInteger)orderID {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    if (type == 0) [params setObject:@"spareparts" forKey:@"action"];
    else [params setObject:@"Repair" forKey:@"action"];
    [params setObject:[NSNumber numberWithInteger:orderID] forKey:@"id"];
    [self postWithMethodName:@"/user/receivable"
                      params:params];
}

#pragma mark -
#pragma mark - Employee
- (void)getUserWithPhone:(NSString*)phone {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:phone forKey:@"phone"];
    [self postWithMethodName:@"/employee/search"
                      params:params];
}
- (void)getEmployeeRoles {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [self postWithMethodName:@"/employee/roleList"
                      params:params];
}
- (void)getMyEmployees {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [self postWithMethodName:@"/employee/firmUserList"
                      params:params];
}
- (void)deleteEmployeeWithID:(NSInteger)userID {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:userID] forKey:@"employeeid"];
    [self postWithMethodName:@"/employee/deleteEmployee"
                      params:params];
}
- (void)inviteEmployeeWithPhone:(NSString*)phone roleID:(NSInteger)roleID {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:phone forKey:@"phone"];
    [params setObject:[NSNumber numberWithInteger:roleID] forKey:@"roleid"];
    [self postWithMethodName:@"/employee/invite"
                      params:params];
}
- (void)agreeEmployeeWithFirmID:(NSInteger)fid roleID:(NSInteger)roleID {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:fid] forKey:@"firmid"];
    [params setObject:[NSNumber numberWithInteger:roleID] forKey:@"roleid"];
    [self postWithMethodName:@"/employee/agree"
                      params:params];
}
- (void)refuseEmployeeWithFirmID:(NSInteger)fid {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:fid] forKey:@"firmid"];
    [self postWithMethodName:@"/employee/disagree"
                      params:params];
}

#pragma mark -
#pragma mark - WorkOrder
- (void)getWorkOrdersWithStatus:(NSInteger)status page:(NSInteger)page count:(NSInteger)count {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
    if (page > 0) [params setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    if (count > 0) [params setObject:[NSNumber numberWithInteger:count] forKey:@"pageSize"];
    [self postWithMethodName:@"/workorder/lists"
                      params:params];
}
- (void)getWorkOrdersWithID:(NSInteger)orderID {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:orderID] forKey:@"id"];
    [self postWithMethodName:@"/workorder/detail"
                      params:params];
}
- (void)addWorkOrderID {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [self postWithMethodName:@"/workorder/workOrderNo"
                      params:params];
}
- (void)addWorkOrderWithID:(NSInteger)orderID from:(NSString*)from money:(double)money hospital:(NSString*)hospital hospitalAddress:(NSString*)hospitalAddress name:(NSString*)name phone:(NSString*)phone address:(NSString*)address manufacturer:(NSString*)manufacturer model:(NSString*)model sn:(NSString*)sn equipment:(NSString*)equipment equipmentModel:(NSString*)equipmentModel equipmentSN:(NSString*)equipmentSN content:(NSString*)content history:(NSString*)history remark:(NSString*)remark {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:orderID] forKey:@"id"];
    [params setObject:from forKey:@"from"];
    [params setObject:[NSString stringWithFormat:@"%.2f", money] forKey:@"money"];
    [params setObject:hospital forKey:@"firmname"];
    [params setObject:hospitalAddress forKey:@"firmaddress"];
    [params setObject:name forKey:@"name"];
    [params setObject:phone forKey:@"contact"];
    [params setObject:address forKey:@"address"];
    [params setObject:manufacturer forKey:@"systemfactory"];
    [params setObject:model forKey:@"systemmodel"];
    [params setObject:sn forKey:@"systemsn"];
    [params setObject:equipment forKey:@"equipment"];
    [params setObject:equipmentModel forKey:@"equipmentmodel"];
    [params setObject:equipmentSN forKey:@"equipmentsn"];
    if (content.hasValue) [params setObject:content forKey:@"description"];
    if (history.hasValue) [params setObject:history forKey:@"history"];
    if (remark.hasValue) [params setObject:remark forKey:@"remark"];
    [self postWithMethodName:@"/workorder/submitOrder"
                      params:params];
}
- (void)deleteWorkOrderWithID:(NSInteger)orderID {
    _workWithNoRespond = YES;
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:orderID] forKey:@"id"];
    [self postWithMethodName:@"/workorder/deleteOrder"
                      params:params];
}
- (void)closeWorkOrderWithID:(NSInteger)orderID {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:orderID] forKey:@"id"];
    [self postWithMethodName:@"/workorder/closeOrder"
                      params:params];
}
- (void)rejectWorkOrderWithID:(NSInteger)orderID content:(NSString*)content {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:orderID] forKey:@"id"];
    if (content.hasValue) [params setObject:content forKey:@"content"];
    [self postWithMethodName:@"/workorder/auditNotpass"
                      params:params];
}
- (void)sendWorkOrderWithID:(NSInteger)orderID workerID:(NSInteger)workerID partsIDs:(NSArray*)partsIDs {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:orderID] forKey:@"id"];
    [params setObject:[NSNumber numberWithInteger:workerID] forKey:@"employeeid"];
    if (partsIDs.count > 0) {
        NSString * str = [partsIDs componentsJoinedByString:@","];
        [params setObject:str forKey:@"partsid"];
    }
    [self postWithMethodName:@"/workorder/sendWorkerParts"
                      params:params];
}
- (void)checkInWorkOrderWithID:(NSInteger)orderID {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:orderID] forKey:@"id"];
    [self postWithMethodName:@"/workorder/sign"
                      params:params];
}
- (void)addWorkOrderRecordWithID:(NSInteger)orderID progress:(CGFloat)progress parts:(NSArray*)parts content:(NSString*)content {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:orderID] forKey:@"id"];
    [params setObject:[NSString stringWithFormat:@"%.3f", progress] forKey:@"progress"];
    if (parts.count > 0) {
        NSString * str = [parts componentsJoinedByString:@","];
        [params setObject:str forKey:@"useparts"];
    }
    if (content.hasValue) [params setObject:content forKey:@"description"];
    [self postWithMethodName:@"/workorder/addRepairRecords"
                      params:params];
}
- (void)getWorkOrderRecordWithID:(NSInteger)orderID page:(NSInteger)page count:(NSInteger)count {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:orderID] forKey:@"id"];
    if (page > 0) [params setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    if (count > 0) [params setObject:[NSNumber numberWithInteger:count] forKey:@"pageSize"];
    [self postWithMethodName:@"/workorder/repairRecordsList"
                      params:params];
}
- (void)getAvaliablePartsForOrder:(NSInteger)orderID {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:orderID] forKey:@"id"];
    [self postWithMethodName:@"/workorder/valUseParts"
                      params:params];
}
- (void)usePartsWithOrder:(NSInteger)orderID date:(NSTimeInterval)date partsIDs:(NSArray*)partsIDs content:(NSString*)content {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:orderID] forKey:@"id"];
    if (partsIDs.count > 0) {
        NSString * str = [partsIDs componentsJoinedByString:@","];
        [params setObject:str forKey:@"partsids"];
    }
    [params setObject:[NSString stringWithFormat:@"%.0f", date] forKey:@"time"];
    [params setObject:content forKey:@"description"];
    [self postWithMethodName:@"/workorder/useParts"
                      params:params];
}
- (void)getUsedPartsWithOrder:(NSInteger)orderID {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:orderID] forKey:@"id"];
    [self postWithMethodName:@"/workorder/usePartsList"
                      params:params];
}
- (void)completeWorkOrderRepairWithID:(NSInteger)orderID {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:orderID] forKey:@"id"];
    [self postWithMethodName:@"/workorder/completeRepair"
                      params:params];
}
- (void)gainWorkOrderWithID:(NSInteger)orderID money:(double)money {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:orderID] forKey:@"id"];
    [params setObject:[NSString stringWithFormat:@"%.2f", money] forKey:@"money"];
    [self postWithMethodName:@"/workorder/charge"
                      params:params];
}
- (void)getGainHistoryWithID:(NSInteger)orderID {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:orderID] forKey:@"id"];
    [self postWithMethodName:@"/workorder/chargeList"
                      params:params];
}
- (void)completeWorkOrderGainWithID:(NSInteger)orderID {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:orderID] forKey:@"id"];
    [self postWithMethodName:@"/workorder/completeCharge"
                      params:params];
}
- (void)commentWorkOrderWithWithID:(NSInteger)orderID payment:(NSInteger)payment badLoans:(NSInteger)badLoans feel:(NSInteger)feel {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:orderID] forKey:@"id"];
    [params setObject:[NSNumber numberWithInteger:payment] forKey:@"pay"];
    [params setObject:[NSNumber numberWithInteger:badLoans] forKey:@"bill"];
    [params setObject:[NSNumber numberWithInteger:feel] forKey:@"feeling"];
    [self postWithMethodName:@"/workorder/orderComment"
                      params:params];
}
- (void)getWorkOrderCommentWithID:(NSInteger)orderID {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:orderID] forKey:@"id"];
    [self postWithMethodName:@"/workorder/commentDetail"
                      params:params];
}

#pragma mark -
#pragma mark - Spareparts
- (void)getSparepartsCategories {
    _needLogin = NO;
    [self getWithMethodName:@"/spareparts/categoryList"
                     params:nil];
}
- (void)getSparepartsWithStatus:(NSInteger)status page:(NSInteger)page count:(NSInteger)count keywords:(NSString*)keywords {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    if (status > 0) [params setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
    if (page > 0) [params setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    if (count > 0) [params setObject:[NSNumber numberWithInteger:count] forKey:@"pageSize"];
    if (keywords.hasValue) [params setObject:keywords forKey:@"keyword"];
    [self postWithMethodName:@"/parts/lists"
                      params:params];
}
- (void)getSparepartsWithKeywords:(NSString*)keywords model:(NSString*)model {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:@"1" forKey:@"status"];
    [params setObject:@"3" forKey:@"pageSize"];
    if (keywords.hasValue) [params setObject:keywords forKey:@"keyword"];
    if (model.hasValue) [params setObject:model forKey:@"partsnumber"];
    [self postWithMethodName:@"/parts/lists"
                      params:params];
}
- (void)getSparepartsWithID:(NSInteger)partsID {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:partsID] forKey:@"id"];
    [self postWithMethodName:@"/parts/detail"
                      params:params];
}
- (void)addSparepartsWithStatus:(NSInteger)status system:(NSString*)system partsType:(NSString*)partsType model:(NSString*)model sn:(NSString*)sn manufacturer:(NSString*)manufacturer quality:(NSInteger)quality buyTime:(NSTimeInterval)buyTime buyPrice:(double)price images:(NSArray*)images {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
    [params setObject:system forKey:@"systemtype"];
    [params setObject:partsType forKey:@"partstype"];
    [params setObject:model forKey:@"partsnumber"];
    [params setObject:sn forKey:@"serialnumber"];
    [params setObject:manufacturer forKey:@"manufacturers"];
    NSInteger qua = abs((int)quality - 10);
    [params setObject:[NSNumber numberWithInteger:qua] forKey:@"quality"];
    [params setObject:[NSString stringWithFormat:@"%.0f", buyTime] forKey:@"buytime"];
    [params setObject:[NSString stringWithFormat:@"%.2f", price] forKey:@"buyprice"];
    int i = 1;
    for (UIImage * img in images) {
        [params setObject:img forKey:[NSString stringWithFormat:@"picture%d", i]];
        i ++;
    }
    [self postWithMethodName:@"/parts/intoStore"
                      params:params];
}
- (void)editSparepartsIntoStoreWithID:(NSInteger)partsID user:(NSString*)user time:(NSTimeInterval)time sn:(NSString*)sn workOrderID:(NSString*)workOrderID content:(NSString*)content moneyCost:(double)moneyCost images:(NSArray*)images {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:partsID] forKey:@"id"];
    [params setObject:user forKey:@"user"];
    [params setObject:[NSString stringWithFormat:@"%.0f", time] forKey:@"time"];
    [params setObject:sn forKey:@"sn"];
    [params setObject:workOrderID forKey:@"workorderid"];
    [params setObject:content forKey:@"description"];
    if (moneyCost > 0) [params setObject:[NSString stringWithFormat:@"%.2f", moneyCost] forKey:@"money"];
    int i = 1;
    for (UIImage * img in images) {
        [params setObject:img forKey:[NSString stringWithFormat:@"picture%d", i]];
        i ++;
    }
    [self postWithMethodName:@"/parts/intoStoreHouse"
                      params:params];
}
- (void)editSparepartsUsingWithID:(NSInteger)partsID user:(NSString*)user time:(NSTimeInterval)time sn:(NSString*)sn workOrderID:(NSString*)workOrderID content:(NSString*)content images:(NSArray*)images {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:partsID] forKey:@"id"];
    [params setObject:user forKey:@"user"];
    [params setObject:[NSString stringWithFormat:@"%.0f", time] forKey:@"time"];
    [params setObject:sn forKey:@"sn"];
    [params setObject:workOrderID forKey:@"workorderid"];
    [params setObject:content forKey:@"description"];
    int i = 1;
    for (UIImage * img in images) {
        [params setObject:img forKey:[NSString stringWithFormat:@"picture%d", i]];
        i ++;
    }
    [self postWithMethodName:@"/parts/occupancy"
                      params:params];
}
- (void)editSparepartsConsumeWithID:(NSInteger)partsID user:(NSString*)user time:(NSTimeInterval)time manager:(NSString*)manager content:(NSString*)content images:(NSArray*)images {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:partsID] forKey:@"id"];
    [params setObject:user forKey:@"user"];
    [params setObject:[NSString stringWithFormat:@"%.0f", time] forKey:@"time"];
    [params setObject:manager forKey:@"audituser"];
    [params setObject:content forKey:@"description"];
    int i = 1;
    for (UIImage * img in images) {
        [params setObject:img forKey:[NSString stringWithFormat:@"picture%d", i]];
        i ++;
    }
    [self postWithMethodName:@"/parts/consumption"
                      params:params];
}
- (void)editSparepartsRepairingWithID:(NSInteger)partsID user:(NSString*)user timeStart:(NSTimeInterval)timeStart timeEnd:(NSTimeInterval)timeEnd moneyCost:(double)moneyCost content:(NSString*)content images:(NSArray*)images {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:partsID] forKey:@"id"];
    [params setObject:user forKey:@"user"];
    [params setObject:[NSString stringWithFormat:@"%.0f", timeStart] forKey:@"time"];
    [params setObject:[NSString stringWithFormat:@"%.0f", timeEnd] forKey:@"completetime"];
    if (moneyCost > 0) [params setObject:[NSString stringWithFormat:@"%.2f", moneyCost] forKey:@"money"];
    [params setObject:content forKey:@"description"];
    int i = 1;
    for (UIImage * img in images) {
        [params setObject:img forKey:[NSString stringWithFormat:@"picture%d", i]];
        i ++;
    }
    [self postWithMethodName:@"/parts/repair"
                      params:params];
}
- (void)editSparepartsScrapWithID:(NSInteger)partsID user:(NSString*)user time:(NSTimeInterval)time manager:(NSString*)manager content:(NSString*)content images:(NSArray*)images {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:partsID] forKey:@"id"];
    [params setObject:user forKey:@"user"];
    [params setObject:[NSString stringWithFormat:@"%.0f", time] forKey:@"time"];
    [params setObject:manager forKey:@"audituser"];
    [params setObject:content forKey:@"description"];
    int i = 1;
    for (UIImage * img in images) {
        [params setObject:img forKey:[NSString stringWithFormat:@"picture%d", i]];
        i ++;
    }
    [self postWithMethodName:@"/parts/scrapped"
                      params:params];
}

#pragma mark - NewHome
//获取广告列表
- (void)getTheHomeAdListWithType_id:(NSInteger)type_id {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:type_id] forKey:@"type_id"];
    [self postWithMethodName:@"adlists/lists" params:params];
}

- (void)getTheGoodsListWithCate_id:(NSInteger)cate_id {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:[NSNumber numberWithInteger:cate_id] forKey:@"cate_id"];
    [self postWithMethodName:@"goodscate/lists" params:params];
}

@end
