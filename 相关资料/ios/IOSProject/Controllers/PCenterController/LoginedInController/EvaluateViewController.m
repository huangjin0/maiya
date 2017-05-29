//
//  EvaluateViewController.m
//  IOSProject
//
//  Created by IOS002 on 15/7/16.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "EvaluateViewController.h"
#import "CommentViewCell.h"
#import "EvalModel.h"
#import "GoodsInfoModel.h"

#define statusH ([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height)

@interface EvaluateViewController () <UITableViewDataSource,UITableViewDelegate,selectEvalDelegate,UIAlertViewDelegate> {
//    待评价商品列表
    UITableView *_tableView;
//    好评
    UIButton *_goodComment;
//    中评
    UIButton *_mediComment;
//    差评
    UIButton *_badsComment;
//    是否选择
    BOOL _isSelect;
//    待评价商品
    NSMutableArray *_evaluGoods;
    NSIndexPath *_selectIndex;
    NSString *_selectRow;
}

@end

@implementation EvaluateViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTheKeyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTheKeyBoardWillHiden) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"评价";
    _evaluGoods = [NSMutableArray array];
    [self allocEvaluGoodsData];
    [self addBackButtonToNavigation];
    [self addHeadViewToView];
    [self addTableViewToView];
    [self addReferOrderToView];
//    [self addFooterViewToView];
    // Do any additional setup after loading the view.
}

/**
 * 提交按钮
 */
-(void)addReferOrderToView {
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    clearButton.frame = CGRectMake(0, 0, 40, 30);
    [clearButton setTitle:@"提交" forState:UIControlStateNormal];
    [clearButton setTitleColor:RGBCOLOR(255, 95, 5) forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(evalBtnAtion) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *clearItem = [[UIBarButtonItem alloc] initWithCustomView:clearButton];
    [self.navigationItem setRightBarButtonItem:clearItem];
}

/**
 * 初始化待评价商品数据
 */
-(void)allocEvaluGoodsData {
    for (GoodsInfoModel *goodsModel in self.goodsData) {
        EvalModel *model = [[EvalModel alloc] initWithGoodsInfoModel:goodsModel];
        [_evaluGoods addObject:model];
    }
}


/**
 * 添加头部文件
 */
-(void)addHeadViewToView {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, 60)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    _goodComment = [UIButton buttonWithType:UIButtonTypeCustom];
    _goodComment.frame = CGRectMake((ViewWidth - 150) / 4, 20, 20, 20);
    [_goodComment setBackgroundImage:[UIImage imageNamed:@"xuanzhong_no_ic"] forState:UIControlStateNormal];
    [_goodComment setBackgroundImage:[UIImage imageNamed:@"iSH_XuanZhong"] forState:UIControlStateSelected];
    _goodComment.tag = 1;
    [_goodComment addTarget:self action:@selector(allEvaluateWithSender:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:_goodComment];
    
    _mediComment = [UIButton buttonWithType:UIButtonTypeCustom];
    _mediComment.frame = CGRectMake((ViewWidth - 150) / 4 * 2 + 50, 20, 20, 20);
    [_mediComment setBackgroundImage:[UIImage imageNamed:@"xuanzhong_no_ic"] forState:UIControlStateNormal];
    [_mediComment setBackgroundImage:[UIImage imageNamed:@"iSH_XuanZhong"] forState:UIControlStateSelected];
    _mediComment.tag = 2;
    [_mediComment addTarget:self action:@selector(allEvaluateWithSender:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:_mediComment];
    
    _badsComment = [UIButton buttonWithType:UIButtonTypeCustom];
    _badsComment.frame = CGRectMake((ViewWidth - 150) / 4 * 3 + 100, 20, 20, 20);
    [_badsComment setBackgroundImage:[UIImage imageNamed:@"xuanzhong_no_ic"] forState:UIControlStateNormal];
    [_badsComment setBackgroundImage:[UIImage imageNamed:@"iSH_XuanZhong"] forState:UIControlStateSelected];
    _badsComment.tag = 3;
    [_badsComment addTarget:self action:@selector(allEvaluateWithSender:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:_badsComment];
    
    NSArray *commentArr = @[@"好评",@"中评",@"差评"];
    for (int i = 0; i < 3; i ++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((ViewWidth - 150) / 4 + 20 + i * ((ViewWidth - 150) / 4 + 50), 20, 30, 20)];
        label.text = commentArr[i];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = RGBCOLOR(255, 95, 5);
        [headView addSubview:label];
    }
}

/**
 * 添加tableView
 */
-(void)addTableViewToView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, ViewWidth, self.view.height - 60 - statusH)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

/**
 * 点击背景键盘隐藏
 */
-(void)keyboardHide:(UITapGestureRecognizer*)tap {
    [self.view endEditing:YES];
}

/**
 * 全部评价
 */
-(void)allEvaluateWithSender:(UIButton *)sender {
    if (!_isSelect) {
        switch (sender.tag) {
            case 1:
                _goodComment.selected = YES;
                _isSelect = YES;
                break;
            case 2:
                _mediComment.selected = YES;
                _isSelect = YES;
                break;
            default:
                _badsComment.selected = YES;
                _isSelect = YES;
                break;
        }
    } else {
        switch (sender.tag) {
            case 1:
                if (_goodComment.selected) {
                    _goodComment.selected = NO;
                    _isSelect = NO;
                } else {
                    _goodComment.selected = YES;
                    _mediComment.selected = NO;
                    _badsComment.selected = NO;
                }
                break;
            case 2:
                if (_mediComment.selected) {
                    _mediComment.selected = NO;
                    _isSelect = NO;
                } else {
                    _mediComment.selected = YES;
                    _goodComment.selected = NO;
                    _badsComment.selected = NO;
                }
                break;
            default:
                if (_badsComment.selected) {
                    _badsComment.selected = NO;
                    _isSelect = NO;
                } else {
                    _badsComment.selected = YES;
                    _goodComment.selected = NO;
                    _mediComment.selected = NO;
                }
                break;
        }
    }
    if (_isSelect) {
        for (EvalModel *model in _evaluGoods) {
            model.isEvalu = YES;
            model.evaluMass = [NSString stringWithFormat:@"%ld",(long)sender.tag];
//            model.evaluMass = [NSString stringWithFormat:@"%d",sender.tag];
        }
        [_tableView reloadData];
    }
}

/**
 * 提交评论
 */
-(void)evalBtnAtion {
    int i = 0;
    for (EvalModel *model in _evaluGoods) {
        if (model.isEvalu) {
            i ++;
        }
    }
    if (i == _evaluGoods.count) {
        [self startRequest:0];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你有商品未评价，点击确定将默认为好评" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alertView show];
    }
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self startRequest:0];
    }
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _evaluGoods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    CommentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CommentViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    EvalModel *model = [_evaluGoods objectAtIndex:indexPath.row];
    cell.delegate = self;
    cell.item = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SelectEvalDelegate 
-(void)selectEvalWithCell:(CommentViewCell *)cell tag:(NSInteger)tag isSelect:(BOOL)select {
    NSIndexPath *index = [_tableView indexPathForCell:cell];
//    [cell.commentText becomeFirstResponder];
    EvalModel *model = [_evaluGoods objectAtIndex:index.row];
    if (select) {
        model.isEvalu = select;
        model.evaluMass = [NSString stringWithFormat:@"%ld",(long)tag];
    } else {
        model.isEvalu = select;
    }
    int i = 0; int j = 0; int k = 0;
    for (EvalModel *evalModel in _evaluGoods) {
        switch ([evalModel.evaluMass integerValue]) {
            case 1:
                i ++;
                break;
            case 2:
                j ++;
                break;
            case 3:
                k ++;
                break;
            default:
                break;
        }
        if (i == _evaluGoods.count) {
            [self allEvaluateWithSender:_goodComment];
        } else if (j == _evaluGoods.count) {
            [self allEvaluateWithSender:_mediComment];
        } else if (k == _evaluGoods.count) {
            [self allEvaluateWithSender:_badsComment];
        } else {
            _goodComment.selected = NO;
            _mediComment.selected = NO;
            _badsComment.selected = NO;
            _isSelect = NO;
        }
    }
}

-(void)addContentToModelWithcell:(CommentViewCell *)cell content:(NSString *)content {
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    EvalModel *model = [_evaluGoods objectAtIndex:indexPath.row];
    model.content = content;
    if (![content isEqual:@""]) {
        if (!model.isEvalu) {
            model.isEvalu = YES;
            model.evaluMass = @"1";
            [cell addEvaluSelectWithSender:cell.goodComment];
        }
    }
}

-(void)tapTextViewWithCell:(CommentViewCell *)cell {
    NSIndexPath *index = [_tableView indexPathForCell:cell];
//    _selectIndex = index;
    _selectRow = [NSString stringWithFormat:@"%ld",(long)index.row];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - CCRequest
-(BOOL)startRequest:(NSInteger)requestID {
    if ([super startRequest:requestID]) {
        if (requestID == 0) {
            int i = 0;
            NSMutableString *goodId  = [NSMutableString string];
            NSMutableString *specId  = [NSMutableString string];
            NSMutableString *level   = [NSMutableString string];
            NSMutableString *content = [NSMutableString string];
            for (EvalModel *model in _evaluGoods) {
                if (i == 0) {
                    [goodId appendFormat:@"%@",model.goodsId];
                    [specId appendFormat:@"%@",model.specId];
                    if (model.isEvalu) {
                        [level  appendFormat:@"%@",model.evaluMass];
                    } else {
                        [level appendFormat:@"1"];
                    }
                    [content appendFormat:@"%@",model.content];
                } else {
                    [goodId appendFormat:@"&-&%@",model.goodsId];
                    [specId appendFormat:@"&-&%@",model.specId];
                    if (model.isEvalu) {
                        [level  appendFormat:@"&-&%@",model.evaluMass];
                    } else {
                        [level appendFormat:@"&-&1"];
                    }
                    [content appendFormat:@"&-&%@",model.content];
                }
                i ++;
            }
            [_client addGoodsEvalWithOrderId:[self.orderId intValue] goodsId:goodId specId:specId level:level content:content];
        }
        return YES;
    }
    return NO;
}

-(BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result {
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        return YES;
    }
    return NO;
}


/**
 *  键盘弹出
 */
-(void)handleTheKeyBoardWillShow:(NSNotification *)notification {
    NSValue *keyBoardRectAsObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [keyBoardRectAsObject CGRectValue];
    CGFloat keyBoardHight = keyboardRect.size.height;
    [UIView beginAnimations:@"Curl" context:nil];
    [UIView setAnimationDuration:0.50];
    [UIView setAnimationDelegate:self];
    [_tableView setFrame:CGRectMake(0, 60, ViewWidth, self.view.height - keyBoardHight - 60)];
    [UIView commitAnimations];
}

/**
 * 键盘隐藏
 */
-(void)handleTheKeyBoardWillHiden {
    [UIView beginAnimations:@"Curl" context:nil];
    [UIView setAnimationDuration:0.50];
    [UIView setAnimationDelegate:self];
    [_tableView setFrame:CGRectMake(0, 60, ViewWidth, self.view.height - 60)];
    [UIView commitAnimations];
}


@end
