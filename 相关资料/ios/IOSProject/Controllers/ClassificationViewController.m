//
//  ClassificationViewController.m
//  IOSProject
//
//  Created by IOS002 on 15/5/30.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "ClassificationViewController.h"
#import "ClassficationTableViewCell.h"
#import "ClassficationTableView.h"
#import "RightTableView.h"
#import "RightTableViewCell.h"
#import "SearchPageViewController.h"
#import "HomeViewController.h"
#import "MsgCenViewController.h"
#import "ClassificationOfGoodsViewController.h"

@interface ClassificationViewController ()<ClassficationTableViewDelegate,RightTableViewDelegate,RightTableViewcellDelegate,classificationDelegate,UITableViewDataSource,UITableViewDelegate,classficationDelegate>{
    ClassficationTableView * _ficationclasstableview;
    NSMutableArray * _arrimage;
    NSMutableArray * _arrname;
    NSString * _strimage;
    NSString * _strname;
    //一级栏
    NSMutableArray * _arrNameList1;
    NSMutableArray * _arrImageList1;
    NSMutableArray * _arrcartidList1;
    //二级栏
    NSMutableArray * _arrNameList2;
    NSMutableArray * _arrImageList2;
    NSMutableArray * _arrcartidList2;
    
    NSMutableArray * _arrNameList4;
    //三级栏
    NSMutableArray * _arrNameList3;
    NSMutableArray * _arrcartidList3;
    //
    NSInteger _int_p_idValue;
    NSArray * _arrlist;
    NSMutableDictionary * _dic;
    NSMutableDictionary * _dict;
    NSString * _str123;
    
        NSArray * _arrNameClass;
    NSMutableDictionary * _dic1;
    NSMutableDictionary * _dic2;
    NSMutableDictionary * _dic3;
    NSMutableDictionary * _dic4;
    
    NSArray * tryagain;
    NSArray * tryimage;
    
    NSString * _str_cartid;
    NSString * _str_cartid2;
    NSInteger _intNameId;
    NSString * _str_p_id;
    
    NSString *_cartID1;
//    一级分类数组
    NSMutableArray *_classOneArr;
//    二级分类数组
    NSMutableArray *_classTwoArr;
//    三级分类数组
    NSMutableArray *_classThrArr;
    NSString * _cart_idCell;
    NSArray * _result;
    NSString * _p_idSection;
    NSString * _p_idName;
    NSString * _p_idCell;
    NSString * _p_idNameSection;
    NSString * _firstName;
    NSInteger _error;
    NSMutableDictionary * _dictionary;
    NSString * _idName;
}

@property (nonatomic ,strong) ClassficationTableView * classtableview;
@property (nonatomic ,strong) NSMutableArray         * dockArray;
@property (nonatomic ,strong) NSMutableArray         * offsArray;
@property (nonatomic ,strong) RightTableView         * rightTableView;
@property (nonatomic ,strong) RightTableViewCell     * rightTableViewcell;

@end

NSString * strName = @"";
NSString * strImage = @"";

@implementation ClassificationViewController

- (id)init{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     * 设置navigationItem；
     */
    UIButton * leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
    leftbtn.frame = CGRectMake(10, 0, 20, 20);
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIButton * rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setBackgroundImage:[UIImage imageNamed:@"iSH_Message"] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(rightBtnMessage) forControlEvents:UIControlEventTouchUpInside];
    rightbtn.frame = CGRectMake(10, 0, 20, 20);
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    UIButton * searchbtn = [[UIButton alloc] init];
    [searchbtn setBackgroundImage:[UIImage imageNamed:@"search__@3x"] forState:UIControlStateNormal];
    [searchbtn addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    searchbtn.frame = CGRectMake(50, 10, 200, 30);
    self.navigationItem.titleView = searchbtn;
    _dockArray = [NSMutableArray array];
    
    if (_error == 1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"你似乎与网络断开连接" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    } else {
    
/**
 * 一级菜单栏
 */
    _ficationclasstableview = [[ClassficationTableView alloc] initWithFrame:CGRectMake(0, 0, 75, [[UIScreen mainScreen] bounds].size.height - 115)];
    _ficationclasstableview.rowHeight = 75;
    _ficationclasstableview.classDelegate = self;
    _ficationclasstableview.backgroundColor = [UIColor colorFromHexCode:@"#ececec"];
    //    [_ficationclasstableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_ficationclasstableview];
    _classtableview = _ficationclasstableview;
    _ficationclasstableview.dockarr = _dockArray;
    
    //一级栏设置分割线
    for (NSInteger i = 0; i < _arrNameList1.count - 1; i ++) {
        
        UIImageView * imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 74 + (75 * i), 75, 1)];
        imageline.backgroundColor = [UIColor colorFromHexCode:@"dededd"];
        [_ficationclasstableview addSubview:imageline];
    }
/**
 * 二级菜单栏
 */
    RightTableView * rightTableView = [[RightTableView alloc] initWithFrame:CGRectMake(74, 0, self.view.width - 75, [[UIScreen mainScreen] bounds].size.height - 120)];
//    rightTableView.rowHeight = 40;
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    rightTableView.rightDelegate = self;
    rightTableView.backgroundColor = [UIColor colorFromHexCode:@"#f8f8f8"];
    [rightTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:rightTableView];
    _rightTableView = rightTableView;
    
    _dockArray = [NSMutableArray array];
    _classTwoArr = [NSMutableArray array];
    _classThrArr = [NSMutableArray array];
    
    //一级栏目有30个，具体数据后台上传i = ？;
    for (NSInteger i = 0; i < _arrNameList1.count; i++) {
       if (i) {
           [self startRequest:101];
            _dic = [NSMutableDictionary dictionary];
            _firstName = [_arrNameList1 objectAtIndex:i];
            NSMutableArray * arr = [NSMutableArray array];
            //二级栏目有30个，具体数据后台上传j = ？;
           for (NSInteger j = 0; j < _arrNameList2.count; j ++) {
               
                if (j == 0) {
                    _dictionary = [NSMutableDictionary dictionary];
                    _dictionary = [@{@"name":_arrNameList2[j],@"department":_arrNameList3[j]} mutableCopy];
                    [arr addObject:_dictionary];
                }
           }
            _dic = [@{@"dockName":_arrNameList1[i],@"imageName":_arrImageList1[i],@"right":arr,@"cart_id":_arrcartidList1[i]} mutableCopy];
            [_dockArray addObject:_dic];
       }
        _ficationclasstableview.dockarr = _dockArray;
    }
    }
}

- (void)loadView{
    [super loadView];
    
    NSString *urlStr = [@"http://ishenghuo.zgcom.cn/api.php/goodscate/lists" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4];
    
    NSURLResponse *response;
    NSError *error;
    NSData *cityData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error) {
        _error = 1;
    } else {
    //解析json
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:cityData options:NSJSONReadingMutableLeaves error:&error];
    
        _result = [json getArrayForKey:@"data"];
        for (NSDictionary *dic in _result) {
            NSString *pidStr = [dic getStringValueForKey:@"p_id" defaultValue:nil];
            if ([pidStr integerValue] == 0) {
                NSMutableDictionary *classOneDic = [NSMutableDictionary dictionary];
                [classOneDic setObject:[dic getStringValueForKey:@"cate_name" defaultValue:nil] forKey:@"dockName"];
                [classOneDic setObject:[dic getStringValueForKey:@"image" defaultValue:nil] forKey:@"imageName"];
                [classOneDic setObject:[dic getStringValueForKey:@"cart_id" defaultValue:nil] forKey:@"cart_id"];
                [_classOneArr addObject:classOneDic];
            }
        }
        _arrimage = [NSMutableArray array];
        _arrname = [NSMutableArray array];
        _arrImageList1 = [NSMutableArray array];
        _arrNameList1 = [NSMutableArray array];
        _arrcartidList1 = [NSMutableArray array];
    
        _arrImageList2 = [NSMutableArray array];
        _arrNameList2 = [NSMutableArray array];
        _arrcartidList2 = [NSMutableArray array];
    
        _arrNameList3 = [NSMutableArray array];
        _arrcartidList3 = [NSMutableArray array];
    
        _arrNameList4 = [NSMutableArray array];
        for (NSInteger i = 0; i < _result.count; i ++) {
            _dict = [NSMutableDictionary dictionary];
            _dict = [_result objectAtIndex:i];

            _strimage = [_dict objectForKey:@"image"];
            _strname = [_dict objectForKey:@"cate_name"];

            [_arrname addObject:_strname];

            _str_p_id = [_dict getStringValueForKey:@"p_id" defaultValue:nil];
            _int_p_idValue = [_str_p_id integerValue];
        
        //一级分类栏显示内容
            if (_int_p_idValue == 0) {
                NSString * str_name = [_dict getStringValueForKey:@"cate_name" defaultValue:nil];
                NSString * str_image = [_dict getStringValueForKey:@"image" defaultValue:nil];
                _str_cartid = [_dict getStringValueForKey:@"cart_id" defaultValue:nil];
                [_arrNameList1 addObject:str_name];
                [_arrcartidList1 addObject:_str_cartid];
                    if ([str_image hasPrefix:@"http"]) {
                        [_arrImageList1 addObject:str_image];
                    } else {
                        NSString * stringImage = [NSString stringWithFormat:@"%@%@", DeFaultURL, str_image];
                        [_arrImageList1 addObject:stringImage];
                    }
            }
            for (NSInteger l = 0; l < _arrcartidList1.count; l ++) {
                if (_int_p_idValue == [_arrcartidList1[l] integerValue]) {
                    NSString * str_name = [_dict getStringValueForKey:@"cate_name" defaultValue:nil];
                    NSString * str_cart = [_dict getStringValueForKey:@"cart_id" defaultValue:nil];

                    [_arrNameList2 addObject:str_name];
                    [_arrcartidList2 addObject:str_cart];
                }
            }
        }
    //数组第0位添加一个元素；
        [_arrNameList1 insertObject:@"1" atIndex:0];
        [_arrNameList2 insertObject:@"1" atIndex:0];
        [_arrNameList3 insertObject:@"1" atIndex:0];
        [_arrImageList1 insertObject:@"1" atIndex:0];
        [_arrcartidList1 insertObject:@"2" atIndex:0];
    }
}

- (void)classificationValue:(NSArray *)arrNameCalss{
    _arrNameClass = arrNameCalss;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _classTwoArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cartId = [[_classTwoArr objectAtIndex:indexPath.section] getStringValueForKey:@"cart_id" defaultValue:nil];
    NSArray *arr = [self getArrayWithCartId:cartId];
    NSInteger linecout;
    if (arr.count % 3 == 0) {
        linecout = arr.count / 3;
    } else {
        linecout = arr.count / 3 + 1;
    }
    return 50 * linecout;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"identifier";
    //   RightTableViewCell * cell = [RightTableViewCell cellWithTableView:tableView];
    RightTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[RightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        //       cell.backgroundColor = [UIColor clearColor];
    }else{
        [cell cleanUpSubviews];
        //删除所有子视图
        while ([cell.contentView.subviews lastObject]!= nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    NSString *cartId = [[_classTwoArr objectAtIndex:indexPath.section] getStringValueForKey:@"cart_id" defaultValue:nil];
    NSArray *arr = [self getArrayWithCartId:cartId];
    
    UIImageView * imageLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 1)];
    imageLine.backgroundColor = [UIColor colorFromHexCode:@"dededd"];
    [cell.contentView addSubview:imageLine];
    
    CGFloat w = (self.view.width - 70) / 3;
    
    NSInteger linecount;
    if (arr.count % 3 == 0) {
        linecount = arr.count / 3;
    } else {
        linecount = arr.count / 3 + 1;
    }
    
    for (int i = 0; i < linecount; i ++) {
        if (i != linecount - 1) {
            for (int j = 0; j < 3; j ++) {
                _p_idCell = [[arr objectAtIndex:i * 3 + j] getStringValueForKey:@"cart_id" defaultValue:nil];
                _p_idName = [[arr objectAtIndex:i * 3 + j] getStringValueForKey:@"dockName" defaultValue:nil];
                _idName = [[arr objectAtIndex:i * 3 + j] getStringValueForKey:@"dockName" defaultValue:nil];
                _cart_idCell = [[arr objectAtIndex:i * 3 + j] getStringValueForKey:@"cart_id" defaultValue:nil];
                UIButton * clickbtn = [[UIButton alloc] initWithFrame:CGRectMake(j * 80 + 20,i * 50, w - 20, 50)];
//                clickbtn.backgroundColor = [UIColor redColor];
                [clickbtn addTarget:self action:@selector(listOfGoodsSender:) forControlEvents:UIControlEventTouchUpInside];
                clickbtn.tag = [_p_idCell integerValue];
                [cell.contentView addSubview:clickbtn];
                UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0,5, w - 10, 40)];
                lab1.text = _p_idName;
                lab1.numberOfLines = 2;
                lab1.font = [UIFont systemFontOfSize:14];
                lab1.textAlignment = NSTextAlignmentLeft;
                
                [clickbtn addSubview:lab1];
            }
        } else {
            for (int j = 0; j < arr.count - i * 3; j ++) {
                _p_idCell = [[_classThrArr objectAtIndex:i * 3 + j] getStringValueForKey:@"cart_id" defaultValue:nil];
                _p_idName = [[_classThrArr objectAtIndex:i * 3 + j] getStringValueForKey:@"dockName" defaultValue:nil];
                _idName = [[arr objectAtIndex:i * 3 + j] getStringValueForKey:@"dockName" defaultValue:nil];
                _cart_idCell = [[_classThrArr objectAtIndex:i * 3 + j] getStringValueForKey:@"cart_id" defaultValue:nil];
                UIButton * clickbtn = [[UIButton alloc] initWithFrame:CGRectMake(j * 80 + 20,i * 50, w - 20, 50)];
//                clickbtn.backgroundColor = [UIColor blueColor];
                [clickbtn addTarget:self action:@selector(listOfGoodsSender:) forControlEvents:UIControlEventTouchUpInside];
                clickbtn.tag = [_p_idCell integerValue];
                [cell.contentView addSubview:clickbtn];
                UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0,5, w - 10, 40)];
                lab1.font = [UIFont systemFontOfSize:14];
                lab1.numberOfLines = 2;
                lab1.textAlignment = NSTextAlignmentLeft;
                lab1.text = _p_idName;
                //        //[[_classThrArr objectAtIndex:j] getStringValueForKey:@"dockName" defaultValue:nil];
                [clickbtn addSubview:lab1];
            }
        }
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.delegate = self;
 // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone; //取消cell点击效果
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat w = self.view.width - 70;
    UIView * myview = [[UIView alloc] init];
    //获取点击二级分类cart_id
    NSString * cart_idSection = [[_classTwoArr objectAtIndex:section] getStringValueForKey:@"cart_id" defaultValue:nil];
    _p_idSection = [[_classTwoArr objectAtIndex:section] getStringValueForKey:@"p_id" defaultValue:nil];
    _p_idNameSection = [[_classTwoArr objectAtIndex:section] getStringValueForKey:@"dockName" defaultValue:nil];
    
    UIButton * clickbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, w, 30)];
    [clickbtn addTarget:self action:@selector(clicklogWithSender:) forControlEvents:UIControlEventTouchUpInside];
    clickbtn.tag = [cart_idSection integerValue];
    [myview addSubview:clickbtn];
    UILabel * textlab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, w, 20)];
    textlab.text = _p_idNameSection;//[[_classTwoArr objectAtIndex:section]
    [clickbtn addSubview:textlab];
    UIImageView * backimg = [[UIImageView alloc] initWithFrame:CGRectMake(w - 20, 5, 10, 20)];
    backimg.image = [UIImage imageNamed:@"xuanze_ic"];
    [myview addSubview:backimg];
    
    return myview;
}

#pragma mark - Scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat sectionHeaderHeight = 30;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }else if (scrollView.contentOffset.y >= sectionHeaderHeight){
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

-(NSArray *)getArrayWithCartId:(NSString *)cartId {
    _cartID1 = cartId;
    [_classThrArr removeAllObjects];
    for (NSDictionary *dic in _result) {
        NSString *pidStr = [dic getStringValueForKey:@"p_id" defaultValue:nil];
        if ([pidStr integerValue] == [cartId integerValue]) {
            NSMutableDictionary *classOneDic = [NSMutableDictionary dictionary];
            [classOneDic setObject:[dic getStringValueForKey:@"cate_name" defaultValue:nil] forKey:@"dockName"];
            [classOneDic setObject:[dic getStringValueForKey:@"image" defaultValue:nil] forKey:@"imageName"];
            [classOneDic setObject:[dic getStringValueForKey:@"cart_id" defaultValue:nil] forKey:@"cart_id"];
            [classOneDic setObject:[dic getStringValueForKey:@"p_id" defaultValue:nil] forKey:@"p_id"];
            [_classThrArr addObject:classOneDic];
        }
    }
    return _classThrArr;
}

-(void)quantity:(NSInteger)quantity money:(NSInteger)money key:(NSString *)key{
    
}

-(void)clickindexPathRow:(NSMutableArray *)array index:(NSIndexPath *)index indeXPath:(NSIndexPath *)indexPath cartId:(NSString *)cartId
{
    _cartID1 = cartId;
    [_classTwoArr removeAllObjects];
    for (NSDictionary *dic in _result) {
        NSString *pidStr = [dic getStringValueForKey:@"p_id" defaultValue:nil];
        if ([pidStr integerValue] == [cartId integerValue]) {
            NSMutableDictionary *classOneDic = [NSMutableDictionary dictionary];
            [classOneDic setObject:[dic getStringValueForKey:@"cate_name" defaultValue:nil] forKey:@"dockName"];
            [classOneDic setObject:[dic getStringValueForKey:@"image" defaultValue:nil] forKey:@"imageName"];
            [classOneDic setObject:[dic getStringValueForKey:@"cart_id" defaultValue:nil] forKey:@"cart_id"];
            [classOneDic setObject:[dic getStringValueForKey:@"p_id" defaultValue:nil] forKey:@"p_id"];
            [_classTwoArr addObject:classOneDic];
        }
    }
    [_rightTableView setContentOffset:_rightTableView.contentOffset animated:NO];
    _offsArray[index.row] = NSStringFromCGPoint(_rightTableView.contentOffset);
    _rightTableView.rightArray = array;
    [_rightTableView reloadData];
    CGPoint point = CGPointFromString([_offsArray objectAtIndex:indexPath.row]);
    [_rightTableView setContentOffset:point];
}

/**
 跳转到消息中心
 */
- (void)rightBtnMessage{
    MsgCenViewController * msg = [[MsgCenViewController alloc] init];
    [self.navigationController pushViewController:msg animated:YES];
}
/**
 跳转到搜索界面
*/
- (void)searchButtonAction{
    SearchPageViewController * searchPage = [[SearchPageViewController alloc] init];
    [self.navigationController pushViewController:searchPage animated:YES];
}

- (void)listOfGoodsSender:(UIButton *)sender{
    ClassificationOfGoodsViewController * class1 = [[ClassificationOfGoodsViewController alloc] init];
    self.delegate = class1;
    class1.classArray = _result;
    class1.selectCartId = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    NSString *str = [self getCartIdWithPid:sender.tag];
    class1.selectPid = str;
//    NSString * strCell = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    [self.delegate passgoodsid:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    [self.delegate firstName:_p_idName];
    [self.delegate secondcartId:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    [self.navigationController pushViewController:class1 animated:YES];
}

- (void)clicklogWithSender:(UIButton *)sender{
    ClassificationOfGoodsViewController * class2 = [[ClassificationOfGoodsViewController alloc] init];
    self.delegate = class2;
    class2.classArray = _result;
    NSString * strSection = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    class2.classArray = _result;
    class2.selectPid = _p_idSection;
    class2.selectCartId = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    class2.type = @"1";
    [self.delegate passgoodsid:strSection];
    [self.delegate firstcartId:_p_idSection];
    [self.delegate firstcartAtSecondId:_p_idCell];
    [self.delegate passName:_p_idNameSection];
    [self.delegate arrNameList:_firstName];
//
    [self.navigationController pushViewController:class2 animated:YES];
}

#pragma mark - Requests产品列表
- (BOOL)startRequest:(NSInteger)requestID{
    if ([super startRequest:requestID]) {
        if (requestID == 101) {
//            hasChanged
            [_client classificationList:[_cartID1 integerValue]];
        }
        return YES;
    }
    return NO;
}

- (BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result{
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 101) {
//            NSArray * arr = [result getArrayForKey:@"data"];
        }
//        //刷新页面,使当前页面加载新数据;
//        [_tableView reloadData];
        return YES;
    }
    return NO;
}

/**
 * 根据pid获取cartId
 */
-(NSString *)getCartIdWithPid:(NSInteger)pid {
    NSString *str;
    for (NSDictionary *dic in _result) {
        NSString *PId = [dic getStringValueForKey:@"cart_id" defaultValue:nil];
        if ([PId integerValue] == pid) {
            str = [dic getStringValueForKey:@"p_id" defaultValue:nil];
        }
    }
    return str;
}
- (void)passgoodsid:(NSString *)goods{
}
- (void)firstcartId:(NSString *)cartid{
}
- (void)firstName:(NSString *)name{
}
- (void)secondcartId:(NSString *)cartid{
}
- (void)firstcartAtSecondId:(NSString *)cartid{
}
- (void)passName:(NSString *)passName{
}
- (void)cartid:(NSString *)cartid{
}
- (void)arrNameList:(NSString *)nameList{
}
@end
