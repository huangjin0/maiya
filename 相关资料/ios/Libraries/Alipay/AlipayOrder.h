//
//  AlipayOrder.h
//  DrivingNeighborSchool
//
//  Created by Kiwi on 11/3/14.
//  Copyright (c) 2014 kiwiapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlipayOrder : NSObject

@property(nonatomic, copy) NSString * partner;
@property(nonatomic, copy) NSString * seller;
@property(nonatomic, copy) NSString * tradeNO;
@property(nonatomic, copy) NSString * productName;
@property(nonatomic, copy) NSString * productDescription;
@property(nonatomic, copy) NSString * amount;
@property(nonatomic, copy) NSString * notifyURL;

@property(nonatomic, copy) NSString * service;
@property(nonatomic, copy) NSString * paymentType;
@property(nonatomic, copy) NSString * inputCharset;
@property(nonatomic, copy) NSString * itBPay;
@property(nonatomic, copy) NSString * showUrl;


@property(nonatomic, copy) NSString * rsaDate;//可选
@property(nonatomic, copy) NSString * appID;//可选

@property(nonatomic, readonly) NSMutableDictionary * extraParams;

+ (id)orderWithPartner:(NSString*)partner seller:(NSString*)seller tradeNO:(NSString*)tradeNO name:(NSString*)name description:(NSString*)description amount:(NSString*)amount url:(NSString*)url;

@end
