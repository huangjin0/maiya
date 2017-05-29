//
//  CCClient+Requests.h
//  DoctorFixBao
//
//  Created by Kiwi on 11/11/14.
//  Copyright (c) 2014 CC Inc. All rights reserved.
//

@interface CCClient (Requests)

#pragma mark -
#pragma mark - Account

//获取分类产品

-(void)getTheProduct;

//产品描述，产品详情
- (void)productDescription:(NSInteger)goods_id;
//type_id = 1,首页某个广告详情
- (void)mainPageadlists:(NSInteger)ad_id;
//首页中部广告位
- (void)advertisementsCentral:(NSInteger)type_id;
//首页尾部广告位
- (void)advertisementsTail:(NSInteger)type_id;
//首页头部广告位
- (void)bannerAdvertising:(NSInteger)type_id;
//特惠产品
- (void)mainPageDeals:(NSInteger)ad_id;
//产品评价数量
- (void)productEvaluationCount:(NSInteger)goods_id levelValueCount:(NSInteger)levelValueCount;
//产品评价列表
- (void)productEvaluationList:(NSInteger)goods_id level:(NSInteger)level pageing:(NSInteger)paging;
//产品详情
- (void)goodsInfo:(NSInteger)goods_id;
//产品列表
- (void)productList:(NSInteger)cate_id searchselect:(NSString *)select page:(NSInteger)page;
- (void)productList:(NSInteger)sort_price cate_id:(NSInteger)cate_id page:(NSInteger)page;
- (void)productListsales:(NSInteger)sort_sales cate_id:(NSInteger)cate_id page:(NSInteger)page;
- (void)productListselect:(NSString *)sort_select page:(NSInteger)page;
- (void)productListselect:(NSString *)select price:(NSInteger)sort_price page:(NSInteger)page;
- (void)productListselect:(NSString *)select sales:(NSInteger)sort_sales page:(NSInteger)page;
//分类列表
- (void)classificationList:(NSInteger)cate_id;
- (void)classificationListDif:(NSInteger)cate_id;
//关于我们
- (void)aboutUs:(NSString *)content;
//服务协议
- (void)theServiceAgreement:(NSString *)content;
//修改密码
-(void)changePassWordWithPhone:(NSString *)phone code:(NSString *)code passWord:(NSString *)passWord;
//忘记密码获取验证码
- (void)clickGetCodePhone:(NSString *)phone;
//验证手机验证码
- (void)getCode:(NSString *)code phone:(NSString *)phone;
//获取注册验证码
- (void)getRegisterVerifyCodeWithPhone:(NSString *)phone;
//验证手机号是否注册
-(void)checkPhoneNumRegistOrNotWithPhome:(NSString *)phone;
//注册手机
-(void)registAcountWithPhone:(NSString *)phonenum passWord:(NSString *)passWord;
//忘记密码——重置密码
-(void)findPsdWithPhone:(NSString *)phone code:(NSString *)code newPsd:(NSString *)newPsd;
//获取完成订单数
-(void)getTheNumOfOverOrder;
//获取个人基本资料
-(void)getUserBaseInfo;
//修改保存个人基本资料
-(void)saveOrChangeInfoWithUcode:(NSString *)ucode headImg:(NSString *)headImg nickName:(NSString *)nickName sex:(int)sex birthdate:(int)birthdate phone:(NSString *)phone;
//获取用户收藏列表
-(void)getListOfCollectGoods;
//添加用户收藏
-(void)addCollectGoodsWithGoodsId:(int)goodsId;
//取消用户收藏
-(void)cancelCollectGoodsWithGoodsId:(int)goodsId;
//检查产品是否收藏
- (void)collectionGoods:(int)goodsId;
//获取地址裂变
-(void)getListOfUserAddress;
//获取购物车列表
-(void)getListOfUserCart;//WithUcode:(NSString *)ucode;
//添加地址
-(void)addAddressWithUcode:(NSString *)ucode userName:(NSString *)userName tel:(NSString *)tel area:(NSString *)area address:(NSString *)address;
//获取小区列表
-(void)getTheListWithArea:(NSString *)area;
//取消地址
-(void)cancelAddressWithAddId:(int)addId;
//编辑收货地址
-(void)editAddressWithAddrId:(int)addId area:(NSString *)area linkName:(NSString *)linkName tel:(NSString *)tel adress:(NSString *)adress;
//添加默认地址
-(void)setDefaultsAddressWithAddrId:(int)addrId;
//取消默认地址
-(void)cancelDefaultsAddressWithAddrId:(int)addrId;
//获取默认地址详情
-(void)getDefaultsDetail;
//获取购物车数量
-(void)userGetCartNum;
//添加用户购物车
-(void)userAddShopcartWithGoodsId:(int)goodsId sperId:(int)sperId shopId:(int)shopId goodsName:(NSString *)goodsName goodsImg:(NSString *)goodsImg quantity:(int)quantity;
//获取运费信息
-(void)getInformationOfShippingfee;
//修改购物车数量
-(void)editTheQuantityOfCartWithQuantity:(int)quantity cartId:(NSString *)cartId;
//删除购物车
-(void)cancelShopcartWithCartId:(NSString *)cartId;
//获取商家运营时间
-(void)getTheTimeOfShopOpen;
//获取所有订单
-(void)getUserAllOrderListWithPage:(int)page;
//获取未支付订单
-(void)getUserNoPayOrderListWithPage:(int)page;
//获取未收货订单
-(void)getUserNoGetOrderListWithPage:(int)page;
//获取未评价订单
-(void)getUserNoContentOrderListWithPage:(int)page;
//获取完成订单
-(void)getUserIsOverOrderListWithPage:(int)page;
//获取退款中的订单
-(void)getUserrefundOrderListWithPage:(int)page;
//提交订单
-(void)addOrderWithcartId:(NSString *)cartId payWay:(int)payWay deliverType:(int)deliverType mack:(NSString *)mack linkName:(NSString *)linkName tel:(NSString *)tel address:(NSString *)address area:(NSString *)area bestStartTime:(NSInteger)bestStartTime bestEndTime:(NSInteger)bestEndTime;
//获取订单详情
-(void)getOrderDetailsWithOrderId:(int)orderId;
//获取购买订单数
-(void)getOverOrderListNum;
//删除订单
-(void)deleteOrderWithOrderId:(int)orderId;
//取消订单
-(void)cancelOrderWithOrderId:(int)orderId;
//确认收货
-(void)takeOverGoodsWithOrderId:(int)orderId;
//申请退款
-(void)refundOrderWithOrderId:(int)orderId content:(NSString *)content;
//取消申请退款
-(void)cancelRefundOrderWithOrderId:(int)orderId;
//再次购买
-(void)orderOfBuyAgainWithOrderId:(int)orderId;
//获取信息列表
-(void)getListOfMessage;
//发送信息
-(void)postMessegeWithShopId:(int)shopId shopName:(NSString *)shopName shopLogo:(NSString *)shopLogo content:(NSString *)content title:(NSString *)title;
//评价商品
-(void)addGoodsEvalWithOrderId:(int)orderId goodsId:(NSString *)goodsId specId:(NSString *)specId level:(NSString *)level content:(NSString *)content;
//支付宝
-(void)payOrderWithOrderNum:(NSString *)orderNum;
//订单失效时间
-(void)getTheTimeOfLoseTime;

- (void)getUserInfo;
// Login
- (void)loginWithAccount:(NSString*)account password:(NSString*)password;
// VerifyCode Sending
- (void)sendVerifyCodeWithPhone:(NSString*)phone type:(NSInteger)type;// 0-Register 1-Password
// VerifyCode Verifying
- (void)checkVerifyCodeWithPhone:(NSString*)phone code:(NSString*)code;
// Register
- (void)registerWithAccount:(NSString*)account password:(NSString*)password userName:(NSString*)userName inviteCode:(NSString*)inviteCode;
// Reset Password While Forget
- (void)resetPasswordWithPhone:(NSString*)phone password:(NSString*)password;
// Edit Password
- (void)editPassword:(NSString*)oldpass newPassword:(NSString*)newpass;
// Edit Phone Number
- (void)editPhone:(NSString*)oldPhone newPhone:(NSString*)newPhone verifyCode:(NSString*)verifyCode password:(NSString*)password;
// Edit User Information
- (void)editUserName:(NSString*)username name:(NSString*)name email:(NSString*)email headImage:(UIImage*)headImage;
// Get User
- (void)getUserDetail;
// Individual Verification
- (void)applyIndividualVerificationWithName:(NSString*)name gender:(NSString*)gender phone:(NSString*)phone paperType:(NSString*)paperType paperNo:(NSString*)paperNo email:(NSString*)email organization:(NSString*)organization work:(NSString*)work cardFront:(UIImage*)cardFront cardBack:(UIImage*)cardBack cardInHand:(UIImage*)cardInHand;
// Enterprise Verification
- (void)applyEnterpriseVerificationWithName:(NSString*)name gender:(NSString*)gender phone:(NSString*)phone paperType:(NSString*)paperType paperNo:(NSString*)paperNo email:(NSString*)email cardFront:(UIImage*)cardFront cardBack:(UIImage*)cardBack cardInHand:(UIImage*)cardInHand organization:(NSString*)organization memberSize:(NSString*)memberSize address:(NSString*)address work:(NSString*)work nameRM:(NSString*)nameRM cardNoRM:(NSString*)cardNoRM cardFrontRM:(UIImage*)cardFrontRM cardBackRM:(UIImage*)cardBackRM orgPaperType:(NSString*)orgPaperType orgPaperNo:(NSString*)orgPaperNo orgPaperImage:(UIImage*)orgPaperImage orgPaperType:(NSString*)orgPaperType2 orgPaperNo:(NSString*)orgPaperNo2 orgPaperImage:(UIImage*)orgPaperImage2 orgPaperType:(NSString*)orgPaperType3 orgPaperNo:(NSString*)orgPaperNo3 orgPaperImage:(UIImage*)orgPaperImage3;
- (void)getVerificationStatus;
- (void)feedbackWithContent:(NSString*)content image:(UIImage*)image;

#pragma mark -
#pragma mark - Notifications
- (void)setupAPNS:(NSString*)deviceID;
- (void)removeAPNS;
- (void)getNotificationsWithType:(NSInteger)type maxID:(NSInteger)maxID count:(NSInteger)count;
- (void)getUserUnreadCount;
- (void)markAsHandledWithID:(NSInteger)msgID;

#pragma mark -
#pragma mark - Funding
- (void)getFunding;
- (void)getStatisticsWithDateStart:(NSTimeInterval)start end:(NSTimeInterval)end;
- (void)getUngainOrders;
- (void)getGainOrders;

#pragma mark -
#pragma mark - Credits
- (void)getUserCreditsWithName:(NSString*)name phone:(NSString*)phone enterprice:(NSString*)enterprice;

#pragma mark -
#pragma mark - Wealth
- (void)getUnpaidOrdersWithType:(NSInteger)type;// 0-Spareparts 1-Repair
- (void)getUndoneOrdersWithType:(NSInteger)type;
- (void)getPaidOrdersWithType:(NSInteger)type;
- (void)getDoneOrdersWithType:(NSInteger)type;
- (void)payOrderWithType:(NSInteger)type// 0-Spareparts 1-Repair
                 payment:(NSInteger)payment// 0-Online 1-Offline
                 orderID:(NSInteger)orderID;
- (void)doneOrderWithType:(NSInteger)type orderID:(NSInteger)orderID;

#pragma mark -
#pragma mark - Employee
- (void)getUserWithPhone:(NSString*)phone;
- (void)getEmployeeRoles;
- (void)getMyEmployees;
- (void)deleteEmployeeWithID:(NSInteger)userID;
- (void)inviteEmployeeWithPhone:(NSString*)phone roleID:(NSInteger)roleID;
- (void)agreeEmployeeWithFirmID:(NSInteger)fid roleID:(NSInteger)roleID;
- (void)refuseEmployeeWithFirmID:(NSInteger)fid;

#pragma mark -
#pragma mark - WorkOrder
- (void)getWorkOrdersWithStatus:(NSInteger)type page:(NSInteger)page count:(NSInteger)count;
- (void)getWorkOrdersWithID:(NSInteger)orderID;
- (void)addWorkOrderID;
- (void)addWorkOrderWithID:(NSInteger)orderID from:(NSString*)from money:(double)money hospital:(NSString*)hospital hospitalAddress:(NSString*)hospitalAddress name:(NSString*)name phone:(NSString*)phone address:(NSString*)address manufacturer:(NSString*)manufacturer model:(NSString*)model sn:(NSString*)sn equipment:(NSString*)equipment equipmentModel:(NSString*)equipmentModel equipmentSN:(NSString*)equipmentSN content:(NSString*)content history:(NSString*)history remark:(NSString*)remark;
- (void)deleteWorkOrderWithID:(NSInteger)orderID;
- (void)closeWorkOrderWithID:(NSInteger)orderID;
- (void)rejectWorkOrderWithID:(NSInteger)orderID content:(NSString*)content;
- (void)sendWorkOrderWithID:(NSInteger)orderID workerID:(NSInteger)workerID partsIDs:(NSArray*)partsIDs;
- (void)checkInWorkOrderWithID:(NSInteger)orderID;
- (void)addWorkOrderRecordWithID:(NSInteger)orderID progress:(CGFloat)progress parts:(NSArray*)parts content:(NSString*)content;
- (void)getWorkOrderRecordWithID:(NSInteger)orderID page:(NSInteger)page count:(NSInteger)count;
- (void)getAvaliablePartsForOrder:(NSInteger)orderID;
- (void)usePartsWithOrder:(NSInteger)orderID date:(NSTimeInterval)date partsIDs:(NSArray*)partsIDs content:(NSString*)content;
- (void)getUsedPartsWithOrder:(NSInteger)orderID;
- (void)completeWorkOrderRepairWithID:(NSInteger)orderID;
- (void)gainWorkOrderWithID:(NSInteger)orderID money:(double)money;
- (void)getGainHistoryWithID:(NSInteger)orderID;
- (void)completeWorkOrderGainWithID:(NSInteger)orderID;
- (void)commentWorkOrderWithWithID:(NSInteger)orderID payment:(NSInteger)payment badLoans:(NSInteger)badLoans feel:(NSInteger)feel;
- (void)getWorkOrderCommentWithID:(NSInteger)orderID;

#pragma mark -
#pragma mark - Spareparts
- (void)getSparepartsCategories;
- (void)getSparepartsWithStatus:(NSInteger)status page:(NSInteger)page count:(NSInteger)count keywords:(NSString*)keywords;
- (void)getSparepartsWithKeywords:(NSString*)keywords model:(NSString*)model;
- (void)getSparepartsWithID:(NSInteger)partsID;
- (void)addSparepartsWithStatus:(NSInteger)status system:(NSString*)system partsType:(NSString*)partsType model:(NSString*)model sn:(NSString*)sn manufacturer:(NSString*)manufacturer quality:(NSInteger)quality buyTime:(NSTimeInterval)buyTime buyPrice:(double)price images:(NSArray*)images;
- (void)editSparepartsIntoStoreWithID:(NSInteger)partsID user:(NSString*)user time:(NSTimeInterval)time sn:(NSString*)sn workOrderID:(NSString*)workOrderID content:(NSString*)content moneyCost:(double)moneyCost images:(NSArray*)images;
- (void)editSparepartsUsingWithID:(NSInteger)partsID user:(NSString*)user time:(NSTimeInterval)time sn:(NSString*)sn workOrderID:(NSString*)workOrderID content:(NSString*)content images:(NSArray*)images;
- (void)editSparepartsConsumeWithID:(NSInteger)partsID user:(NSString*)user time:(NSTimeInterval)time manager:(NSString*)manager content:(NSString*)content images:(NSArray*)images;
- (void)editSparepartsRepairingWithID:(NSInteger)partsID user:(NSString*)user timeStart:(NSTimeInterval)timeStart timeEnd:(NSTimeInterval)timeEnd moneyCost:(double)moneyCost content:(NSString*)content images:(NSArray*)images;
- (void)editSparepartsScrapWithID:(NSInteger)partsID user:(NSString*)user time:(NSTimeInterval)time manager:(NSString*)manager content:(NSString*)content images:(NSArray*)images;

#pragma mark - NewHome

//获取广告位列表
- (void)getTheHomeAdListWithType_id:(NSInteger)type_id;

#pragma mark - NewClass
- (void)getTheGoodsListWithCate_id:(NSInteger)cate_id;

@end
