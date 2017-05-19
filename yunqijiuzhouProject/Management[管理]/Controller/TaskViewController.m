//
//  TaskViewController.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 17/4/21.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//


//查看任务
#import "TaskViewController.h"
#import "CheckInvoiceViewController.h"

@interface TaskViewController ()<WKNavigationDelegate, WKUIDelegate>

@property WKWebViewJavascriptBridge* bridge;
@property (nonatomic, strong) WKWebView *wkWebView;           // webview

@end

@implementation TaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"查看任务";
    
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
    
    self.wkWebView.scrollView.bounces = NO;
    // 注册一下
    
    __weak __typeof(self)weakSelf = self;
    // js调用oc
    //查看装货单
    [_bridge registerHandler:@"selectLoad" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSString *str = (NSString *)data;
        
        [weakSelf toCheckInvoiceWithURLStr:[NSString stringWithFormat:@"%@?orderNum=%@", CheckZhdInvoice_URL, str] title:@"查看装货单"];
        
    }];
    //查看卸货单
    [_bridge registerHandler:@"selectUnload" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSString *str = (NSString *)data;
        
        [weakSelf toCheckInvoiceWithURLStr:[NSString stringWithFormat:@"%@?orderNum=%@", CheckXhdInvoice_URL, str] title:@"查看卸货单"];
        
    }];
    /*
     // oc调用js
     [_bridge callHandler:@"getCodeScan" data:@"oc调用js端方法" responseCallback:^(id responseData) {
     //
     NSLog(@"responseData===%@==",responseData);
     }];
     
     */
    
    [self loadExamplePage:self.wkWebView];
}

- (void)toCheckInvoiceWithURLStr:(NSString *)urlStr title:(NSString *)title {

    CheckInvoiceViewController *vc = [[CheckInvoiceViewController alloc]init];
    
    vc.invoiceStr = urlStr;
    vc.title = title;
    
    [self.navigationController pushViewController:vc animated:YES];
}

// 加载h5
- (void)loadExamplePage:(WKWebView*)webView {
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.taskStr]]];
    
}


//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
//    
//    [SVProgressHUD showWithStatus:@"正在加载..."];
//    
//}
//
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    
//    [SVProgressHUD dismiss];
//}

/*
    selectLoad 查看装货单
 
    selectUnload 查看卸货单
 */

@end
