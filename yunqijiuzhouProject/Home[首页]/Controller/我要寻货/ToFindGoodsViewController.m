//
//  ToFindGoodsViewController.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 17/4/28.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

//货源
#import "ToFindGoodsViewController.h"
#import "UserInfo.h"
#import "SearchView.h"
#import "GoodsTypesViewController.h"

@interface ToFindGoodsViewController ()<WKNavigationDelegate, WKUIDelegate>

@property WKWebViewJavascriptBridge* bridge;
@property (nonatomic, strong) WKWebView *wkWebView;           // webview


//搜索视图
@property (nonatomic, strong) SearchView *searchView;

@end

@implementation ToFindGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.title = @"货源";
    
    self.searchView = [[SearchView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    [self.view addSubview:self.searchView];
    
    //回传数据
    __weak ToFindGoodsViewController *weakSelf = self;
    self.searchView.sendBlock = ^(NSString *sendStr){
        __block ToFindGoodsViewController *strongSelf = weakSelf;
        NSLog(@"%@", sendStr);
        
        [strongSelf.bridge callHandler:@"querygoodsList" data:sendStr responseCallback:^(id responseData) {
            
        }];
        
    };
    
    
    [self setUpWKWebView];
    
    
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
    [SVProgressHUD dismiss];
}

- (void)dealloc
{
    NSLog(@"dealloc==dealloc==");
}

- (void)setUpWKWebView {
    self.wkWebView =  [[WKWebView alloc] initWithFrame:CGRectMake(0, 40, ScreenW, ScreenH - 40 - 64)];
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.UIDelegate = self;
    [self.view addSubview:self.wkWebView];
    [WKWebViewJavascriptBridge enableLogging];
    _bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.wkWebView];
    [_bridge setWebViewDelegate:self];
    
    self.wkWebView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadExamplePage:self.wkWebView];
        [self.wkWebView.scrollView.mj_header endRefreshing];
    }];

    //货源详情
    [_bridge registerHandler:@"Jumpxhwith" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSString *goodsTypesID = (NSString *)data;
        
        GoodsTypesViewController *vc = [[GoodsTypesViewController alloc]init];
        
        vc.goodsTypesID = goodsTypesID;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    [self loadExamplePage:self.wkWebView];
}

// 加载h5
- (void)loadExamplePage:(WKWebView*)webView {
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ToFindGoods_URL]]];
    
    //@"http://192.168.100.169:8080/antu/MovewebhomeCon.con/index"
    
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {

    [SVProgressHUD showWithStatus:@"正在加载..."];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {

    [SVProgressHUD dismiss];
    
}



@end
