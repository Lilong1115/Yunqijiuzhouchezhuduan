//
//  TransportAgreementViewController.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 17/4/20.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import "TransportAgreementViewController.h"

@interface TransportAgreementViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation TransportAgreementViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"运输协议";
    
    self.webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
    
    self.webView.scrollView.bounces = NO;
    
    [self.view addSubview:self.webView];
    
    [self requestData];
}

- (void)requestData {
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:TransportAgreement_URL]]];
    
}

@end
