//
//  ClassificationOfGoodsViewController.m
//  IOSProject
//
//  Created by IOS004 on 15/6/18.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "ClassificationOfGoodsViewController.h"
#import "SearchPageViewController.h"
#import "CommodityViewController.h"
#import "NLMainTableViewController.h"
#import "LoginingViewController.h"
#import "ClassOfGoodsModel.h"
#import "ClassOfGoodsCell.h"
#import "NLMainTableViewController.h"
#import "ClassificationViewController.h"
#import "ShoppingCartViewController.h"

@interface ClassificationOfGoodsViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,logInDelegate,classficationDelegate,classofgoodsDelegate>{
    
    NSArray        * _arrlist;     //分类列表
    NSMutableArray * _arrNameList; //分类名称
    NSString       * _strNameList;
    NSString * _p_idlist;
    NSMutableArray * _arr_p_idlist; //父类为0，数组取出名称
    NSMutableArray * _arr_goods_id; //取出goods_id名称；
    NSInteger _intp_listid;
    
    NSArray        * _arr;         //产品列表;
    NSMutableArray * _arrName;     //商品名称;
    NSMutableArray * _arrImage;    //商品图片;
    NSMutableArray * _arrPrice;    //商品价格;
    NSMutableArray * _arroldPrice; //商品旧价格
    NSString       * _strname;     //字符串
    NSString       * _strimage;
    NSString       * _strprice;
    NSString       * _stroldprice;
    NSInteger        _sort_price;
    NSInteger        _sort_sales;
    NSString * _select;
    NSInteger _cate_id_classfication;  //产品分类id
    NSMutableDictionary * _diclist;
    NSMutableDictionary * _dic;
    NSInteger _intcateid_list3;
    UIButton * _sortingbtn1;
    UIButton * _sortingbtn2;
    UIButton * _sortingbtn3;
    UIImageView * _image3;
    UIImageView * _image2;
    BOOL _flag;
    NSString * _strstok;
    NSString * _strvirtal;
    //加入购物车所需参数
    NSInteger   _goods_id;     //产品id
    NSInteger   _spec_id;      //规格id
    NSInteger   _shop_id;      //商品id
    NSString  * _goods_name;   //产品名
    NSString  * _goods_image;  //产品图片
    NSInteger   _quantity;     //数量

    NSMutableArray * _allParameter;
    ClassOfGoodsModel * _goodsmodel;
    NSMutableDictionary * _dict;
    
    NSString *_cartID1;
    //    一级分类数组
    NSMutableArray *_classOneArr;
    //    二级分类数组
    NSMutableArray *_classTwoArr;
    //    三级分类数组
    NSMutableArray *_classThrArr;
    NSArray * _result;
    
    NSString * _goods_idValue;  //传值goods_id
    NSInteger _goods_idInt;
    NSString * _cartidValue;    //传值p_id
    NSString * _cartFirstId;
    NSString * _firstName;
    NSString * _passName;
    NSMutableArray * _arrcartId;
    NSString * _strcartId;
    NSMutableArray * _goodsidarr;
    NSMutableArray * _arrsecond;
    NSMutableArray * _arrpidname;
    NSString * _strFirstName;
    
    NSArray *_classThreeArr;
    UIImageView * _image;
    UIImageView * _imageCol;
    UIImageView * _noSearch;
    UILabel * _lab;
//    页数
    NSInteger _selectPage;
//    选中类型
    NSInteger _selectType;
//    总数
    NSInteger _totalCount;
}

@end

NSString * classgoods_id;

@implementation ClassificationOfGoodsViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self addBackButtonToNavigation];
    [self addLoadMoreView];
    _selectPage = 1;
    _allParameter = [NSMutableArray array];
    _arrName = [NSMutableArray array];
    _arrImage = [NSMutableArray array];
    _arrPrice = [NSMutableArray array];
    _arroldPrice = [NSMutableArray array];
    _arr_goods_id = [NSMutableArray array];
    _classThrArr = [NSMutableArray array];
    _goodsidarr = [NSMutableArray array];
    [self startRequest:101];
    
    UIButton * rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame = CGRectMake(10, 0, 20, 20);
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    UIButton * searchbtn = [[UIButton alloc] init];
    [searchbtn setBackgroundImage:[UIImage imageNamed:@"search__@3x"] forState:UIControlStateNormal];
    [searchbtn addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    searchbtn.frame = CGRectMake(60, 10, 180, 30);
    self.navigationItem.titleView = searchbtn;
    
    CGFloat w = self.view.width;
    _sortingbtn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, w / 3, 50)];
    _sortingbtn1.backgroundColor = RGBCOLOR(243, 243, 243);
    [self.view addSubview:_sortingbtn1];
    _sortingbtn2 = [[UIButton alloc] initWithFrame:CGRectMake(w / 3, 0, w / 3, 50)];
    _sortingbtn2.backgroundColor = RGBCOLOR(243, 243, 243);
    [self.view addSubview:_sortingbtn2];
    _sortingbtn3 = [[UIButton alloc] initWithFrame:CGRectMake(w / 3 * 2, 0, w / 3, 50)];
    _sortingbtn3.backgroundColor = RGBCOLOR(243, 243, 243);
    [self.view addSubview:_sortingbtn3];
        
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 50, 50)];
    UILabel * lab2 = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 50, 50)];
    UILabel * lab3 = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 50, 50)];
    lab.text = @"分类";
    lab2.text = @"价格";
    lab3.text = @"销量";
    lab.textColor = [UIColor colorFromHexCode:@"#757575"];
    lab2.textColor = [UIColor colorFromHexCode:@"#757575"];
    lab3.textColor = [UIColor colorFromHexCode:@"#757575"];
    lab.font = [UIFont systemFontOfSize:18];
    lab2.font = [UIFont systemFontOfSize:18];
    lab3.font = [UIFont systemFontOfSize:18];
    [_sortingbtn1 addSubview:lab];
    [_sortingbtn2 addSubview:lab2];
    [_sortingbtn3 addSubview:lab3];
        
    UIImageView * image1 = [[UIImageView alloc] initWithFrame:CGRectMake(25, 12, 25, 25)];
    _image2 = [[UIImageView alloc] initWithFrame:CGRectMake(25, 12, 25, 25)];
    _image3 = [[UIImageView alloc] initWithFrame:CGRectMake(25, 12, 25, 25)];
    image1.image = [UIImage imageNamed:@"fenlei_ic_flpx_press"];
    _image2.image = [UIImage imageNamed:@"fenlei_ic_jgpx_press"];
    _image3.image = [UIImage imageNamed:@"fenlei_ic_rqpx_press"];
    [_sortingbtn1 addSubview:image1];
    [_sortingbtn2 addSubview:_image2];
    [_sortingbtn3 addSubview:_image3];
    
    [_sortingbtn1 addTarget:self action:@selector(clickClassification) forControlEvents:UIControlEventTouchUpInside];
    [_sortingbtn2 addTarget:self action:@selector(clickPrice) forControlEvents:UIControlEventTouchUpInside];
    [_sortingbtn3 addTarget:self action:@selector(clickProductCount) forControlEvents:UIControlEventTouchUpInside];
    
    //页眉添加悬浮购物车标签，点击直接进入购物车界面
    UIButton * shoppingbtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 50, ScreenHeight - 120, 50, 50)];
    UIImageView * imageB = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imageB.image = [UIImage imageNamed:@"home_ic_gouwuche_normal"];
    [shoppingbtn addSubview:imageB];
//    [shoppingbtn setImage:[UIImage imageNamed:@"home_ic_gouwuche_normal"] forState:UIControlStateNormal];
    [shoppingbtn addTarget:self action:@selector(returnShoppingCart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shoppingbtn];
    
    if( _arr.count == 0) {
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _image.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_image];
        _imageCol = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _imageCol.backgroundColor = [UIColor colorFromHexCode:@"Color_bkg_green"];
        [_image addSubview:_imageCol];
        
        _noSearch = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width / 2 - 62.5, 138, 125, 125)];
        _noSearch.image = [UIImage imageNamed:@"search_pic"];
        [_image addSubview:_noSearch];
        _lab = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width / 2 - 85, 290, 170, 30)];
        _lab.text = @"抱歉，没找到相关商品";
        _lab.textColor = [UIColor colorFromHexCode:@"#b3b3b3"];
        [_image addSubview:_lab];
    }
}

/**
 *有多少个sections
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrName.count;
}

/**
 *每个section有多少个cell
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"identifier";
    ClassOfGoodsModel * model = [_allParameter objectAtIndex:indexPath.row];
    ClassOfGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ClassOfGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else
        [cell cleanUpSubviews];
    cell.backgroundColor = [UIColor clearColor];
    cell.item = model;
    cell.delegate = self;
        for (NSInteger i = 0; i < _arrName.count; i ++) {
//        NSArray * arr = @[@"#ff0000",@"#757575"];
            
        if (indexPath.section == i) {
            if (indexPath.row == 0) {
                _image.backgroundColor = nil;
                _imageCol.backgroundColor = nil;
                _noSearch.image = nil;
                _lab.text = nil;
                UIImageView * logoimage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 75, 75)];
                [logoimage setImageWithURL:_arrImage[i]];
                [cell.contentView addSubview:logoimage];
        
                UILabel * titlelab = [[UILabel alloc] initWithFrame:CGRectMake(115, 10, 200, 20)];
                titlelab.text = _arrName[i];
                titlelab.textColor = [UIColor colorFromHexCode:@"#333333"];
                titlelab.font = [UIFont systemFontOfSize:18];
                [cell.contentView addSubview:titlelab];
                
                NSString *newPri = _arrPrice[i];
                NSString *olcPri = _arroldPrice[i];
                UILabel * newPrice = [UILabel singleLineText:_arrPrice[i] font:[UIFont systemFontOfSize:13] wid:100 color:[UIColor colorFromHexCode:@"ff0000"]];
                newPrice.origin = CGPointMake(125, 60);
                [cell.contentView addSubview:newPrice];
                UILabel * oldSingle = [UILabel singleLineText:@"￥" font:[UIFont systemFontOfSize:13] wid:20 color:[UIColor colorFromHexCode:@"ff0000"]];
                oldSingle.origin = CGPointMake(115, 60);
                [cell.contentView addSubview:oldSingle];
                if (newPri.floatValue != olcPri.floatValue) {
                    UILabel * oldPrice = [UILabel singleLineText:_arroldPrice[i] font:[UIFont systemFontOfSize:11] wid:100 color:[UIColor colorFromHexCode:@"757575"]];
                    oldPrice.origin = CGPointMake(newPrice.width + 145, 62);
                    [cell.contentView addSubview:oldPrice];
                    
                    UILabel * newSingle = [UILabel singleLineText:@"￥" font:[UIFont systemFontOfSize:11] wid:20 color:[UIColor colorFromHexCode:@"757575"]];
                    newSingle.origin = CGPointMake(newPrice.width + 135, 62);
                    [cell.contentView addSubview:newSingle];

                    UIImageView * imageline = [[UIImageView alloc] initWithFrame:CGRectMake(newPrice.width + 135, 70, oldPrice.width + 20, 1)];
                    imageline.backgroundColor = [UIColor colorFromHexCode:@"#757575"];
                    [cell.contentView addSubview:imageline];
                }
                }
            }
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 50;
    }else{
        return 5;
    }
}

/**
 *cell的点击事件
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CommodityViewController * commodity = [[CommodityViewController alloc] init];

    NSString * strgoodsid = [_arr_goods_id objectAtIndex:indexPath.section];
    commodity.strgoods_id = strgoodsid;
    [self.navigationController pushViewController:commodity animated:YES];
}

/**
 *设置header
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * headerview = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.view.width, 50)]; //创建一个视图
    headerview.backgroundColor = RGBCOLOR(243, 243, 243);

    if (section == 0) {
        UIImageView * background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
        background.backgroundColor = [UIColor whiteColor];
        [headerview addSubview:background];
    }
    return headerview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

//实现代理方法
- (void)passgoodsid:(NSString *)goods{
    _goods_idValue = goods;
    _goods_idInt = [_goods_idValue integerValue];
    [_goodsidarr addObject:_goods_idValue];
}
- (void)firstcartId:(NSString *)cartid{
    _cartidValue = cartid;//二级栏cart_id
}
- (void)firstName:(NSString *)name{
    _firstName = name;
}
- (void)passName:(NSString *)passName{
    _arrpidname = [NSMutableArray array];
    _passName = passName;
    [_arrpidname addObject:_passName];
}
- (void)secondcartId:(NSString *)cartid{
    _cartidValue = cartid;
}
- (void)arrNameList:(NSString *)nameList{
    _strFirstName = nameList;
}
- (void)cartid:(NSString *)cartid{
}
- (void)firstcartAtSecondId:(NSString *)cartid{
    _cartFirstId = cartid;
}
/**
 跳转到搜索界面
 */
- (void)searchButtonAction{
    SearchPageViewController * searchPage = [[SearchPageViewController alloc] init];
    [self.navigationController pushViewController:searchPage animated:YES];
}

/**
 * 提示框，加入购物车成功
 */
- (void)joinCartSuccess:(ClassOfGoodsCell *)cell{
    if ([IEngine engine].isSignedIn) {
        NSIndexPath * index = [_tableView indexPathForCell:cell];
        _goodsmodel = [_allParameter objectAtIndex:index.section];
        [self startRequest:103];
        [CCAlertView showText:@"加入购物车成功" life:1.0];
    }else{
        [CCAlertView showText:@"请登录" life:2.0];
        LoginingViewController *logingVC = [[LoginingViewController alloc] init];
        logingVC.delegate = self;
        [self.navigationController pushViewController:logingVC animated:YES];
    }
}
- (void)returnShoppingCart{
    
    if ([IEngine engine].isSignedIn) {
        ShoppingCartViewController * shoppingcart = [[ShoppingCartViewController alloc] init];
        [self.navigationController pushViewController:shoppingcart animated:YES];
    } else {
        [CCAlertView showText:@"请登录" life:2.0];
        LoginingViewController *logingVC = [[LoginingViewController alloc] init];
        logingVC.delegate = self;
        [self.navigationController pushViewController:logingVC animated:YES];
    }
}
- (void)clickClassification{
    NSArray *classArr;
    if (_type.integerValue == 1) {
        classArr = [self getTheSamePidClassWithPid:_selectPid];
    } else {
        classArr = [self getTheSameSecPidClassWithThirdPid:_selectPid];
    }
    
    NSString *titleStr = [self getTheSameCartIdWithpid:_selectCartId];
    
//    _arrsecond = [NSMutableArray array];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:titleStr message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];//_strFirstName
    alert.tag = 1;
    for (NSDictionary *dic in classArr) {
        NSString *strlist;
        if (_type.integerValue == 1) {
            if ([[dic getStringValueForKey:@"cart_id" defaultValue:nil] isEqualToString:_selectCartId]) {
                strlist = [NSString stringWithFormat:@"   %@  √",[dic getStringValueForKey:@"cate_name" defaultValue:nil]];
            } else {
                strlist = [dic getStringValueForKey:@"cate_name" defaultValue:nil];
            }
        } else {
            if ([[dic getStringValueForKey:@"cart_id" defaultValue:nil] isEqualToString:_selectPid]) {
                strlist = [NSString stringWithFormat:@"   %@  √",[dic getStringValueForKey:@"cate_name" defaultValue:nil]];
            } else {
                strlist = [dic getStringValueForKey:@"cate_name" defaultValue:nil];
            }
        }
    [alert addButtonWithTitle:strlist];
    }
    [self startRequest:106];

    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1) {
        NSArray *classArr;
        if ([_type integerValue] == 1) {
            classArr = [self getTheSamePidClassWithPid:_selectPid];
        } else {
            classArr = [self getTheSameSecPidClassWithThirdPid:_selectPid];
        }
        if (buttonIndex != 0) {
            NSDictionary *dic = [classArr objectAtIndex:buttonIndex - 1];
            NSString *selectpid = [dic getStringValueForKey:@"cart_id" defaultValue:nil];
            _classThreeArr = [self getTheSamePidClassWithPid:selectpid];
            NSString *titleStr2 = [self getTheSameCartIdWithpid:selectpid];
            _selectPid = selectpid;
            if (_classThreeArr.count == 0) {
                _goods_idInt = [_selectPid integerValue];
                _selectCartId = selectpid;
//                _type = @"1";
                [_arrName removeAllObjects];
                [_arrPrice removeAllObjects];
                [_arrImage removeAllObjects];
                [_arroldPrice removeAllObjects];
                [_arr_goods_id removeAllObjects];
                _selectType = 0;
                _selectPage = 1;
                [self startRequest:101];
            } else {
//                _selectPid = selectpid;
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:titleStr2 message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];//_strFirstName
                alert.tag = 2;
                for (NSDictionary *dic in _classThreeArr) {
                    NSString *strlist;
                    if ([[dic getStringValueForKey:@"cart_id" defaultValue:nil] isEqualToString:_selectCartId]) {
                        strlist = [NSString stringWithFormat:@"   %@  √",[dic getStringValueForKey:@"cate_name" defaultValue:nil]];
                    } else {
                        strlist = [dic getStringValueForKey:@"cate_name" defaultValue:nil];
                    }

                    [alert addButtonWithTitle:strlist];
                    }
            [alert show];
            }
        }
    } else {
        //        TODO
        if (buttonIndex != 0) {
            NSDictionary *dic = [_classThreeArr objectAtIndex:buttonIndex - 1];
            NSString *selectPid = [dic getStringValueForKey:@"cart_id" defaultValue:nil];
            _selectCartId = selectPid;
            _goods_idInt = [selectPid integerValue];
            [_arrName removeAllObjects];
            [_arrPrice removeAllObjects];
            [_arrImage removeAllObjects];
            [_arroldPrice removeAllObjects];
            [_arr_goods_id removeAllObjects];
            _selectType = 0;
            _selectPage = 1;
            [self startRequest:101];
            _type = @"2";
        }
    }

}

//点击按钮按产品价格排序，从小到大
- (void)clickPrice{
    [_arrName removeAllObjects];
    [_arrPrice removeAllObjects];
    [_arrImage removeAllObjects];
    [_arroldPrice removeAllObjects];
    [_arr_goods_id removeAllObjects];
    _selectType = 1;
    _selectPage = 1;
    if (_flag == YES) {
        _sort_price = 2;
        _image2.image = [UIImage imageNamed:@"fenlei_ic_jgpx_press"];
        [self startRequest:104];
        _flag = NO;
    }else if(_flag == NO){
        _sort_price = 1;
        _image2.image = [UIImage imageNamed:@"fenlei_ic_rqpx_press"];
        [self startRequest:104];
        _flag = YES;
    }
}

//点击按钮按销量排序，从大到小
- (void)clickProductCount{
    [_arrName removeAllObjects];
    [_arrPrice removeAllObjects];
    [_arrImage removeAllObjects];
    [_arroldPrice removeAllObjects];
    [_arr_goods_id removeAllObjects];
    _selectType = 2;
    _selectPage = 1;
    if (_flag == YES) {
        _sort_sales = 1;
        _image3.image = [UIImage imageNamed:@"fenlei_ic_rqpx_press"];
        [self startRequest:105];
        _flag = NO;
    }else if(_flag == NO){
        _sort_sales = 2;
        _image3.image = [UIImage imageNamed:@"fenlei_ic_jgpx_press"];
        [self startRequest:105];
        _flag = YES;
    }
}

#pragma mark - Requests产品列表
- (BOOL)startRequest:(NSInteger)requestID{
    if ([super startRequest:requestID]) {
        if (requestID == 101) {
#warning page
            [_client productList:_goods_idInt searchselect:@"0" page:_selectPage];
        }else if (requestID == 102){
        //    [_client classificationList:[_cartidValue integerValue]];
            [_client classificationListDif:[_cartidValue integerValue]];
        }else if (requestID == 103){
            _goods_id = _goodsmodel.goods_id;
            _spec_id = [_goodsmodel.spec_id integerValue];
            _shop_id = [_goodsmodel.shop_id integerValue];
            _goods_name = _goodsmodel.goods_name;
            _goods_image = _goodsmodel.goods_image;
            _quantity = [_goodsmodel.quantity integerValue];
            [_client userAddShopcartWithGoodsId:(int)_goods_id sperId:(int)_spec_id shopId:(int)_shop_id goodsName:_goods_name goodsImg:_goods_image quantity:1];
        }else if (requestID == 104){
            _arr = nil;
#warning page
            [_client productList:_sort_price cate_id:_goods_idInt page:_selectPage];
        }else if (requestID == 105){
            _arr = nil;
#warning page
            [_client productListsales:_sort_sales cate_id:_goods_idInt page:_selectPage];
        }else if (requestID == 106){
            [_client classificationListDif:[_strcartId integerValue]];
        }else if (requestID == 107){
            [_client userGetCartNum];
        }else if (requestID == 108){
//            [_client classificationListDif:[_cartFirstId integerValue]];
            [_client classificationList:[_cartFirstId integerValue]];
        }
        return YES;
    }
    return NO;
}

- (BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result{
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 101) {
           
            _arr = [result getArrayForKey:@"data"];
            NSDictionary *paging = [result getDictionaryForKey:@"paging"];
            _totalCount = [paging getIntegerValueForKey:@"totalcount" defaultValue:0];

//            for (NSInteger i = 0; i < _arr.count; i ++) {
            for (NSDictionary * dict in _arr)  {
                ClassOfGoodsModel * item = [ClassOfGoodsModel objectWithDictionary:dict];
                [_allParameter addObject:item];
                _dic = [NSMutableDictionary dictionary];

                _strname = [dict objectForKey:@"goods_name"];
                _strimage = [dict objectForKey:@"goods_image"];
                _strprice = [dict getStringValueForKey:@"goods_price" defaultValue:nil];
                _stroldprice = [dict getStringValueForKey:@"old_price" defaultValue:nil];
                NSString * strcatename = [_dic getStringValueForKey:@"cate_name" defaultValue:nil];
                _strstok = [dict objectForKey:@"stock"];
                _strvirtal = [dict objectForKey:@"virtual_sales"];
                NSString * goods_id = [dict objectForKey:@"goods_id"];
                [_arr_goods_id addObject:goods_id];
                if ([_strimage hasPrefix:@"http"]) {
                    [_arrImage addObject:_strimage];
                } else {
                    NSString * stringImage = [NSString stringWithFormat:@"%@%@", DeFaultURL, _strimage];
                    [_arrImage addObject:stringImage];
                }
                [_arrName addObject:_strname];
                [_arrPrice addObject:_strprice];
                [_arroldPrice addObject:_stroldprice];
               
            }
            _loadMoreView.hasMoreData = [self hasMoreData];
                [self startRequest:102];
        }else if (sender.requestID == 102){
            _arrlist = [result getArrayForKey:@"data"];
            
            _arrNameList = [NSMutableArray array];
            _arr_p_idlist = [NSMutableArray array];
            _arrcartId = [NSMutableArray array];
            
            for (NSInteger j = 0; j < _arrlist.count; j ++) {
                _diclist = [NSMutableDictionary dictionary];
                _diclist = [_arrlist objectAtIndex:j];
                
                _strNameList = [_diclist getStringValueForKey:@"cate_name" defaultValue:nil];
                [_arrNameList addObject:_strNameList];

                _strcartId = [_diclist getStringValueForKey:@"cart_id" defaultValue:nil];
                [_arrcartId addObject:_strcartId];

            if (_cartidValue == _strcartId) {
                    //p_id = 0 获取cate_name名称及cate_id;
                    //cate_id等于下一级的p_id;
                NSString * str_id_list = [_diclist getStringValueForKey:@"cate_name" defaultValue:nil];
                [_arr_p_idlist addObject:str_id_list];
            }
        }
    }
        if (sender.requestID == 103){
            [self startRequest:107];
        }else if (sender.requestID == 104){
            _arr = [result getArrayForKey:@"data"];
            //取出产品名称、图片、新旧价格等
            for (NSInteger i = 0; i < _arr.count; i ++) {
                _dic = [NSMutableDictionary dictionary];
                _dic = [_arr objectAtIndex:i];
                //NSDictionary实例中解析字符串
                NSString * strname2 = [_dic getStringValueForKey:@"goods_name" defaultValue:nil];
                NSString * strimage2 = [_dic getStringValueForKey:@"goods_image" defaultValue:nil];
                NSString * strprice2 = [_dic getStringValueForKey:@"goods_price" defaultValue:nil];
                NSString * stroldprice2 = [_dic getStringValueForKey:@"old_price" defaultValue:nil];
                NSString * strcatename = [_dic getStringValueForKey:@"cate_name" defaultValue:nil];
                if ([strimage2 hasPrefix:@"http"]) {
                    [_arrImage addObject:strimage2];
                } else {
                    NSString * stringImage = [NSString stringWithFormat:@"%@%@", DeFaultURL, strimage2];
                    [_arrImage addObject:stringImage];
                }
                NSString * goods_id = [_dic objectForKey:@"goods_id"];
                [_arr_goods_id addObject:goods_id];
                [_arrName addObject:strname2];
                [_arrPrice addObject:strprice2];
                [_arroldPrice addObject:stroldprice2];
                _loadMoreView.hasMoreData = [self hasMoreData];
            }
        }else if (sender.requestID == 105){
            _arr = [result getArrayForKey:@"data"];
            //取出产品名称、图片、新旧价格等
            for (NSInteger i = 0; i < _arr.count; i ++) {
                _dic = [NSMutableDictionary dictionary];
                _dic = [_arr objectAtIndex:i];
                //NSDictionary实例中解析字符串
                NSString * strname3 = [_dic getStringValueForKey:@"goods_name" defaultValue:nil];
                NSString * strimage3 = [_dic getStringValueForKey:@"goods_image" defaultValue:nil];
                NSString * strprice3 = [_dic getStringValueForKey:@"goods_price" defaultValue:nil];
                NSString * stroldprice3 = [_dic getStringValueForKey:@"old_price" defaultValue:nil];
      //          _strcatename = [_dic getStringValueForKey:@"cate_name" defaultValue:nil];
                
                if ([strimage3 hasPrefix:@"http"]) {
                    [_arrImage addObject:strimage3];
                } else {
                    NSString * stringImage = [NSString stringWithFormat:@"%@%@", DeFaultURL, strimage3];
                    [_arrImage addObject:stringImage];
                }
                NSString * goods_id = [_dic objectForKey:@"goods_id"];
                [_arr_goods_id addObject:goods_id];
                [_arrName addObject:strname3];
                [_arrPrice addObject:strprice3];
                [_arroldPrice addObject:stroldprice3];
                _loadMoreView.hasMoreData = [self hasMoreData];
            }
        }else if (sender.requestID == 106){
            NSArray * arrcart = [result getArrayForKey:@"data"];
            for (NSInteger m = 0; m < arrcart.count; m++) {
                _dict = [NSMutableDictionary dictionary];
                _dict = [arrcart objectAtIndex:m];
//                NSString * thirdName = [_dict getStringValueForKey:@"cate_name" defaultValue:nil];
            }
        }else if (sender.requestID == 107){
            NSDictionary *data = [result getDictionaryForKey:@"data"];
            NSString *cartNum = [data getStringValueForKey:@"cart_number" defaultValue:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cartNum" object:nil userInfo:@{@"cartNum":cartNum}];
        }else if (sender.requestID == 108){
            NSArray * arr = [result getArrayForKey:@"data"];
//            NSDictionary * _dictd = [NSMutableDictionary dictionary];
            for (NSInteger m = 0; m < arr.count; m++) {
                
                NSDictionary * _dictd = [arr objectAtIndex:m];
                NSString * strddd = [_dictd getStringValueForKey:@"cate_name" defaultValue:nil];
            }
        }
        //刷新页面,使当前页面加载新数据;
        [_tableView reloadData];
        
        return YES;
    }
    return NO;
}
- (void)backToPerCenVCWithInfo:(NSDictionary *)info{
}


/**
 * 获取pid相同的分类
 */
-(NSArray *)getTheSamePidClassWithPid:(NSString *)pid {
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in _classArray) {
        NSString *pidStr = [dic getStringValueForKey:@"p_id" defaultValue:nil];
        if ([pidStr isEqualToString:pid]) {
            [arr addObject:dic];
        }
    }
    return arr;
}

-(NSString *)getTheSameCartIdWithpid:(NSString *)pid {
    for (NSDictionary *dic in _classArray) {
        NSString *cartIdStr = [dic getStringValueForKey:@"cart_id" defaultValue:nil];
        if ([cartIdStr isEqualToString:pid]) {
//            return cartIdStr;
            return [dic getStringValueForKey:@"cate_name" defaultValue:nil];
        }
    }
    return nil;
}

/**
 * 根据三级分类的pid获取二级相同的pid分类
 */
-(NSArray *)getTheSameSecPidClassWithThirdPid:(NSString *)pid {
    NSMutableArray *arr = [NSMutableArray array];
    NSString *secPid;
    for (NSDictionary *dic in _classArray) {
        NSString *cartIdStr = [dic getStringValueForKey:@"cart_id" defaultValue:nil];
        if ([cartIdStr isEqualToString:pid]) {
            secPid = [dic getStringValueForKey:@"p_id" defaultValue:nil];
            break;
        }
    }
    for (NSDictionary *dic in _classArray) {
        NSString *pidStr = [dic getStringValueForKey:@"p_id" defaultValue:nil];
        if ([secPid isEqualToString:pidStr]) {
            [arr addObject:dic];
        }
    }
    return arr;
}

- (BOOL)hasMoreData {
    return _arrName.count < _totalCount;
}

- (void)loadMoreViewDidLoad:(id)sender {
    _selectPage ++;
    _needLoadingHUD = YES;
    if (_selectType == 1) {
        [self startRequest:104];
    } else if (_selectType == 2) {
        [self startRequest:105];
    } else {
        [self startRequest:101];
    }
    
}

@end
