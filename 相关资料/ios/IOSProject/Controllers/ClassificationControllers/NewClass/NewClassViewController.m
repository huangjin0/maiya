//
//  NewClassViewController.m
//  IOSProject
//
//  Created by IOS002 on 16/5/27.
//  Copyright © 2016年 CC Inc. All rights reserved.
//

#import "NewClassViewController.h"
#import "NewClassMainCell.h"
#import "NewClassSubCell.h"
#import "NewClassColHeaderView.h"
#import "SearchPageViewController.h"
#import "MsgCenViewController.h"
#import "ISH_NewClassGoods.h"
#import "ClassificationOfGoodsViewController.h"

#define KInfo @"info"
#define KChild @"childInfo"
#define KCollectionCellWidth (KViewWidth / 320 * (320 - 75) / 3)

@interface NewClassViewController ()<UITableViewDataSource,UITableViewDelegate> {
    
    IBOutlet UITableView *_tableView;
    IBOutlet UICollectionView *_collectionView;
//    返回产品数据
    NSArray *_resultData;
//    产品数组
    NSArray *_dataArr;
//    一级产品数组
    NSArray *_firitGoodsArr;
//    二级产品数组
    NSArray *_secArr;
//    红点
    UIImageView *_pointImageView;
//    红点是否显示
    BOOL _hasRedPoint;
    UIButton *_rightBtn;
    
}

@end

static NSString *tabIdentifier = @"cell";
static NSString *colCellIdentifier = @"collectionCell";
static NSString *colHeaderIdentifier = @"collectionHead";

@implementation NewClassViewController

- (instancetype)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = NO;
        ADD_NTF(@"heartBeat", @selector(hasRecivedNewMessageWithnotification:));
        ADD_NTF(@"hasRedPoint", @selector(hasReadMessage));
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.titleView = [self addNaviTitleView];
    [self addLeftBtn];
    [self addRightMsgButton];
//    添加分割线
    _tableView.layer.borderColor = RGBHex(@"#dededd").CGColor;
    _tableView.layer.borderWidth = 1.0;
//    tableView注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"NewClassMainCell" bundle:nil] forCellReuseIdentifier:tabIdentifier];
//    collection注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"NewClassSubCell" bundle:nil] forCellWithReuseIdentifier:colCellIdentifier];
//    collection注册header
    [_collectionView registerNib:[UINib nibWithNibName:@"NewClassColHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:colHeaderIdentifier];
//    初始化数组
//       _addressListArr = [NSMutableArray array];
    [self startRequest:101];
    // Do any additional setup after loading the view from its nib.
}

/**
 * 添加右边消息按钮
 */
- (void)addRightMsgButton {
    UIButton * rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setBackgroundImage:[UIImage imageNamed:@"iSH_NewsMsg"] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(rightBtnMessage) forControlEvents:UIControlEventTouchUpInside];
    rightbtn.frame = CGRectMake(10, 0, 25, 25);
    _pointImageView = [[UIImageView alloc] initWithFrame:CGRectMake(22.5, 0, 5, 5)];
    _pointImageView.backgroundColor = [UIColor redColor];
    _pointImageView.layer.cornerRadius = 2.5;
    _pointImageView.layer.masksToBounds = YES;
    if (_hasRedPoint) {
        _pointImageView.hidden = NO;
    } else {
        _pointImageView.hidden = YES;
    }
    [rightbtn addSubview:_pointImageView];
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightButton;
}

/**
 * 消息监听
 */
-(void)hasRecivedNewMessageWithnotification:(NSNotification *)notification {
    if (!_hasRedPoint) {
        _pointImageView.hidden = NO;
        _hasRedPoint = YES;
    }
}

/**
 * 取消红点
 */
-(void)hasReadMessage {
    if (_hasRedPoint) {
        _pointImageView.hidden = YES;
        _hasRedPoint = NO;
    }
}


/**
 * 添加左边按钮
 */
- (void)addLeftBtn {
    UIButton * leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"iSH_HomeLogo"] forState:UIControlStateNormal];
    leftbtn.frame = CGRectMake(10, 0, 20, 20);
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = leftButton;
}


/**
 * 显示alertView
 */
- (void)showLAlertViewWithMsg:(NSString *)msg {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

/**
 * 添加搜索框
 */
- (UIView *)addNaviTitleView {
    UIButton * searchbtn = [[UIButton alloc] init];
    [searchbtn setBackgroundImage:[UIImage imageNamed:@"search__@3x"] forState:UIControlStateNormal];
    [searchbtn addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    searchbtn.frame = CGRectMake(50, 10, 200, 30);
    return searchbtn;
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 获取产品数组
 */
- (NSArray *)getListWithCate_id:(NSInteger)cate_id {
    NSMutableArray *mutableArr = [NSMutableArray array];
    for (ISH_NewClassGoods *item in _dataArr) {
        if (item.p_id == cate_id) {
            [mutableArr addObject:item];
        }
    }
    return mutableArr;
}

/**
 * 改变选中未选中状态
 */
- (void)changeSelectStateWithIndex:(NSInteger)index {
    for (int i = 0; i < _firitGoodsArr.count; i ++) {
        ISH_NewClassGoods *item = _firitGoodsArr[i];
        if (i == index) {
            item.is_select = YES;
        } else {
            item.is_select = NO;
        }
    }
}

/**
 * 获取二三级产品
 */
- (NSArray *)getTheSecondAndeThirdGoodsWithArr:(NSArray *)arr {
    NSMutableArray *mutableArr = [NSMutableArray array];
    for (ISH_NewClassGoods *item in arr) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:item forKey:KInfo];
        [dic setObject:[self getListWithCate_id:item.cart_id] forKey:KChild];
        [mutableArr addObject:dic];
    }
    return mutableArr;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _firitGoodsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewClassMainCell *cell = [tableView dequeueReusableCellWithIdentifier:tabIdentifier];
    ISH_NewClassGoods *item = _firitGoodsArr[indexPath.row];
    cell.item = item;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KViewWidth / 320 * 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ISH_NewClassGoods *item = _firitGoodsArr[indexPath.row];
    if (!item.is_select) {
        [self changeSelectStateWithIndex:indexPath.row];
        [tableView reloadData];
        ISH_NewClassGoods *item = _firitGoodsArr[indexPath.row];
        NSArray *arr = [self getListWithCate_id:item.cart_id];
        _secArr = [self getTheSecondAndeThirdGoodsWithArr:arr];
        [_collectionView reloadData];
    }
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSDictionary *dic = _secArr[section];
    NSArray *arr = [dic getArrayForKey:KChild];
    return arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NewClassSubCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:colCellIdentifier forIndexPath:indexPath];
    NSDictionary *dic = _secArr[indexPath.section];
    NSArray *secArr = [dic getArrayForKey:KChild];
    ISH_NewClassGoods *item = secArr[indexPath.row];
    cell.titleLab.text = item.cate_name;
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _secArr.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NewClassColHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:colHeaderIdentifier forIndexPath:indexPath];
    NSDictionary *dic = _secArr[indexPath.section];
    ISH_NewClassGoods *item = [dic objectForKey:KInfo];
    __weak NewClassColHeaderView *weakHeader = header;
    [weakHeader tapWithBlock:^{
//        copy code
        ClassificationOfGoodsViewController * class2 = [[ClassificationOfGoodsViewController alloc] init];
        self.delegate = class2;
        class2.classArray = _resultData;
        class2.selectPid = [NSString stringWithFormat:@"%ld",(long)item.p_id];
        class2.selectCartId = [NSString stringWithFormat:@"%ld",(long)item.cart_id];
        class2.type = @"1";
        [self.delegate passgoodsid:class2.selectCartId];
        [self.delegate firstcartId:class2.selectPid];
        [self.delegate firstcartAtSecondId:class2.selectCartId];
        [self.delegate passName:item.cate_name];
//        [self.delegate arrNameList:_firstName];
//
        [self.navigationController pushViewController:class2 animated:YES];

    }];
    header.headTitleLab.text = item.cate_name;
    return header;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = _secArr[indexPath.section];
    NSArray *secArr = [dic getArrayForKey:KChild];
    ISH_NewClassGoods *item = secArr[indexPath.row];
    ClassificationOfGoodsViewController * class1 = [[ClassificationOfGoodsViewController alloc] init];
    self.delegate = class1;
    class1.classArray = _resultData;
    class1.selectCartId = [NSString stringWithFormat:@"%ld",(long)item.cart_id];
    //    NSString *str = [self getCartIdWithPid:sender.tag];
    class1.selectPid = [NSString stringWithFormat:@"%ld",(long)item.p_id];
    //    NSString * strCell = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    [self.delegate passgoodsid:[NSString stringWithFormat:@"%ld",(long)item.cart_id]];
    [self.delegate firstName:item.cate_name];
    [self.delegate secondcartId:[NSString stringWithFormat:@"%ld",(long)item.cart_id]];
    [self.navigationController pushViewController:class1 animated:YES];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(KCollectionCellWidth, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(KViewWidth / 320 * (320 - 75), 30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - Requests产品列表
- (BOOL)startRequest:(NSInteger)requestID{
    if ([super startRequest:requestID]) {
        if (requestID == 101) {
            [_client getTheGoodsListWithCate_id:0];
        }
        return YES;
    }
    return NO;
}

- (BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result{
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 101) {
            NSArray *data = [result getArrayForKey:@"data"];
            _resultData = data;
            NSMutableArray *mutableArr = [NSMutableArray array];
            for (NSDictionary *dic in data) {
                ISH_NewClassGoods *item = [[ISH_NewClassGoods alloc] initWithDic:dic];
                [mutableArr addObject:item];
            }
            _dataArr = mutableArr;
//            获取一级产品
            _firitGoodsArr = [self getListWithCate_id:0];
//            默认选中第一个
            [self changeSelectStateWithIndex:0];
            [_tableView reloadData];
//            二级产品
            ISH_NewClassGoods *item = _firitGoodsArr[0];
            NSArray *arr = [self getListWithCate_id:item.cart_id];
            _secArr = [self getTheSecondAndeThirdGoodsWithArr:arr];
            [_collectionView reloadData];
        }
        return YES;
    }
    return NO;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
