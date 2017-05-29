//
//  ProductEvaluationViewController.m
//  IOSProject
//
//  Created by IOS004 on 15/6/24.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//
//商品评价
//

#import "ProductEvaluationViewController.h"
#import "ProductDetailCell.h"
#import "MJRefresh.h"

@interface ProductEvaluationViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray        * _arr;            //评价列表;
    NSMutableArray * _arrName;        //用户名;
    NSMutableArray * _arrImage;       //用户头像;
    NSMutableArray * _arrLevel;       //评价等级（不传为全部评论）1，好评，2，中评，3，差评
    NSMutableArray * _arrContent;     //评论内容
    NSMutableArray * _arrDate;        //日期
    NSMutableArray * _arrTimet;       //时间
    NSString       * _totalcount;     //产品评价总数量
    NSString       * _totalcount1;    //产品评价数量(好)
    NSString       * _totalcount2;    //产品评价数量(中)
    NSString       * _totalcount3;    //产品评价数量(差)
    NSString       * _strImage;       //图片
    NSInteger        _intValue;       //转换为int类型的评价等级
    UIImageView    * _imageline;      //评价选中框
    UIButton       * _choicebtn;      //评价按钮
    UIButton       * _choicebtnAll;   //全部选则按钮
    UIButton       * _highPraise;     //好评选择按钮
    UIButton       * _evaluation;     //中评选择按钮
    UIButton       * _badReview;      //差评选择按钮
    NSInteger        _level;          //评价等级
    NSInteger        _goods_id;       //参数goods_id
//    NSArray * _arrpage;
    NSString * _strCount;
    NSInteger _intCount;
}
@property (strong, nonatomic) NSMutableArray *fakeData;
@end

@implementation ProductEvaluationViewController

- (NSMutableArray *)fakeData{
    if (!_fakeData) {
        self.fakeData = [NSMutableArray array];
        [self.fakeData addObject:_arr];
    }
    return _fakeData;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //刷新
    [self addFooter];
    _intCount = 1;
    
    _arrName = [NSMutableArray array];
    _arrContent = [NSMutableArray array];
    _arrLevel = [NSMutableArray array];
    _arrDate = [NSMutableArray array];
    _arrTimet = [NSMutableArray array];
    _arrImage = [NSMutableArray array];

    [self addBackButtonToNavigation];
    self.navigationItem.title = @"商品评价";
    [self implementTheSelected];
    
    _imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 42, self.view.width / 4, 3)];
    _imageline.backgroundColor = RGBCOLOR(255, 95, 5);
    [self.view addSubview:_imageline];

    UIImageView * imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, self.view.width, 1)];
    imageline.backgroundColor = [UIColor colorFromHexCode:@"#757575"];
    [self.view addSubview:imageline];

    //传值goods_id
    _goods_id = [_levgoods_id integerValue];
    [self startRequest:101];
}

- (void)implementTheSelected{
    //全部、好、中、差评四个选择按钮
    NSArray * arr = @[@"全部",@"好评",@"中评",@"差评"];

    _choicebtnAll = [[UIButton alloc] initWithFrame:CGRectMake(0, -10, self.view.width / 4, 44)];
    _choicebtnAll.tag = 0;
    [_choicebtnAll setTitle:[arr objectAtIndex:0] forState:UIControlStateNormal];
    _choicebtnAll.titleLabel.font = [UIFont systemFontOfSize:14];
    [_choicebtnAll addTarget:self action:@selector(oderStateBtnRequestWithSender:) forControlEvents:UIControlEventTouchUpInside];
    [_choicebtnAll setTitleColor: [UIColor colorFromHexCode:@"#999999"] forState:UIControlStateNormal];
    [_choicebtnAll setTitleColor: [UIColor colorFromHexCode:@"#333333"] forState:UIControlStateSelected];
    _choicebtnAll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_choicebtnAll];
    
    _highPraise = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width / 4, -10, self.view.width / 4, 44)];
    _highPraise.tag = 1;
    [_highPraise setTitle:[arr objectAtIndex:1] forState:UIControlStateNormal];
    _highPraise.titleLabel.font = [UIFont systemFontOfSize:14];
    [_highPraise addTarget:self action:@selector(oderStateBtnRequestWithSender:) forControlEvents:UIControlEventTouchUpInside];
    [_highPraise setTitleColor: [UIColor colorFromHexCode:@"#999999"] forState:UIControlStateNormal];
    [_highPraise setTitleColor: [UIColor colorFromHexCode:@"#333333"] forState:UIControlStateSelected];
    _highPraise.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_highPraise];
    
    _evaluation = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width / 2, -10, self.view.width / 4, 44)];
    _evaluation.tag = 2;
    [_evaluation setTitle:[arr objectAtIndex:2] forState:UIControlStateNormal];
    _evaluation.titleLabel.font = [UIFont systemFontOfSize:14];
    [_evaluation addTarget:self action:@selector(oderStateBtnRequestWithSender:) forControlEvents:UIControlEventTouchUpInside];
    [_evaluation setTitleColor: [UIColor colorFromHexCode:@"#999999"] forState:UIControlStateNormal];
    [_evaluation setTitleColor: [UIColor colorFromHexCode:@"#333333"] forState:UIControlStateSelected];
    _evaluation.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_evaluation];
    
    _badReview = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width / 4 * 3, -10, self.view.width / 4, 44)];
    _badReview.tag = 3;
    [_badReview setTitle:[arr objectAtIndex:3] forState:UIControlStateNormal];
    _badReview.titleLabel.font = [UIFont systemFontOfSize:14];
    [_badReview addTarget:self action:@selector(oderStateBtnRequestWithSender:) forControlEvents:UIControlEventTouchUpInside];
    [_badReview setTitleColor: [UIColor colorFromHexCode:@"#999999"] forState:UIControlStateNormal];
    [_badReview setTitleColor: [UIColor colorFromHexCode:@"#333333"] forState:UIControlStateSelected];
    _badReview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_badReview];
}
-(void)oderStateBtnRequestWithSender:(UIButton *)sender {
    //四个选择按钮点击事件
    switch (sender.tag) {
        case 0:
            _choicebtnAll.selected = YES;
            _imageline.frame = CGRectMake(0, 52, self.view.width / 4, 3);
            [_choicebtnAll addSubview:_imageline];
            _highPraise.selected = NO;
            _evaluation.selected = NO;
            _badReview.selected = NO;
            _level = 0;
            _intCount = 1;
            [_arrName removeAllObjects];
            [_arrContent removeAllObjects];
            [_arrDate removeAllObjects];
            [_arrImage removeAllObjects];
            [_arrLevel removeAllObjects];
            [_arrTimet removeAllObjects];
            [self startRequest:101];
            break;
        case 1:
            _highPraise.selected = YES;
            _imageline.frame = CGRectMake(0, 52, self.view.width / 4, 3);
            [_highPraise addSubview:_imageline];
            _choicebtnAll.selected = NO;
            _evaluation.selected = NO;
            _badReview.selected = NO;
            _level = 1;
            _intCount = 1;
            [_arrName removeAllObjects];
            [_arrContent removeAllObjects];
            [_arrDate removeAllObjects];
            [_arrImage removeAllObjects];
            [_arrLevel removeAllObjects];
            [_arrTimet removeAllObjects];
            [self startRequest:101];
            break;
        case 2:
            _evaluation.selected = YES;
            _imageline.frame = CGRectMake(0, 52, self.view.width / 4, 3);
            [_evaluation addSubview:_imageline];
            _choicebtnAll.selected = NO;
            _highPraise.selected = NO;
            _badReview.selected = NO;
            _level = 2;
            _intCount = 1;
            [_arrName removeAllObjects];
            [_arrContent removeAllObjects];
            [_arrDate removeAllObjects];
            [_arrImage removeAllObjects];
            [_arrLevel removeAllObjects];
            [_arrTimet removeAllObjects];
            [self startRequest:101];
            break;
        default:
            _badReview.selected = YES;
            _imageline.frame = CGRectMake(0, 52, self.view.width / 4, 3);
            [_badReview addSubview:_imageline];
            _choicebtnAll.selected = NO;
            _highPraise.selected = NO;
            _evaluation.selected = NO;
            _level = 3;
            [_arrName removeAllObjects];
            [_arrContent removeAllObjects];
            [_arrDate removeAllObjects];
            [_arrImage removeAllObjects];
            [_arrLevel removeAllObjects];
            [_arrTimet removeAllObjects];
            [self startRequest:101];
            break;
    }
}

#pragma tableview代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrLevel.count + 1;
//    return _fakeData.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * identifier = [NSString stringWithFormat:@"cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
    ProductDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[ProductDetailCell alloc] initWithReuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else
        [cell cleanUpSubviews];

    if (indexPath.row == 0) {
        //全部、好中差四个评论显示数量
        for (NSInteger i = 0; i < 4; i ++) {
            UILabel * labgood = [[UILabel alloc] initWithFrame:CGRectMake(i * (self.view.width / 4), 20,self.view.width / 4, 22)];
            labgood.backgroundColor = [UIColor whiteColor];
            if (i == 0) labgood.text = _totalcount;
            if (i == 1) labgood.text = _totalcount1;
            if (i == 2) labgood.text = _totalcount2;
            if (i == 3) labgood.text = _totalcount3;
            labgood.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:labgood];
            
        }
    }
        for (NSInteger j = 1; j < _arrLevel.count + 1; j ++) {
            //用户头像、名称及好中差评显示
            if (indexPath.row == j) {
                UIImageView * headImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 40, 40)];
                [headImage setImageWithURL:_arrImage[j - 1]];
                headImage.layer.cornerRadius = headImage.height / 2.0;
                headImage.layer.masksToBounds = YES;
                [cell.contentView addSubview:headImage];
                
                UILabel * namelab = [[UILabel alloc] initWithFrame:CGRectMake(70, 15, 100, 20)];
                namelab.textColor = [UIColor colorFromHexCode:@"#333333"];
                namelab.font = [UIFont systemFontOfSize:17];
                namelab.text = _arrName[j - 1];
                [cell.contentView addSubview:namelab];
                
                UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width - 50, 20, 30, 15)];
                lab.text = _arrLevel[j - 1];
                switch ([_arrLevel[j - 1] integerValue]) {
                    case 1:
                        lab.text = @"好评";
                        lab.backgroundColor = [UIColor colorFromHexCode:@"#42c35c"];
                        break;
                    case 2:
                        lab.text = @"中评";
                        lab.backgroundColor = [UIColor colorFromHexCode:@"#aac440"];
                        break;
                    case 3:
                        lab.text = @"差评";
                        lab.backgroundColor = [UIColor colorFromHexCode:@"#c7a24a"];
                        break;
                    default:
                        break;
                }

                lab.textColor  = [UIColor colorFromHexCode:@"#ffffff"];
                lab.textAlignment = NSTextAlignmentCenter;
                lab.font = [UIFont systemFontOfSize:12];
                [cell.contentView addSubview:lab];
                
                for (NSInteger k = 0; k < 2; k ++) {
                //显示评论时间
                UILabel * timelab = [[UILabel alloc] initWithFrame:CGRectMake(70 + (k * 100), 35, 100, 20)];
                    timelab.textColor = [UIColor colorFromHexCode:@"#757575"];
                    timelab.font = [UIFont systemFontOfSize:15];
                    if (k == 0) {
                        timelab.text = _arrDate[j - 1];
                    }
                    if (k == 1){
                        timelab.text = _arrTimet[j - 1];
                    }
                    [cell.contentView addSubview:timelab];
                }
                //评论内容
                UILabel * commentslab = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, self.view.width - 40, 40)];
                commentslab.text = _arrContent[j - 1];
//                commentslab.lineBreakMode = UILineBreakModeCharacterWrap;
                commentslab.numberOfLines = 0;
                commentslab.textColor = [UIColor colorFromHexCode:@"#999999"];
                commentslab.font = [UIFont systemFontOfSize:13];
                [cell.contentView addSubview:commentslab];
            }
        }
    
    return cell;
}
//height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 44;
    }else
        return 90;
}
- (void)addFooter{
    [_tableView addFooterWithCallback:^{
        if (_intCount < [_strCount integerValue]) {
            _intCount ++;
             [self startRequest:101];
        }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_tableView reloadData];
                [_tableView footerEndRefreshing];
            });
    }];
}
#pragma mark - Requests产品评价列表
- (BOOL)startRequest:(NSInteger)requestID{
    if ([super startRequest:requestID]) {
        if (requestID == 101) {
            [_client productEvaluationList:_goods_id level:_level pageing:_intCount];
        }else if (requestID == 102){
            [_client productEvaluationCount:_goods_id levelValueCount:0];
        }else if (requestID == 103){
            [_client productEvaluationCount:_goods_id levelValueCount:1];
        }else if (requestID == 104){
            [_client productEvaluationCount:_goods_id levelValueCount:2];
        }else if (requestID == 105){
            [_client productEvaluationCount:_goods_id levelValueCount:3];
        }
        return YES;
    }
    return NO;
}

- (BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result{
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 101) {
            _arr = [result getArrayForKey:@"data"];
            
            
            
            for (NSInteger i = 0; i < _arr.count; i ++) {
                
                NSDictionary * _mudic = [_arr objectAtIndex:i];
                //字符串取值;
                NSString * strContent = [_mudic getStringValueForKey:@"content" defaultValue:nil];
                NSString * strLevel = [_mudic getStringValueForKey:@"level" defaultValue:nil];
                NSString * strTime = [_mudic getStringValueForKey:@"create_time" defaultValue:nil];
                _intValue = [strLevel intValue];
                NSDictionary * dintionary = [_arr objectAtIndex:i];
                NSDictionary * userinfo = [dintionary objectForKey:@"userinfo"];
                [_arrContent addObject:strContent];
                [_arrLevel addObject:strLevel];
                
                NSString * strName = [userinfo getStringValueForKey:@"nack_name" defaultValue:nil];
                _strImage = [userinfo getStringValueForKey:@"head_img" defaultValue:nil];
                [_arrName addObject:strName];
                if ([_strImage hasPrefix:@"http"]) {
                    [_arrImage addObject:_strImage];
                } else {
                    NSString * stringImage = [NSString stringWithFormat:@"%@%@", DeFaultURL, _strImage];
                    [_arrImage addObject:stringImage];
                }
            
                //时间戳
                NSString * str_time = strTime;
                NSTimeInterval time = [str_time integerValue];
                NSDate * date = [NSDate dateWithTimeIntervalSince1970:time];
                //实例化一个
                NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
                NSDateFormatter * timeFormatter = [[NSDateFormatter alloc] init];
                //设定时间格式
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                [timeFormatter setDateFormat:@"HH:mm:ss"];
                NSString * dateStr = [dateFormatter stringFromDate:date];
                NSString * timeStr = [timeFormatter stringFromDate:date];
                [_arrDate addObject:dateStr];
                [_arrTimet addObject:timeStr];
            }
            NSDictionary * paging = [result getDictionaryForKey:@"paging"];
            NSString * tatalcount = [paging getStringValueForKey:@"totalcount" defaultValue:nil];
            NSString * numpage = [paging getStringValueForKey:@"numberofpage" defaultValue:nil];
            NSInteger countOfPage = [tatalcount integerValue] / [numpage integerValue];
            NSInteger countAddPage = [tatalcount integerValue] % [numpage integerValue];
            if (countAddPage == 0) {
                _strCount = [NSString stringWithFormat:@"%ld",countOfPage];
            }else{
                _strCount = [NSString stringWithFormat:@"%ld",countOfPage + 1];
            }
            [self startRequest:102];
        }else if (sender.requestID == 102){
            NSDictionary * dic = [result getDictionaryForKey:@"data"];
            _totalcount = [dic getStringValueForKey:@"totalcount" defaultValue:nil];
            [self startRequest:103];
        }else if (sender.requestID == 103){
            NSDictionary * dic = [result getDictionaryForKey:@"data"];
            _totalcount1 = [dic getStringValueForKey:@"totalcount" defaultValue:nil];
            [self startRequest:104];
        }else if (sender.requestID == 104){
            NSDictionary * dic = [result getDictionaryForKey:@"data"];
            _totalcount2 = [dic getStringValueForKey:@"totalcount" defaultValue:nil];
            [self startRequest:105];
        }else if (sender.requestID == 105){
            NSDictionary * dic = [result getDictionaryForKey:@"data"];
            _totalcount3 = [dic getStringValueForKey:@"totalcount" defaultValue:nil];
        }
        [_tableView reloadData];
        return YES;
    }
    return NO;
}

@end
