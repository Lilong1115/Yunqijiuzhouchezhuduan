//
//  OrderViewController.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 17/4/20.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import "OrderViewController.h"
#import "CallPhone.h"
#import "TransportAgreementViewController.h"
#import "TaskViewController.h"
#import "UserInfo.h"

@interface OrderViewController ()<WKNavigationDelegate, WKUIDelegate>

@property WKWebViewJavascriptBridge* bridge;
@property (nonatomic, strong) WKWebView *wkWebView;           // webview

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self setUpWKWebView];
    
    UIButton *callPhone = [UIButton creatButtonWithTitle:@"联系运营专员" imageName:@"tel" color:[UIColor blackColor]];
    [callPhone addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
    UIButton *checkInvoice = [UIButton creatButtonWithTitle:@"查看装/卸货单" imageName:@"icon_task" color:[UIColor redColor]];
    [checkInvoice addTarget:self action:@selector(totask) forControlEvents:UIControlEventTouchUpInside];
    
    callPhone.frame = CGRectMake(0, ScreenH - 44 - 64, ScreenW / 2, 44);
    checkInvoice.frame = CGRectMake(ScreenW / 2, ScreenH - 44 - 64, ScreenW / 2, 44);
    
    [self.view addSubview:callPhone];
    [self.view addSubview:checkInvoice];
    
}


//查看装卸货单
- (void)totask {
    
    TaskViewController *taskVC =[[TaskViewController alloc]init];
    
    taskVC.taskStr = [NSString stringWithFormat:@"%@?orderNum=%@&uuid=%@", Task_URL, self.orderNum, GetUuid];
    taskVC.orderNum = self.orderNum;
    
    [self.navigationController pushViewController:taskVC animated:YES];
    
}

- (void)callPhone {

    // oc调用js
 
    [_bridge callHandler:@"orderPhone" data:@"oc调用js端方法" responseCallback:^(id responseData) {
        //
        
        NSString *str = (NSString *)responseData;
        
        //NSLog(@"responseData===%@==",str);
        
        [CallPhone callPhoneWithPhoneStr:str];
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
    
    self.wkWebView.scrollView.bounces = NO;
    
    // 注册一下
    __weak __typeof(self)weakSelf = self;
    
    //运输协议
    [_bridge registerHandler:@"transportAgreement" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        TransportAgreementViewController *vc = [[TransportAgreementViewController alloc]init];
        
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    }];
    
    
    
    [self loadExamplePage:self.wkWebView];
}


// 加载h5
- (void)loadExamplePage:(WKWebView*)webView {
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.orderStr]]];
    
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
  transportAgreement 运输协议
 */

@end
