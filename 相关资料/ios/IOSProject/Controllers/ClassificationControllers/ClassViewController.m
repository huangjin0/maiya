//
//  ClassViewController.m
//  IOSProject
//
//  Created by IOS004 on 15/8/10.
//  Copyright (c) 2015年 CC Inc. All rights reserved.
//

#import "ClassViewController.h"

@interface ClassViewController () {
    NSMutableArray *_classOneArr;
}

@end

@implementation ClassViewController

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
    [rightbtn setBackgroundImage:[UIImage imageNamed:@"mynews_ic_normal"] forState:UIControlStateNormal];
//    [rightbtn addTarget:self action:@selector(rightBtnMessage) forControlEvents:UIControlEventTouchUpInside];
    rightbtn.frame = CGRectMake(10, 0, 20, 20);
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    UIButton * searchbtn = [[UIButton alloc] init];
    [searchbtn setBackgroundImage:[UIImage imageNamed:@"search__@3x"] forState:UIControlStateNormal];
//    [searchbtn addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    searchbtn.frame = CGRectMake(50, 10, 200, 30);
    self.navigationItem.titleView = searchbtn;
    [self startRequest:0];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)startRequest:(NSInteger)requestID {
    if ([super startRequest:requestID]) {
        if (requestID == 0) {
            [_client getTheProduct];
        }
        return YES;
    }
    return NO;
}

-(BOOL)client:(CCClient *)sender didFinishLoadingWithResult:(id)result {
    if ([super client:sender didFinishLoadingWithResult:result]) {
        if (sender.requestID == 0) {
            NSArray *data = [result getArrayForKey:@"data"];
            for (NSDictionary *dic in data) {
                NSString *pidStr = [dic getStringValueForKey:@"p_id" defaultValue:nil];
                if ([pidStr integerValue] == 0) {
                    NSMutableDictionary *classOneDic = [NSMutableDictionary dictionary];
                    [classOneDic setObject:[dic getStringValueForKey:@"cate_name" defaultValue:nil] forKey:@"dockName"];
                    [classOneDic setObject:[dic getStringValueForKey:@"image" defaultValue:nil] forKey:@"imageName"];
                    [classOneDic setObject:[dic getStringValueForKey:@"cart_id" defaultValue:nil] forKey:@"cart_id"];
                    [_classOneArr addObject:classOneDic];
                }
            }
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
