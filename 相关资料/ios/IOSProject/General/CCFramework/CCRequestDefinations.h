//
//  CCRequestDefinations.h
//  CCFramework
//
//  Created by Kiwi on 3/11/15.
//  Copyright (c) 2015 CC Inc. All rights reserved.
//

#ifndef CCFramework_CCRequestDefinations_h
#define CCFramework_CCRequestDefinations_h

typedef NS_ENUM(NSInteger, CCRequestPostDataType) {
    CCRequestPostDataTypeNone      = 10,
    CCRequestPostDataTypeNormal    = 11, // for normal data post, such as "user=name&password=psd"
    CCRequestPostDataTypeMultipart = 12,  // for uploading images and files.
    CCRequestPostDataTypeJson = 13,  //
};

typedef NS_ENUM(NSInteger, CCErrorCode) {
    CCErrorCodeInterface = 100,
    CCErrorCodeSDK       = 101
};

typedef NS_ENUM(NSInteger, CCSDKErrorCode) {
    CCSDKErrorCodeParseError     = 200,
    CCSDKErrorCodeRequestError   = 201,
    CCSDKErrorCodeAccessError    = 202,
    CCSDKErrorCodeAuthorizeError = 203
};

#endif
