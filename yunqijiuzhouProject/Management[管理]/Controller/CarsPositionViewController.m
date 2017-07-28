//
//  CarsPositionViewController.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 17/4/21.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import "CarsPositionViewController.h"
#import "MapViewController.h"

@interface CarsPositionViewController ()<WKNavigationDelegate, WKUIDelegate>

@property WKWebViewJavascriptBridge* bridge;
@property (nonatomic, strong) WKWebView *wkWebView;           // webview

@end

@implementation CarsPositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"车辆定位";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"查看全部" style:UIBarButtonItemStylePlain target:self action:@selector(seeAll)];
    
    [self setUpWKWebView];
}

- (void)seeAll {

    NSLog(@"查看全部");
    
    NSDictionary *dict = @{
                           @"orderNum": self.orderNum
                           };
    
    //全部定位
    [[XSJNetworkTool sharedNetworkTool]requestDataWithRequestType:GET andUrlString:AllCarsPosition_URL andParameters:dict andSuccessBlock:^(id result) {
        
        //NSLog(@"result %@", result);
        //解析数据
        NSArray *array = (NSArray *)result;
        NSMutableArray *arrayM = [NSMutableArray array];
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //NSLog(@"%@", obj);
            
            id data = obj[@"yhjwd"];
            
            if ([data isKindOfClass:[NSNull class]]) {
                
            } else {
            
                NSString *str = (NSString *)data;
                [arrayM addObject:str];
            }
            
            //NSLog(@"%@", arrayM.copy);
            if (arrayM.count == 0) {
                [LLGHUD showErrorWithStatus:@"无法定位"];
                
            } else {
                
                MapViewController *mapVC = [[MapViewController alloc]init];
                
                mapVC.coordinate2DArray = arrayM.copy;
                
                [self.navigationController pushViewController:mapVC animated:YES];
            }
            
        }];
        
    } andFailBlock:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// viewWillAppear和viewWillDisappear对setWebViewDelegate处理，不处理会导致内存泄漏
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.bridge) {
        [self.bridge setWebViewDelegate:self];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.bridge setWebViewDelegate:nil];
}

- (void)dealloc
{
    NSLog(@"dealloc==dealloc==");
}

- (void)setUpWKWebView {
    self.wkWebView =  [[WKWebView alloc] initWithFrame:self.view.bounds];
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.UIDelegate = self;
    [self.view addSubview:self.wkWebView];
    [WKWebViewJavascriptBridge enableLogging];
    _bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.wkWebView];
    [_bridge setWebViewDelegate:self];
    
    //self.wkWebView.scrollView.bounces = NO;
    
    self.wkWebView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadExamplePage:self.wkWebView];
//        [self.wkWebView.scrollView.mj_header endRefreshing];
    }];
    
    __weak __typeof(self)weakSelf = self;
    //定位
    [_bridge registerHandler:@"carPosition" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSString *str = (NSString *)data;
        
        NSLog(@"%@", str);
        
        if ([str isEqualToString:@"1001"]) {
            [LLGHUD showErrorWithStatus:@"无法定位"];
            
        } else {
            
            MapViewController *mapVC = [[MapViewController alloc]init];
            
            mapVC.coordinate2DArray = @[str];
            
            [weakSelf.navigationController pushViewController:mapVC animated:YES];
        }
        
        
    }];
    
    
    
    [self loadExamplePage:self.wkWebView];
}

// 加载h5
- (void)loadExamplePage:(WKWebView*)webView {
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.carsPositionStr]]];
    
}

LoadWebViewHUD

/*
  carPosition 定位
 */

@end
