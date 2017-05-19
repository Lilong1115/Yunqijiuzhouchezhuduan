//
//  ShippingDetailsViewController.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/18.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import "ShippingDetailsViewController.h"
#import "UserInfo.h"
#import "CallPhone.h"

@interface ShippingDetailsViewController ()<WKNavigationDelegate, WKUIDelegate>

@property WKWebViewJavascriptBridge* bridge;
@property (nonatomic, strong) WKWebView *wkWebView;           // webview

@end

@implementation ShippingDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"运费详情";
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
    
    //电话
    [_bridge registerHandler:@"call" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSString *str = (NSString *)data;
        
        [CallPhone callPhoneWithPhoneStr:str];
        
    }];
    
    
    
    [self loadExamplePage:self.wkWebView];
}

// 加载h5
- (void)loadExamplePage:(WKWebView*)webView {
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", Base_URL, self.urlStr]]]];
    
}

@end
