//
//  SearchPageViewController.m
//  IOSProject
//
//  Created by IOS002 on 15/6/4.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//
//
//  搜索页
 

#import "SearchPageViewController.h"
#import "SearchResultViewController.h"
#import "CommodityViewController.h"

@interface SearchPageViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>{
    NSArray     * _searchData; //保存搜索结果数据的NSArray对象
    NSArray     * _tableData;  //保存原始数据表格的NSArray对象
    NSArray * _arrdata;
    BOOL          _isSearch;
    UISearchBar * _searchBar;
        NSMutableArray * _arr_p_idlist; //父类为0，数组取出名称
    NSArray        * _arr;         //产品列表;
    NSMutableArray * _arrName;     //商品名称;
    NSMutableArray * _arrImage;    //商品图片;
    NSMutableArray * _arrPrice;    //商品价格;
    NSMutableArray * _arroldPrice; //商品旧价格
    NSMutableArray * _arr_goods_id;
    NSString * _strgoodsid;
    UILabel * _titlelab;
    NSString       * _strname;     //字符串
    NSString       * _strimage;
    NSString       * _strprice;
    NSString       * _stroldprice;
    NSInteger        _sort_price;
    NSInteger        _sort_sales;
    NSInteger        _cate_id;
    NSMutableDictionary * _dic;
    NSString * _select;
    NSString * _strstok;
    NSString * _strvirtal;
    UIImageView * _imageView;
    UILabel * _lab;
    NSInteger _selectPage;
}

@end

NSString * selecet = @"";

@implementation SearchPageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButtonToNavigation];
    _selectPage = 1;
    [self startRequest:101];
    
    _isSearch = NO;
//  创建搜索栏
    _searchBar = [[UISearchBar alloc] init];
//    [searchBar setSearchResultsButtonSelected:NO];
    _searchBar.placeholder = @"搜索你想找的商品";
    _searchBar.autocorrectionType = UITextAutocorrectionTypeYes;
    _searchBar.searchBarStyle = UITextBorderStyleBezel;
    self.navigationItem.titleView = _searchBar;
    /**
     添加背景色；
     */
    UIImageView * screenImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    screenImage.backgroundColor = [UIColor colorFromHexCode:@"Color_bkg_green"];
    [self.view addSubview:screenImage];
    /**
     添加rightbarbutton
     */
    UIButton * rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setTitle:@"搜索" forState:UIControlStateNormal];
    [rightbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightbtn.frame = CGRectMake(10, 0, 50, 20);
    [rightbtn addTarget:self action:@selector(searchResult) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width/2 - 62.5, 138, 125, 125)];
    _imageView.image = [UIImage imageNamed:@"search_pic"];
    [self.view addSubview:_imageView];
    
    _lab = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width/2 - 80, 300, 200, 30)];
    _lab.text = @"赶紧搜索想找的商品吧";
    _lab.textColor = [UIColor colorFromHexCode:@"#b3b3b3"];
    [self.view addSubview:_lab];
    
    _searchBar.delegate = self;
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //获取当前处理表格行的行号
    NSInteger rowNo = indexPath.row;
    
    for (NSInteger i = 0; i < _arrName.count; i ++) {

        if (_isSearch) {
            cell.textLabel.text = [_searchData objectAtIndex:rowNo];
        }
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //如果处于搜索状态
    if (_isSearch) {
        return _searchData.count;
    }else{
        return 0;
    }
}


/**
 *cell的点击事件
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CommodityViewController * commodity = [[CommodityViewController alloc] init];
    NSString *str = [_searchData objectAtIndex:indexPath.row];
    NSInteger selectRow = [_arrName indexOfObject:str];
    NSString * strgoods = [_arr_goods_id objectAtIndex:selectRow];
    commodity.strgoods_id = strgoods;
    [self.navigationController pushViewController:commodity animated:YES];
}

/**
 * 当搜索文本框内容发生改变时激发该状态
 */
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self filterBySubstring:searchText];
    if (searchText.length != 0) {
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
  //      image.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:image];
    }else if (searchText.length == 0){
        selecet = nil;
    }
    _imageView.image = nil;
    _lab.text = nil;
    selecet = searchText;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self filterBySubstring:searchBar.text];
    [searchBar resignFirstResponder];
    //搜索为空提示信息，else，跳转搜索结果
//    if ([selecet isEqual: @""]) {
//        [CCAlertView showText:@"请输入搜索内容" life:1.0];
//    }else{
        SearchResultViewController * searchresult = [[SearchResultViewController alloc] init];
        NSString * str = [NSString stringWithFormat:@"%ld",_searchData.count];
        searchresult.strSelect = str;
        [self.navigationController pushViewController:searchresult animated:YES];
//    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    _isSearch = NO;
    [_tableView reloadData];
}

- (void)filterBySubstring:(NSString *)substr{
    //设置为搜索状态
    _isSearch = YES;
    //定义搜索谓词
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",substr];
    //使用谓词过滤NSArray
    _searchData = [_arrName filteredArrayUsingPredicate:pred];
    [_tableView reloadData];
}

- (void)searchResult{
    //搜索为空提示信息，else，跳转搜索结果
//    if ([selecet isEqual: @""]) {
//        [CCAlertView showText:@"请输入搜索内容" life:1.0];
//    }else{
    SearchResultViewController * searchresult = [[SearchResultViewController alloc] init];
    NSString * str = [NSString stringWithFormat:@"%ld",_searchData.count];
    searchresult.strSelect = str;
    [self.navigationController pushViewController:searchresult animated:YES];
//    }
}

/**
 跳转到搜索界面
 */
- (void)searchButtonAction{
    SearchPageViewController * searchPage = [[SearchPageViewController alloc] init];
    [self.navigationController pushViewController:searchPage animated:YES];
}

/**
 *提示框，加入购物车成功
 */
- (void)joinCartSuccess{
    UIAlertView * alart = [[UIAlertView alloc] initWithTitle:@"加入购物车成功" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alart show];
}

/**
 *点击分类栏
 */
- (void)clickClassification{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"选则分类" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
    for (NSInteger k = 0; k < _arr_p_idlist.count; k ++) {
        NSString * strlist = [[NSString alloc] initWithFormat:@"%@",[_arr_p_idlist objectAtIndex:k]];
        [alert addButtonWithTitle:strlist];
    }
    [alert show];
}

//点击按钮按产品价格排序，从小到大
- (void)clickPrice{
    _sort_sales = 2;
    [self startRequest:101];
}

//点击按钮按销量排序，从大到小
- (void)clickProductCount{
    _sort_price = 1;
    [self startRequest:101];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Requests产品列表
- (BOOL)startRequest:(NSInteger)requestID{
    if ([super startRequest:requestID]) {
        if (requestID == 101) {
            _select = selecet;
#warning page
            [_client productList:0 searchselect:_select page:1];
     //       [_client productListselect:_select];
        }else if (requestID == 102){
   //         [_client classificationList:_intp_listid];
        }
        return YES;
    }
    return NO;
}

- (BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result{
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 101) {
            _arr = [result getArrayForKey:@"data"];
            _arrName = [NSMutableArray array];
            _arrImage = [NSMutableArray array];
            _arrPrice = [NSMutableArray array];
            _arroldPrice = [NSMutableArray array];
            _arr_goods_id = [NSMutableArray array];
            
            //取出产品名称、图片、新旧价格等
            for (NSInteger i = 0; i < _arr.count; i ++) {
                _dic = [NSMutableDictionary dictionary];
                _dic = [_arr objectAtIndex:i];
                //NSDictionary实例中解析字符串
                _strname = [_dic getStringValueForKey:@"goods_name" defaultValue:nil];
                _strimage = [_dic getStringValueForKey:@"goods_image" defaultValue:nil];
                _strprice = [_dic getStringValueForKey:@"goods_price" defaultValue:nil];
                _stroldprice = [_dic getStringValueForKey:@"old_price" defaultValue:nil];
                NSString * strcatename = [_dic getStringValueForKey:@"cate_name" defaultValue:nil];
                _strgoodsid = [_dic getStringValueForKey:@"goods_id" defaultValue:nil];
                _strstok = [_dic objectForKey:@"stock"];
                _strvirtal = [_dic objectForKey:@"virtal_sales"];
                [_arr_goods_id addObject:_strgoodsid];
                [_arrName addObject:_strname];
                [_arrImage addObject:_strimage];
                [_arrPrice addObject:_strprice];
                [_arroldPrice addObject:_stroldprice];
            }
        }
        //刷新页面,使当前页面加载新数据;
        [_tableView reloadData];
        return YES;
    }
    return NO;
}

@end
