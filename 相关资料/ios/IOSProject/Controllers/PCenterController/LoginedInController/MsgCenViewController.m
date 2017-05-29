//
//  MsgCenViewController.m
//  IOSProject
//
//  Created by IOS002 on 15/6/24.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "MsgCenViewController.h"
#import "MsgTableViewCell.h"
#import "ChatModel.h"
#import "MessageManger.h"
#import "ChatMessage.h"

@interface MsgCenViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,EGORefreshTableHeaderDelegate>

{
    //    聊天界面
    UITableView *_chatView;
    //    状态栏及导航栏总高度
    CGFloat _stautsH;
    //    cell高度数组
    NSMutableArray *_cellHeigheArr;
    //    消息文本框
    UITextField *_msgTextField;
    //    发送按钮
    UIButton *_sendButton;
    //    消息数组
    NSMutableArray *_msgArr;
    //    消息数据
    NSMutableDictionary *_msgDic;
    int _messigePage;
    UIImage *_image;
}

@end

@implementation MsgCenViewController



-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _stautsH = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height;
    [self addBackButtonToNavigation];
    self.navigationItem.title = @"消息中心";
    [self addChatViewToView];
    [self addMessgeTextToView];
    /*
     ***  添加键盘监听
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyBoardWillHiden:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hasRedPoint" object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasRecivedNewMessageWithnotification:) name:@"heartBeat" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addClearButtonToNavigation];
    _msgArr = [NSMutableArray array];
    _messigePage = 0;
    NSArray *arr = [ChatMessage getDataFromDBWithUserId:[[IEngine engine].ownerId integerValue] page:_messigePage];
    [self addMessagesToChatViewWithArr:arr];
    _msgDic = [NSMutableDictionary dictionary];
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *refreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - self.view.height, self.view.width, self.view.height)];
        refreshView.delegate = self;
        [_chatView addSubview:refreshView];
        _refreshHeaderView = refreshView;
    }
    [_refreshHeaderView setBackgroundColor:DEFAULT_BACKGROUND_COLOR textColor:DEFAULT_TEXT_COLOR arrowImage:DEFAULT_ARROW_IMAGE];
    [_refreshHeaderView refreshLastUpdatedDate];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addMessagesToChatViewWithArr:(NSArray *)arr {
    for (NSInteger i = 0; i < arr.count; i++) {
        ChatMessage *item = [arr objectAtIndex:i];
        if (i < arr.count - 1) {
            ChatMessage *nextItem = [arr objectAtIndex:i + 1];
            if (item.interval - nextItem.interval > 60) {
                item.needTimeLabel = YES;
            } else {
                item.needTimeLabel = NO;
            }
        } else {
            item.needTimeLabel = YES;
        }
        [_msgArr insertObject:item atIndex:0];
    }
}

-(void)addMessagesToChatViewWithMessages:(ChatMessage *)message {
    ChatMessage *item = [_msgArr lastObject];
    if (message.interval - item.interval > 60) {
        message.needTimeLabel = YES;
    } else {
        message.needTimeLabel = NO;
    }
    [_msgArr addObject:message];
    [_chatView reloadData];
    [_chatView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_msgArr.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}

//添加清屏按钮到导航栏
-(void)addClearButtonToNavigation {
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    clearButton.frame = CGRectMake(0, 0, 40, 30);
    [clearButton setTitle:@"清屏" forState:UIControlStateNormal];
    [clearButton setTitleColor:RGBCOLOR(255, 95, 5) forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(clearAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *clearItem = [[UIBarButtonItem alloc] initWithCustomView:clearButton];
    [self.navigationItem setRightBarButtonItem:clearItem];
}

//添加聊天界面
-(void)addChatViewToView {
    _chatView = [[UITableView alloc] initWithFrame:CGRectMake(0,0 , self.view.frame.size.width, self.view.frame.size.height - 60)];
    _chatView.delegate = self;
    _chatView.dataSource = self;
    _chatView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (_msgArr.count > 5) {
        [_chatView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_msgArr.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    [self.view addSubview:_chatView];
}

-(IBAction)clearAction {
    [ChatMessage deleteFromDBWithOwnerId:[[IEngine engine].ownerId integerValue]];
    [_msgArr removeAllObjects];
    [_chatView reloadData];
}

//添加发送消息界面
-(void)addMessgeTextToView {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 119, ScreenWidth, 59)];
    bgView.backgroundColor = [UIColor whiteColor];
    _msgTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 20, self.view.frame.size.width - 70, 30)];
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 35, self.view.frame.size.width - 90, 10)];
    //    UIImage *image = [UIImage imageWithColor:[UIColor redColor] cornerRadius:1.0];
    lineImageView.image = [UIImage imageNamed:@"iSH_BottomLine"];
    [bgView addSubview:lineImageView];
    [bgView addSubview:_msgTextField];
    [self.view addSubview:bgView];
    _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendButton.frame = CGRectMake(self.view.frame.size.width - 70, 15, 60, 30);
    [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    _sendButton.layer.cornerRadius = 5.0;
    _sendButton.backgroundColor = RGBCOLOR(255, 95, 5);
    [_sendButton addTarget:self action:@selector(sendMessageAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:_sendButton];
}

-(void)sendMessageAction {
    if (_msgTextField.text.hasValue) {
        NSMutableDictionary *msgInfo = [NSMutableDictionary dictionary];
        [msgInfo setObject:_msgTextField.text forKey:@"content"];
        [self startRequest:1];
    }
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_msgArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatMessage *model = [_msgArr objectAtIndex:indexPath.row];
    static NSString *identifier = @"cell";
    MsgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MsgTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.headImg = _image;
    cell.item = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatMessage *model = [_msgArr objectAtIndex:indexPath.row];
    return [MsgTableViewCell heightForMessage:model];
}

#pragma mark - EGORefreshTableHeaderDelegate
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view {
//    _reloading = YES;
//    [_refreshHeaderView startAnimatingWithScrollView:_chatView];
//    下拉加载更多信息
    _messigePage ++;
    NSArray *arr = [ChatMessage getDataFromDBWithUserId:[[IEngine engine].ownerId integerValue] page:_messigePage];
    [self addMessagesToChatViewWithArr:arr];
    [self performSelector:@selector(doneLoadingTableView) withObject:self afterDelay:0.2];
}

/**
 * 隐藏头部view
 */
-(void)doneLoadingTableView {
//    _reloading = NO;
    [_chatView reloadData];
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_chatView];
}

#pragma mark - EGORefreshTableHeaderView

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

//监听事件
-(void)handleKeyBoardWillShow:(NSNotification *)paramNotification {
    NSValue *keyBoardRectAsObject = [[paramNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [keyBoardRectAsObject CGRectValue];
    CGFloat keyBoardHight = keyboardRect.size.height;
    self.view.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height - keyBoardHight, self.view.frame.size.width, self.view.frame.size.height);
}

-(void)handleKeyBoardWillHiden:(NSNotification *)paramNotification {
    self.view.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height, self.view.frame.size.width, self.view.frame.size.height);
}

/**
* 消息监听
*/
-(void)hasRecivedNewMessageWithnotification:(NSNotification *)notification {
    NSDictionary *dic = notification.userInfo;
    NSString *text = [dic getStringValueForKey:@"content" defaultValue:nil];
    NSString *time = [dic getStringValueForKey:@"create_time" defaultValue:nil];
    ChatMessage *massage = [[ChatMessage alloc] initWithText:text time:[time integerValue] status:2];
    [_msgArr addObject:massage];
    [_chatView reloadData];
}

#pragma mark - CCRequest
-(BOOL)startRequest:(NSInteger)requestID {
    if ([super startRequest:requestID]) {
        if (requestID == 0) {
            [_client getListOfMessage];
        } else if (requestID == 1) {
//            [_chatView reloadData];
            [_client postMessegeWithShopId:1 shopName:nil shopLogo:nil content:_msgTextField.text title:nil];
        }
        return YES;
    }
    return NO;
}

-(BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result {
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 1) {
            [_msgTextField resignFirstResponder];
            NSDate *sendDate = [NSDate date];
            NSInteger sendTime = [sendDate timeIntervalSince1970];
            [[MessageManger sharedManager] writeMassegeToDBWithText:_msgTextField.text time:sendTime status:1];
            ChatMessage *message = [[ChatMessage alloc] initWithText:_msgTextField.text time:sendTime status:1];
            [self addMessagesToChatViewWithMessages:message];
//            [_msgArr addObject:message];
//            [_chatView reloadData];
            _msgTextField.text = nil;
        }
        return YES;
    }
    return NO;
}

@end
