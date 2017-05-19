//
//  GoodsTypesViewController.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/2.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

//货源详情
#import "GoodsTypesViewController.h"
#import "CallPhone.h"
#import "SendCarsViewController.h"

@interface GoodsTypesViewController ()<WKNavigationDelegate, WKUIDelegate>

@property WKWebViewJavascriptBridge* bridge;
@property (nonatomic, strong) WKWebView *wkWebView;           // webview


@end

@implementation GoodsTypesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.title = @"货源详情";
   
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
    self.wkWebView =  [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 64)];
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.UIDelegate = self;
    [self.view addSubview:self.wkWebView];
    [WKWebViewJavascriptBridge enableLogging];
    _bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.wkWebView];
    [_bridge setWebViewDelegate:self];
    
    self.wkWebView.scrollView.bounces = NO;
    
    //电话
    [_bridge registerHandler:@"OperateTelephone" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSString *phone = (NSString *)data;
        
        [CallPhone callPhoneWithPhoneStr:phone];
        
    }];
    
    //派车报价
    [_bridge registerHandler:@"SendJh" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSDictionary *sendCarsDict = (NSDictionary *)data;
        
        //NSLog(@"dict %@", sendCarsDict);
        
        SendCarsViewController *vc = [[SendCarsViewController alloc]init];
        
        vc.sendCarDict = sendCarsDict;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    [self loadExamplePage:self.wkWebView];
}

// 加载h5
- (void)loadExamplePage:(WKWebView*)webView {
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", GoodsTypes_URL, self.goodsTypesID]]]];
    
    //@"http://192.168.100.169:8080/antu/MovewebhomeCon.con/index"
    
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
