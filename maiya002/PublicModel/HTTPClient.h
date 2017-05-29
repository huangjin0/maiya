//
//  HTTPClient.h
//  DengDao
//
//  Created by WangShanhua on 16/6/15.
//  Copyright © 2016年 choucheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface HTTPClient : NSObject

typedef void(^success)(id responseObject);
typedef void(^faile)(NSString *faile);
typedef void(^progress)(NSProgress *progress);

//@property (nonatomic,assign) BOOL needHUD;      //是否显现请求状态


+ (instancetype)shareAFNetClient;

#pragma mark - LogIn
/**
 * 注册获取验证码
 * phone 手机号
 */
- (void)userGetRegistCodeWithPhone:(NSString *)phone success:(success)success progress:(progress)progress faile:(faile)faile;

/**
 * 注册
 * phone 手机号
 * password 密码
 * verifyCode 验证码
 */
- (void)userRegistWithPhone:(NSString *)phone passWord:(NSString *)passWord verifyCode:(NSString *)verifyCode success:(success)success faile:(faile)faile;

/**
 * 登录
 * phone 手机号
 * password 密码
 */
- (void)userLogInWithPhone:(NSString *)phone password:(NSString *)password success:(success)success faile:(faile)faile;

/**
 * 忘记密码获取验证码
 * phone 手机号
 * group 用户类型 3：用户 4：业务员
 */
- (void)userGetForgetCodeWithPhone:(NSString *)phone group:(NSInteger)group success:(success)success faile:(faile)faile;
/**
 * 忘记密码重置密码
 * phone 手机号
 * password 密码
 * code 验证码
 * group 用户类型 3：用户 4：业务员
 */
- (void)userForgetPassWordWithPhone:(NSString *)phone password:(NSString *)password code:(NSString *)code group:(NSInteger)group success:(success)success faile:(faile)faile;

#pragma mark - Main
/**
 * 首页banner图
 * type banner类型 jj_banner：寄件订单 ms_banner：美食订单 dg_banner:代购订单
 */
- (void)userGetBannerWithType:(NSString *)type Success:(success)success faile:(faile)faile;

#pragma mark - Food
/**
 * 商家列表
 * page 当前页
 * pagesize 每页数量
 * type_id 商家分类Id
 * coordinate2D 定位坐标
 * city 地位城市
 */
- (void)ShopListWithPage:(NSInteger)page pageSize:(NSInteger)pageSize type_id:(NSInteger)type_id coordinate2D:(CLLocationCoordinate2D)coordinate2D city:(NSString *)city success:(success)success faile:(faile)faile;

/**
 * 商家评论
 * shop_id 商铺id
 * page 当前页
 * pagesize 每页数量
 * score 分值 0：全部 1：好评 2：中评 3：差评
 */
- (void)userGetShopCommetWithShop_id:(NSInteger)shop_id page:(NSInteger)page pagesize:(NSInteger)pagesize score:(NSInteger)score success:(success)success faile:(faile)faile;

/**
 * 搜索商家
 * page 当前页
 * pagesize 每页数量
 * coordinate2D 定位坐标
 * city 定位城市
 * key 搜索关键字
 */
- (void)userSearchShopWithPage:(NSInteger)page pagesize:(NSInteger)pagesize coordinate2D:(CLLocationCoordinate2D)coordinate2D city:(NSString *)city key:(NSString *)key success:(success)success faile:(faile)faile;
/**
 * 产品列表
 * shop_id 商铺id
 */
- (void)goodsListWithShop_id:(NSInteger)shop_id success:(success)success faile:(faile)faile;

/**
 * 附近商家
 * coordinate2D 当前坐标
 * city 城市
 */
- (void)userGetNearlyShopWithCoordinate2D:(CLLocationCoordinate2D)coordinate2D city:(NSString *)city success:(success)success faile:(faile)faile;

#pragma mark - Person
/**
 * 获取个人资料
 * ucode
 */
- (void)userGetInfoWithUcode:(NSString *)ucode success:(success)success faile:(faile)faile;

/**
 * 修改个人资料
 * ucode 
 * real_name 真实姓名
 * nack_name 呢称
 * sex 性别 1：男 2：女 3：中性 4：保密
 * head_img 头像
 * Tel 联系电话
 * birthday 年龄
 */
- (void)userEditInfoWithUcode:(NSString *)ucode real_name:(NSString *)real_name nack_name:(NSString *)nack_name sex:(NSInteger)sex head_img:(NSData *)head_img tel:(NSString *)tel birthday:(NSString *)birthday success:(success)success faile:(faile)faile;

/**
 * 获取地址列表
 * ucode
 */
- (void)userGetAddressListWithUcode:(NSString *)ucode success:(success)success faile:(faile)faile;

/**
 * 添加收货地址
 * ucode 
 * coordinate2D 地址坐标
 * link_uname 联系人姓名
 * tel 联系电话
 * address 详细地址
 * extend1 城市
 * address_more 更多详细地址
 */
- (void)userAddAddressWithUcode:(NSString *)ucode coordinate2D:(CLLocationCoordinate2D)coordinate2D link_uname:(NSString *)link_uname tel:(NSString *)tel address:(NSString *)address extend1:(NSString *)extend1 address_more:(NSString *)address_more success:(success)success faile:(faile)faile;
/**
 * 设置默认收货地址
 * ucode 
 * addr_id 地址id
 */
- (void)userSetDefaultAddressWithUcode:(NSString *)ucode addr_id:(NSInteger)addr_id success:(success)success faile:(faile)faile;
/**
 * 编辑收货地址
 * addr_id 地址id
 * coordinate2D 地址坐标
 * link_uname 联系人
 * tel  联系电话
 * address 详细地址
 * ucode 
 * extend1 城市
 */
- (void)userEditAddressWithUcode:(NSString *)ucode addr_id:(NSInteger)addr_id coordinate2D:(CLLocationCoordinate2D)coordinate2D link_uname:(NSString *)link_uname tel:(NSString *)tel address:(NSString *)address extend1:(NSString *)extend1 address_more:(NSString *)address_more success:(success)sucess faile:(faile)faile;

/**
 * 删除收货地址
 * ucode 
 * addr_id 地址id
 */
- (void)userDeleteAddressWithUcode:(NSString *)ucode addr_id:(NSInteger)addr_id success:(success)success faile:(faile)faile;

/**
 * 优惠券列表
 * ucode
 */
- (void)userGetCouponsListWithUcode:(NSString *)ucode success:(success)success faile:(faile)faile;

/**
 * 获取消息列表
 */
- (void)userGetMessageListWithUcode:(NSString *)ucode success:(success)success faile:(faile)faile;

/**
 * 充值
 * money 充值金额
 * paytype 充值方式 1：支付宝 2：微信
 */
- (void)userReChargeWithUcode:(NSString *)ucode money:(NSString *)money paytype:(NSInteger)paytype success:(success)success faile:(faile)faile;

/**
 * 账户流水列表
 * ucode 
 * page 页数
 * pagesize 每页数量
 */
- (void)userGetDrawListWithUcode:(NSString *)ucode page:(NSInteger)page pagesize:(NSInteger)pagesize success:(success)success faile:(faile)faile;

#pragma mark - Order
/**
 * 寄件订单价格计算
 * hair_lng 发件经度
 * hair_lat 发件纬度
 * hair_city 发件城市
 * take_lng 收件经度
 * take_lat 收件纬度
 * take_city 收件城市
 * weight 重量
 * price_pay 垫付费用
 */
- (void)countPriceWithHair_coordinate2D:(CLLocationCoordinate2D)hair_coordinate2D hair_city:(NSString *)hair_city take_coordinate2D:(CLLocationCoordinate2D)take_coordinate2D take_city:(NSString *)take_city weight:(NSInteger)weight price_pay:(NSInteger)parice_pay success:(success)success faile:(faile)faile;

/**
 * 美食订单价格计算
 * shop_id 商家id
 * take_coordinate2D 收件坐标
 * take_city 收件城市
 * goods 商品
 */
- (void)countFoodOrderPriceWithShop_id:(NSInteger)shop_id take_coordinate2D:(CLLocationCoordinate2D)take_coordinte2D take_city:(NSString *)take_city goods:(NSString *)goods success:(success)success faile:(faile)faile;

/**
 * 代购订单价格计算
 * hair_coordinate2D 发件坐标
 * hair_city 发件城市
 * take_coordinate2D 收件坐标
 * take_city 收件城市
 */
- (void)countRelaceBuyOrderPriceWithHair_coordinate2D:(CLLocationCoordinate2D)hair_coordinate2D hair_city:(NSString *)hair_city take_coordinate2D:(CLLocationCoordinate2D)take_coordinate2D take_city:(NSString *)take_city success:(success)success faile:(faile)faile;

/**
 * 提交订单统一下单接口
 * model 订单模型 jjdd:寄件订单 fjg:附近购 zdg:指定购 hzsj:合作商家
 * pay_type 支付方式    1：货到付款 2：支付宝支付 3：微信支付 4：账户余额支付
 * price_serve 服务费，不包含天气补助
 * price_weather 天气补助
 * price_pay 垫付费用
 * distance 距离
 * goodtype_id 寄件订单物品属性id
 * goodtype_title 寄件订单物品属性名称
 * hair_coordinate2D 发件坐标、商家坐标
 * hair_city 发件城市、商家城市
 * hair_name 发件姓名
 * hair_phone 发件手机
 * hair_address 发件地址
 * take_coordinate2D 收件坐标
 * take_city 收件城市
 * take_name 收件姓名
 * take_phone 收件手机
 * take_address 收件地址
 * desc 订单备注、订单说明、需要的商品
 * mp3 声音
 * shop_id 合作商家ID
 * goods 购买商品详细json 
 * weight 寄件订单商品重量
 * ucode 
 * take_address_more 收货地址更多
 * hair_address_more 发货地址更多
 * voucher_id   优惠券id
 * pick_up_time 寄件订单取货时间
 */
- (void)commitOrderWithUcode:(NSString *)ucode model:(NSString *)model pay_type:(NSInteger)pay_type price_serve:(NSString *)price_serve price_weather:(NSString *)price_weather price_pay:(NSString *)price_pay distance:(NSInteger)distance goodtype_id:(NSInteger)goodtype_id goodtype_title:(NSString *)goodtype_title hair_coordinate2D:(CLLocationCoordinate2D)hair_coordinate2D hair_city:(NSString *)hari_city hari_name:(NSString *)hair_name hair_phone:(NSString *)hair_phone hair_address:(NSString *)hair_address take_coordinate2D:(CLLocationCoordinate2D)take_coordinate2D take_city:(NSString *)take_city take_name:(NSString *)take_name take_phone:(NSString *)take_phone take_address:(NSString *)take_address desc:(NSString *)desc mp3:(NSData *)mp3 shop_id:(NSInteger)shop_id goods:(NSString *)goods weight:(NSInteger)weight take_address_more:(NSString *)take_address_more hair_address_more:(NSString *)hair_address_more voucher_id:(NSInteger)voucher_id pick_up_time:(NSInteger)pick_up_time success:(success)success faile:(faile)faile;

/**
 * 我的订单列表
 * ucode 
 * type 类型 1：所有订单 2：服务中订单 3：待评价订单 4：已取消订单
 * page 页码
 * pagesize 每页条数
 */
- (void)userGetOrderListWithUcode:(NSString *)ucode type:(NSInteger)type page:(NSInteger)page pagesize:(NSInteger)pagesize success:(success)success faile:(faile)faile;

/**
 * 订单状态描述
 * order_number 订单编号
 */
- (void)userGetOrderStateWithOrder_number:(NSString *)order_number success:(success)success faile:(faile)faile;

/**
 * 用户确认支付订单
 * ucode
 * order_id 订单id
 * paytype 支付方式 1：货到付款 2：支付宝 3：微信支付 4：余额支付
 */
- (void)userConfirmPayWithUcode:(NSString *)ucode order_id:(NSInteger)order_id paytype:(NSInteger)paytype success:(success)success faile:(faile)faile;

/**
 * 订单详细
 * ucode
 * order_id 订单id
 */
- (void)orderDetailWithUcode:(NSString *)ucode order_id:(NSInteger)order_id success:(success)success faile:(faile)faile;

/**
 * 取消订单
 * ucode
 * order_id 订单id
 */
- (void)userCancelOrderWithUcode:(NSString *)ucode order_id:(NSInteger)order_id success:(success)success faile:(faile)faile;

#pragma mark -Other

/**
 * 意见反馈
 * ucode 
 * content 反馈内容
 */
- (void)userFeedBackWithUcode:(NSString *)ucode content:(NSString *)content success:(success)success faile:(faile)faile;

@end
