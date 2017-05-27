//
//  AddXhdViewController.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 17/4/25.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import "AddXhdViewController.h"
#import "UserInfo.h"

@interface AddXhdViewController ()<WKNavigationDelegate, WKUIDelegate>

@property WKWebViewJavascriptBridge* bridge;
@property (nonatomic, strong) WKWebView *wkWebView;           // webview



@end

@implementation AddXhdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"卸货单";
    
    //设置webview
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

//设置webview
- (void)setUpWKWebView {
    self.wkWebView =  [[WKWebView alloc] initWithFrame:self.view.bounds];
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.UIDelegate = self;
    [self.view addSubview:self.wkWebView];
    
    
    [WKWebViewJavascriptBridge enableLogging];
    _bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.wkWebView];
    [_bridge setWebViewDelegate:self];
    self.wkWebView.scrollView.bounces = NO;
    //提交按钮返回
    [_bridge registerHandler:@"ReturnCurrenttask" handler:^(id data, WVJBResponseCallback responseCallback) {
        
//        [SVProgressHUD showWithStatus:@"正在提交..."];
        NSString *str = (NSString *)data;
        if ([str isEqualToString:@"true"]) {
            [LLGHUD showSuccessWithStatus:@"提交成功"];
            
//            //创建通知
//            NSNotification *notification =[NSNotification notificationWithName:XHDNotification object:nil userInfo:nil];
//            
//            //通过通知中心发送通知
//            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            
            [LLGHUD showErrorWithStatus:@"提交失败"];
        }
        
    }];
    
    [_bridge registerHandler:@"Circlestart" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        [SVProgressHUD showWithStatus:@"正在提交..."];
    }];
    
    [self loadExamplePage:self.wkWebView urlStr:ReadXhdInvoice_URL];
}


// 加载h5
- (void)loadExamplePage:(WKWebView*)webView urlStr:(NSString *)urlStr {
    
    //加载司机当前任务
    //参数 uuid 用户id  pageSize
    NSString *orderManagement = [NSString stringWithFormat:@"%@%@;uuid:%@;ygsjh:%@", urlStr, self.orderID, GetUuid, [UserInfo account].phone];
    
    NSLog(@"%@", orderManagement);
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:orderManagement]]];
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

@end
