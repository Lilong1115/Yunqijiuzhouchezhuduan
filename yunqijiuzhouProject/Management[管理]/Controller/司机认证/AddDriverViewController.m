//
//  AddDriverViewController.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 17/4/25.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import "AddDriverViewController.h"
#import "UserInfo.h"

@interface AddDriverViewController ()<WKNavigationDelegate, WKUIDelegate>

@property WKWebViewJavascriptBridge* bridge;
@property (nonatomic, strong) WKWebView *wkWebView;           // webview

@end

@implementation AddDriverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpWKWebView];
    //提示消失时通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedResponder:) name:SVProgressHUDDidDisappearNotification object:nil];
}

//提示信息后响应
- (void)selectedResponder:(NSNotification *)noti {
    
    NSString *hudStr = noti.userInfo[SVProgressHUDStatusUserInfoKey];
    
    if ([hudStr isEqualToString:@"添加成功"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
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
    self.wkWebView =  [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 64)];
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.UIDelegate = self;
    [self.view addSubview:self.wkWebView];
    [WKWebViewJavascriptBridge enableLogging];
    _bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.wkWebView];
    [_bridge setWebViewDelegate:self];
    
    self.wkWebView.scrollView.bounces = NO;
    
    //确认添加
    [_bridge registerHandler:@"submit" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        
        NSString *str = (NSString *)data;
        
        if ([str isEqualToString:@"true"]) {
            [SVProgressHUD dismissWithCompletion:^{
                [LLGHUD showSuccessWithStatus:@"添加成功"];
            }];
        } else {
            [SVProgressHUD dismissWithCompletion:^{
                [LLGHUD showErrorWithStatus:@"添加失败"];
            }];
        }
        
    }];
    
    //出发加载
    [_bridge registerHandler:@"wait" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        [SVProgressHUD showWithStatus:@"正在添加..."];
        
    }];
    
    
    [self loadExamplePage:self.wkWebView];
}


// 加载h5
- (void)loadExamplePage:(WKWebView*)webView {
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", AddDriver_URL, GetUuid]]]];
    
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
 
 */

@end
