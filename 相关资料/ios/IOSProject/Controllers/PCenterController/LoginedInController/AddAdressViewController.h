//
//  AddAdressViewController.h
//  IOSProject
//
//  Created by IOS004 on 15/6/15.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "BasicTableViewController.h"

@protocol SaveAddressDelegate <NSObject>

@optional
-(void)backAddressViewControllerWithDic:(NSDictionary *)dic;
-(void)backaddressForEdit;

@end
@interface AddAdressViewController : BasicTableViewController

//修改地址
@property (nonatomic,assign) NSInteger type;

//修改地址的的addrid
@property (nonatomic,strong) NSString *addrid;
@property (nonatomic,strong) NSString *ucode;
//收货人
@property (nonatomic,strong) NSString *cossigneNam;
//联系电话
@property (nonatomic,strong) NSString *linkPhone;
//派送区域
@property (nonatomic,strong) NSString *sendArea;
//详细地址
@property (nonatomic,strong) NSString *detailAddress;
@property (nonatomic,strong) id<SaveAddressDelegate>delegate;

@end


@interface SearchTextField : UITextField



@end
