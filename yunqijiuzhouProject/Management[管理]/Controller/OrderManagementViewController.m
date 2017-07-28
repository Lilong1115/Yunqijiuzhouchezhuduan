//
//  OrderManagementViewController.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 17/4/20.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import "OrderManagementViewController.h"
#import "OrderViewController.h"
#import "XSJScrollrecommendationView.h"
#import "UserInfo.h"
#import "CallPhone.h"
#import "CarsPositionViewController.h"

@interface OrderManagementViewController ()<WKNavigationDelegate, WKUIDelegate>

@property WKWebViewJavascriptBridge* bridge;
@property (nonatomic, strong) WKWebView *wkWebView;           // webview

@property (nonatomic, weak) XSJScrollrecommendationView *scrollView;

//标记选中页面
@property (nonatomic, assign) NSInteger tag;

@end

@implementation OrderManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XSJScrollrecommendationView *scrollView = [[XSJScrollrecommendationView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44)];
    self.tag = 1000;
    
    __weak __typeof(self)weakSelf = self;
    //选择回调
    scrollView.clickTypeBlock = ^(selectedType tag){
    
        weakSelf.tag = tag;
        
        switch (tag) {
            case selectedTypeTodayRecommendation:
                [weakSelf loadExamplePage:weakSelf.wkWebView urlStr:YBJOrderManagement_URL];
                break;
            case selectedTypeOfflineRecommendation:
                [weakSelf loadExamplePage:weakSelf.wkWebView urlStr:YQYOrderManagement_URL];
                break;
            case selectedTypeOnlineRecommendation:
                [weakSelf loadExamplePage:weakSelf.wkWebView urlStr:YWCOrderManagement_URL];
                break;
        }
    };
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
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
    self.wkWebView =  [[WKWebView alloc] initWithFrame:CGRectMake(0, 44, ScreenW, ScreenH - 44 - 64)];
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.UIDelegate = self;
    [self.view addSubview:self.wkWebView];
    
    [WKWebViewJavascriptBridge enableLogging];
    _bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.wkWebView];
    [_bridge setWebViewDelegate:self];
    
    self.wkWebView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        switch (self.tag) {
            case selectedTypeTodayRecommendation:
                [self loadExamplePage:self.wkWebView urlStr:YBJOrderManagement_URL];
                break;
            case selectedTypeOfflineRecommendation:
                [self loadExamplePage:self.wkWebView urlStr:YQYOrderManagement_URL];
                break;
            case selectedTypeOnlineRecommendation:
                [self loadExamplePage:self.wkWebView urlStr:YWCOrderManagement_URL];
                break;
        }
        
        
//        [self.wkWebView.scrollView.mj_header endRefreshing];
    }];
    
    // 注册一下
    
     __weak __typeof(self)weakSelf = self;
     // js调用oc
    //电话
    [_bridge registerHandler:@"call" handler:^(id data, WVJBResponseCallback responseCallback) {
         NSString *phoneStr = (NSString *)data;
         [CallPhone callPhoneWithPhoneStr:phoneStr];
         
    }];
    //详情页
    [_bridge registerHandler:@"orderDetail" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSString *order = (NSString *)data;
        
        NSString *orderStr = [NSString stringWithFormat:@"%@?orderNum=%@&uuid=%@", OrderDetails_URL, order, GetUuid];
        
        OrderViewController *vc = [[OrderViewController alloc]init];
        vc.orderStr = orderStr;
        vc.orderNum = order;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    //取消订单
    [_bridge registerHandler:@"cancelOrder" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSString *order = (NSString *)data;
        
        JCAlertController *alert = [JCAlertController alertWithTitle:@"提示" message:@"确认取消?" type:JCAlertTypeNormal];
        
        [alert addButtonWithTitle:@"取消" type:JCButtonTypeWarning clicked:nil];
        [alert addButtonWithTitle:@"确定" type:JCButtonTypeWarning clicked:^{
            [weakSelf requestOrderStr:order urlStr:CancelOrder_URL successBlock:^(id result) {
                
                if ([result[@"msg"] isEqualToString:@"成功"]) {
                    
                    //NSLog(@"登陆成功");
                    
                    [LLGHUD showSuccessWithStatus:@"取消成功"];
                    
                    [weakSelf loadExamplePage:weakSelf.wkWebView urlStr:YBJOrderManagement_URL];
                    
                } else {
                    
                    [LLGHUD showErrorWithStatus:@"取消失败"];
                }
            } failBlock:^(NSError *error) {
                
                [LLGHUD showErrorWithStatus:@"取消失败"];
            }];
            
        }];
        
        [self jc_presentViewController:alert presentType:JCPresentTypeFIFO presentCompletion:nil dismissCompletion:nil];
        
    }];
    //确认签约
    [_bridge registerHandler:@"signOrder" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        
        NSString *order = (NSString *)data;
        
        JCAlertController *alert = [JCAlertController alertWithTitle:@"提示" message:@"确认签约?" type:JCAlertTypeNormal];
        
        [alert addButtonWithTitle:@"取消" type:JCButtonTypeWarning clicked:nil];
        [alert addButtonWithTitle:@"确定" type:JCButtonTypeWarning clicked:^{
            [weakSelf requestOrderStr:order urlStr:ConfirmOrder_URL successBlock:^(id result) {
                
                if ([result[@"msg"] isEqualToString:@"成功"]) {
                    
                    //NSLog(@"登陆成功");
                    
                    [LLGHUD showSuccessWithStatus:@"签约成功"];
                    
                    [weakSelf loadExamplePage:weakSelf.wkWebView urlStr:YBJOrderManagement_URL];
                    
                } else {
                    
                    [LLGHUD showErrorWithStatus:@"签约失败"];
                }
            } failBlock:^(NSError *error) {
                
                [LLGHUD showErrorWithStatus:@"签约失败"];
            }];
            
        }];
        
        [self jc_presentViewController:alert presentType:JCPresentTypeFIFO presentCompletion:nil dismissCompletion:nil];
        
    }];
    
    //车辆定位
    [_bridge registerHandler:@"carsPosition" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSString *order = (NSString *)data;
        
        NSString *orderStr = [NSString stringWithFormat:@"%@?orderNum=%@&uuid=%@", CarsPosition_URL, order, GetUuid];
        
        CarsPositionViewController *vc = [[CarsPositionViewController alloc]init];
        vc.carsPositionStr = orderStr;
        vc.orderNum = order;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
     /*
     // oc调用js
     [_bridge callHandler:@"getCodeScan" data:@"oc调用js端方法" responseCallback:^(id responseData) {
     //
     NSLog(@"responseData===%@==",responseData);
     }];
     
     */
    
    [self loadExamplePage:self.wkWebView urlStr:YBJOrderManagement_URL];
}


- (void)requestOrderStr:(NSString *)orderStr urlStr:(NSString *)urlStr successBlock:(SucessBlock)sucess failBlock:(FailBlock)fail {

    
    
    NSDictionary *parameters = @{
                                 @"yjbh": orderStr,
                                 @"uuid": GetUuid
                                 };
    
    NSString *json = [NSString ObjectTojsonString:parameters];
    
    //NSLog(@"%@", json);
    
    NSString *jsonBase64 = [NSString jsonBase64WithJson:json];
    
    NSDictionary *dict = @{@"basic": jsonBase64};
    
    //NSLog(@"%@", jsonBase64);
    
    [[XSJNetworkTool sharedNetworkTool] requestDataWithRequestType:POST andUrlString:urlStr andParameters:dict andSuccessBlock:sucess andFailBlock:fail];

}

// 加载h5
- (void)loadExamplePage:(WKWebView*)webView urlStr:(NSString *)urlStr {
    
    //参数 uuid 用户id  pageSize
    NSString *orderManagement = [NSString stringWithFormat:@"%@?uuid=%@&pageSize=0", urlStr, GetUuid];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:orderManagement]]];
}


LoadWebViewHUD

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
  方法名
    orderDetail 订单详情
    call 运营专员
    cancelOrder 取消订单
    signOrder 签约订单
    carsPosition 车辆定位
 */

@end
