//
//  SearchResultViewController.m
//  IOSProject
//
//  Created by IOS004 on 15/7/13.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "SearchResultViewController.h"
#import "CommodityViewController.h"
#import "SearchPageViewController.h"
#import "SearchCartSuccessModel.h"
#import "SearchJoinCartCell.h"
#import "LoginingViewController.h"

@interface SearchResultViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,searchbarDelegate,logInDelegate>{
    NSArray * _searchData; //保存搜索结果数据的NSArray对象
    NSArray * _tableData;  //保存原始数据表格的NSArray对象
    BOOL _isSearch;
    BOOL _flag;
    NSMutableArray * _arr_p_idlist; //父类为0，数组取出名称
    NSArray        * _arr;         //产品列表;
    NSMutableArray * _arrName;     //商品名称;
    NSMutableArray * _arrImage;    //商品图片;
    NSMutableArray * _arrPrice;    //商品价格;
    NSMutableArray * _arroldPrice; //商品旧价格
    NSMutableArray * _arr_goods_id;
    UILabel * _titlelab;
    NSString       * _strname;     //字符串
    NSString       * _strimage;
    NSString       * _strprice;
    NSString       * _stroldprice;
    NSInteger        _sort_price;
    NSInteger        _sort_sales;
    NSInteger        _cate_id;
    NSMutableDictionary * _dic;
    NSString * _select;            //传参，搜索内容
    NSString * _strstok;
    NSString * _strvirtal;
    UIImageView * _imagebtn;
    UIButton * _sortingbtn1;
    UIButton * _sortingbtn2;
    UIButton * _sortingbtn3;
    UIImageView * _image3;
    UIImageView * _image2;
    //加入购物车所需参数
    NSInteger   _goods_id;     //产品id
    NSInteger   _spec_id;      //规格id
    NSInteger   _shop_id;      //商品id
    NSString  * _goods_name;   //产品名
    NSString  * _goods_image;  //产品图片
    NSInteger   _quantity;     //数量
    
    SearchCartSuccessModel * _searchmodel;
    NSMutableArray * _searchArr;
    NSInteger _strValue;
//    页数
    NSInteger _selectPage;
//    总数
    NSInteger _totalCount;
    NSInteger _type;
    
//
    NSMutableArray *_cateIdList;
//    分类cate_id
    NSString *_selectCate_id;
}

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButtonToNavigation];
    _selectCate_id = @"0";
    _selectPage = 1;
     [self addLoadMoreView];
    _searchArr = [NSMutableArray array];
    _arrName = [NSMutableArray array];
    _arrImage = [NSMutableArray array];
    _arrPrice = [NSMutableArray array];
    _arroldPrice = [NSMutableArray array];
    _arr_goods_id = [NSMutableArray array];
    
    _cateIdList = [NSMutableArray array];
    
    UIButton * searchbtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, self.view.width - 80, 30)];
    searchbtn.backgroundColor = [UIColor colorFromHexCode:@"Color_bkg_green"];
    searchbtn.layer.masksToBounds = YES;
    [searchbtn.layer setCornerRadius:searchbtn.height / 5.0];
    [searchbtn addTarget:self action:@selector(returnPopPage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = searchbtn;
    UILabel * resultlab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 30)];
    resultlab.text = selecet;
    [searchbtn addSubview:resultlab];
    
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 20, 20)];
    lab.backgroundColor = [UIColor clearColor];
    UIBarButtonItem * rightlab = [[UIBarButtonItem alloc] initWithCustomView:lab];
    self.navigationItem.rightBarButtonItem = rightlab;
    
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
    
    UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 50, 50)];
    UILabel * lab2 = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 50, 50)];
    UILabel * lab3 = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 50, 50)];
    lab1.text = @"分类";
    lab2.text = @"价格";
    lab3.text = @"销量";
    lab1.textColor = [UIColor colorFromHexCode:@"#757575"];
    lab2.textColor = [UIColor colorFromHexCode:@"#757575"];
    lab3.textColor = [UIColor colorFromHexCode:@"#757575"];
    lab1.font = [UIFont systemFontOfSize:18];
    lab2.font = [UIFont systemFontOfSize:18];
    lab3.font = [UIFont systemFontOfSize:18];
    [_sortingbtn1 addSubview:lab1];
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
    _isSearch = NO;

    _select = selecet;
    [self startRequest:101];
    _strValue = [_strSelect integerValue];
//    if(_strValue == 0) {
//        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
//        image.backgroundColor = [UIColor whiteColor];
//        [self.view addSubview:image];
//        UIImageView * imageCol = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
//        imageCol.backgroundColor = [UIColor colorFromHexCode:@"Color_bkg_green"];
//        [image addSubview:imageCol];
//        
//        UIImageView * noSearch = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width / 2 - 62.5, 138, 125, 125)];
//        noSearch.image = [UIImage imageNamed:@"search_pic"];
//        [image addSubview:noSearch];
//        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width / 2 - 85, 290, 170, 30)];
//        lab.text = @"抱歉，没找到相关商品";
//        lab.textColor = [UIColor colorFromHexCode:@"#b3b3b3"];
//        [image addSubview:lab];
//    }
}

/**
 *有多少个sections
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrName.count;
}

/**
 * 每个section有多少个cell
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"identifier";
    SearchCartSuccessModel * model = [_searchArr objectAtIndex:indexPath.row];
    SearchJoinCartCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[SearchJoinCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else
        [cell cleanUpSubviews];
    cell.item = model;
    cell.delegate = self;
    cell.backgroundColor = [UIColor clearColor];
    
        for (NSInteger i = 0; i < _arrName.count; i ++) {
            NSArray * arr = @[@"#ff0000",@"#757575"];
            
            if (indexPath.section == i) {
                if (indexPath.row == 0) {

                    UIImageView * logoimage = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 75, 75)];
                    [logoimage setImageWithURL:_arrImage[i]];
                    [cell.contentView addSubview:logoimage];
                    
                    UILabel * titlelab = [[UILabel alloc] initWithFrame:CGRectMake(115, 10, 200, 20)];
                    titlelab.text = _arrName[i];
                    titlelab.textColor = [UIColor colorFromHexCode:@"#333333"];
                    titlelab.font = [UIFont systemFontOfSize:18];
                    [cell.contentView addSubview:titlelab];
                    
                    NSString *salePri = _arrPrice[i];
                    NSString *oldPri  = _arroldPrice[i];
                    
                    UILabel * moneylab = [[UILabel alloc] initWithFrame:CGRectMake(125, 60, 100, 20)];
                    moneylab.text = _arrPrice[i];
                    moneylab.font = [UIFont systemFontOfSize:13];
                    moneylab.textColor = [UIColor colorFromHexCode:@"#ff0000"];
                    [cell.contentView addSubview:moneylab];
                    
                    if (salePri.floatValue != oldPri.floatValue) {
                        UILabel * oldlab = [[UILabel alloc] initWithFrame:CGRectMake(185, 60, 100, 20)];
                        oldlab.text = _arroldPrice[i];
                        oldlab.font = [UIFont systemFontOfSize:11];
                        oldlab.textColor = [UIColor colorFromHexCode:@"#757575"];
                        [cell.contentView addSubview:oldlab];
                        
                        UIImageView * imageline = [[UIImageView alloc] initWithFrame:CGRectMake(175, 70, 40, 1)];
                        imageline.backgroundColor = [UIColor colorFromHexCode:@"#757575"];
                        [cell.contentView addSubview:imageline];
                    }
                    
                    for (NSInteger j = 0; j < 2; j ++) {
                        
                        UILabel * symbollab = [[UILabel alloc] initWithFrame:CGRectMake(115 + (60 * j), 60, 20, 20)];
                        symbollab.text = @"￥";
                        if (j == 0)
                            symbollab.font = [UIFont systemFontOfSize:13];
                        if (j == 1) {
                            symbollab.font = [UIFont systemFontOfSize:11];
                            if (salePri.floatValue == oldPri.floatValue) {
                                symbollab.hidden = YES;
                            } else {
                                symbollab.hidden = NO;
                            }
                        }
                        
                        symbollab.textColor = [UIColor colorFromHexCode:arr[j]];
                        [cell.contentView addSubview:symbollab];
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
        return 8;
    }
}

/**
 *cell的点击事件
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CommodityViewController * commodity = [[CommodityViewController alloc] init];
    
    NSString * str123 = [_arr_goods_id objectAtIndex:indexPath.section];
    commodity.strgoods_id = str123;
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

/**
 *点击分类栏
 */
- (void)clickClassification{
    _type = 0;
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"选择分类" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
    for (NSInteger k = 0; k < _arr_p_idlist.count; k ++) {
        NSString * strlist = [[NSString alloc] initWithFormat:@"%@",[_arr_p_idlist objectAtIndex:k]];
        [alert addButtonWithTitle:strlist];
    }
    [alert show];
}
//点击事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    NSString * msg = [[NSString alloc] initWithFormat:@"%ld",(long)buttonIndex];
    if (buttonIndex != 0) {
        [_arr_goods_id removeAllObjects];
        [_arrName removeAllObjects];
        [_arrPrice removeAllObjects];
        [_arrImage removeAllObjects];
        [_arroldPrice removeAllObjects];
        _selectCate_id = [_cateIdList objectAtIndex:buttonIndex - 1];
        _select = @"0";
        _selectPage = 1;
        [self startRequest:101];
//        NSString *str = [_arr_p_idlist objectAtIndex:buttonIndex - 1];
//        _select = str;
//        _selectPage = 1;
//        [self startRequest:101];
//        NSString *selectpid = [dic getStringValueForKey:@"cart_id" defaultValue:nil];
////        _classThreeArr = [self getTheSamePidClassWithPid:selectpid];
//        NSString *titleStr2 = [self getTheSameCartIdWithpid:selectpid];
//        _selectPid = selectpid;
    }
}

//点击按钮按产品价格排序，从小到大
- (void)clickPrice{
    [_arr_goods_id removeAllObjects];
    [_arrName removeAllObjects];
    [_arrImage removeAllObjects];
    [_arrPrice removeAllObjects];
    [_arroldPrice removeAllObjects];
    _type = 1;
    _selectPage = 1;
    if (_flag == YES) {
        _sort_price = 2;
        _image2.image = [UIImage imageNamed:@"fenlei_ic_jgpx_press"];
        [self startRequest:103];
        _flag = NO;
    }else if(_flag == NO){
        _sort_price = 1;
        _image2.image = [UIImage imageNamed:@"fenlei_ic_rqpx_press"];
        [self startRequest:103];
        _flag = YES;
    }
}

//点击按钮按销量排序，从大到小
- (void)clickProductCount{
    [_arr_goods_id removeAllObjects];
    [_arrName removeAllObjects];
    [_arrImage removeAllObjects];
    [_arrPrice removeAllObjects];
    [_arroldPrice removeAllObjects];
    _type = 2;
    _selectPage = 1;
    if (_flag == YES) {
        _sort_sales = 1;
        _image3.image = [UIImage imageNamed:@"fenlei_ic_rqpx_press"];
        [self startRequest:104];
        _flag = NO;
    }else if(_flag == NO){
        _sort_sales = 2;
        _image3.image = [UIImage imageNamed:@"fenlei_ic_jgpx_press"];
        [self startRequest:104];
        _flag = YES;
    }
}

- (void)searchJoinSuccess:(SearchJoinCartCell *)cell{
    if ([IEngine engine].isSignedIn) {
        NSIndexPath * index = [_tableView indexPathForCell:cell];
        
        _searchmodel = [_searchArr objectAtIndex:index.section];
        [self startRequest:102];
        [CCAlertView showText:@"加入购物车成功" life:1.0];
    }else{
        [CCAlertView showText:@"请登录" life:2.0];
        LoginingViewController *logingVC = [[LoginingViewController alloc] init];
        logingVC.delegate = self;
        [self.navigationController pushViewController:logingVC animated:YES];
    }
}
- (void)returnPopPage{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Requests产品列表
- (BOOL)startRequest:(NSInteger)requestID{
    if ([super startRequest:requestID]) {
        if (requestID == 101) {
//            [_client productListselect:_select];
#warning page
            [_client productList:_selectCate_id.integerValue searchselect:_select page:_selectPage];
        }else if (requestID == 102){
            _goods_id = _searchmodel.goods_id;
            _spec_id = [_searchmodel.spec_id integerValue];
            _shop_id = [_searchmodel.shop_id integerValue];
            _goods_image = _searchmodel.goods_image;
            _goods_name = _searchmodel.goods_name;
            [_client userAddShopcartWithGoodsId:(int)_goods_id sperId:(int)_spec_id shopId:(int)_shop_id goodsName:_goods_name goodsImg:_goods_image quantity:1];
        }else if (requestID == 103){
            _arr = nil;
#warning page
            [_client productListselect:_select price:_sort_price page:1];
        }else if (requestID == 104){
            _arr = nil;
#warning page
            [_client productListselect:_select sales:_sort_sales page:1];
        }else if (requestID == 105){
            [_client userGetCartNum];
        } else if (requestID == 106) {
            [_client classificationListDif:[_selectCate_id integerValue]];
        }
        return YES;
    }
    return NO;
}

- (BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result{
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 101) {
            NSDictionary *paging = [result getDictionaryForKey:@"paging"];
            _totalCount = [paging getIntegerValueForKey:@"totalcount" defaultValue:0];
            _arr = [result getArrayForKey:@"data"];
            _arr_p_idlist = [NSMutableArray array];
      //      for (NSInteger i = 0; i < _arr.count; i ++) {
            for (NSDictionary * dict in _arr) {
                SearchCartSuccessModel * item = [SearchCartSuccessModel objectWithDictionary:dict];
                [_searchArr addObject:item];
                _dic = [NSMutableDictionary dictionary];
          //      _dic = [_arr objectAtIndex:i];
                //NSDictionary实例中解析字符串
                _strname = [dict getStringValueForKey:@"goods_name" defaultValue:nil];
                _strimage = [dict getStringValueForKey:@"goods_image" defaultValue:nil];
                _strprice = [dict getStringValueForKey:@"goods_price" defaultValue:nil];
                _stroldprice = [dict getStringValueForKey:@"old_price" defaultValue:nil];
                NSString * strcartid = [dict getStringValueForKey:@"cate_name" defaultValue:nil];
                NSString * strgoods_id = [dict getStringValueForKey:@"goods_id" defaultValue:nil];
                NSString * strcate_id = [dict getStringValueForKey:@"cate_id" defaultValue:nil];
//                NSMutableArray * arrlist = [[NSMutableArray alloc] init];
//                [arrlist addObject:strcartid];
                if (_cateIdList.count == 0) {
                    [_cateIdList addObject:strcate_id];
                    [_arr_p_idlist addObject:strcartid];
                } else {
                    for (int i = 0; i < _cateIdList.count; i ++) {
                        if (![_cateIdList containsObject:strcate_id]) {
                            [_cateIdList addObject:strcate_id];
                            [_arr_p_idlist addObject:strcartid];
                        }
                        
                        
                    }
                }
                //去重
//                for (NSInteger i = 0; i < arrlist.count; i ++) {
//                    if ([_arr_p_idlist containsObject:[arrlist objectAtIndex:i]] == NO) {
//                        [_arr_p_idlist addObject:[arrlist objectAtIndex:i]];
//                    }
//                }
                [_arr_goods_id addObject:strgoods_id];
                _strstok = [dict objectForKey:@"stock"];
                _strvirtal = [dict objectForKey:@"virtal_sales"];
                if ([_strimage hasPrefix:@"http"]) {
                    [_arrImage addObject:_strimage];
                } else {
                    NSString * stringImage = [NSString stringWithFormat:@"%@%@", DeFaultURL, _strimage];
                    [_arrImage addObject:stringImage];
                }
                [_arrName addObject:_strname];
                [_arrPrice addObject:_strprice];
                [_arroldPrice addObject:_stroldprice];
                _loadMoreView.hasMoreData = [self hasMoreData];
            }
        }else if (sender.requestID == 102){
       //     UIAlertView * alart = [[UIAlertView alloc] initWithTitle:@"加入购物车成功" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
       //     [alart show];
            [self startRequest:105];
        }else if (sender.requestID == 103){
            _arr = [result getArrayForKey:@"data"];
            NSDictionary *paging = [result getDictionaryForKey:@"paging"];
            _totalCount = [paging getIntegerValueForKey:@"totalcount" defaultValue:0];
            for (NSInteger i = 0; i < _arr.count; i ++) {
                _dic = [NSMutableDictionary dictionary];
                _dic = [_arr objectAtIndex:i];
                //NSDictionary实例中解析字符串
                _strname = [_dic getStringValueForKey:@"goods_name" defaultValue:nil];
                _strimage = [_dic getStringValueForKey:@"goods_image" defaultValue:nil];
                _strprice = [_dic getStringValueForKey:@"goods_price" defaultValue:nil];
                _stroldprice = [_dic getStringValueForKey:@"old_price" defaultValue:nil];
                NSString * strgoods_id = [_dic getStringValueForKey:@"goods_id" defaultValue:nil];
                if ([_strimage hasPrefix:@"http"]) {
                [_arrImage addObject:_strimage];
                } else {
                   NSString * stringImage = [NSString stringWithFormat:@"%@%@", DeFaultURL, _strimage];
                    [_arrImage addObject:stringImage];
                }
                [_arr_goods_id addObject:strgoods_id];
                [_arrName addObject:_strname];
                [_arrPrice addObject:_strprice];
                [_arroldPrice addObject:_stroldprice];
                _loadMoreView.hasMoreData = [self hasMoreData];
            }
        }else if (sender.requestID == 104){
            _arr = [result getArrayForKey:@"data"];
            NSDictionary *paging = [result getDictionaryForKey:@"paging"];
            _totalCount = [paging getIntegerValueForKey:@"totalcount" defaultValue:0];
            for (NSInteger i = 0; i < _arr.count; i ++) {
                _dic = [NSMutableDictionary dictionary];
                _dic = [_arr objectAtIndex:i];
                //NSDictionary实例中解析字符串
                _strname = [_dic getStringValueForKey:@"goods_name" defaultValue:nil];
                _strimage = [_dic getStringValueForKey:@"goods_image" defaultValue:nil];
                _strprice = [_dic getStringValueForKey:@"goods_price" defaultValue:nil];
                _stroldprice = [_dic getStringValueForKey:@"old_price" defaultValue:nil];
                 NSString * strgoods_id = [_dic getStringValueForKey:@"goods_id" defaultValue:nil];
                if ([_strimage hasPrefix:@"http"]) {
                    [_arrImage addObject:_strimage];
                } else {
                    NSString * stringImage = [NSString stringWithFormat:@"%@%@", DeFaultURL, _strimage];
                    [_arrImage addObject:stringImage];
                }
                [_arr_goods_id addObject:strgoods_id];
                [_arrName addObject:_strname];
                [_arrPrice addObject:_strprice];
                [_arroldPrice addObject:_stroldprice];
                _loadMoreView.hasMoreData = [self hasMoreData];
            }
        }else if (sender.requestID == 105){
            NSDictionary *data = [result getDictionaryForKey:@"data"];
            NSString *cartNum = [data getStringValueForKey:@"cart_number" defaultValue:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cartNum" object:nil userInfo:@{@"cartNum":cartNum}];
        } else if (sender.requestID == 106) {
            
        }
        //刷新页面,使当前页面加载新数据;
        [_tableView reloadData];
        return YES;
    }
    return NO;
}

- (BOOL)hasMoreData {
    return _arrName.count < _totalCount;
}

- (void)loadMoreViewDidLoad:(id)sender {
    _selectPage ++;
    _needLoadingHUD = YES;
    if (_type == 1) {
        [self startRequest:103];
    } else if (_type == 2) {
        [self startRequest:104];
    } else {
        [self startRequest:101];
    }
}
@end
