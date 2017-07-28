//
//  DriverViewController.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 17/4/20.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import "DriverViewController.h"
#import "NavMapViewController.h"
#import "UserInfo.h"
#import "MAMapKit/MAMapKit.h"
#import "AMapFoundationKit/AMapFoundationKit.h"
#import "AMapSearchKit/AMapSearchKit.h"
#import "AMapNaviKit/AMapNaviKit.h"
#import "AMapLocationKit/AMapLocationKit.h"
#import "CallPhone.h"
#import "AddZhdViewController.h"
#import "AddXhdViewController.h"

@interface DriverViewController ()<WKNavigationDelegate, WKUIDelegate, AMapLocationManagerDelegate>

@property WKWebViewJavascriptBridge* bridge;
@property (nonatomic, strong) WKWebView *wkWebView;           // webview

//定位管理
@property (nonatomic, strong) AMapLocationManager *locationManager;

//定位字典
/*
 x1 = "116.340786,40.047916"; 任务一卸货点
 x2 = "";                     任务二卸货点
 z1 = "116.340864,40.048161"; 任务一装货点
 z2 = "";                     任务二装货点
 zt1 = 3;                     任务一状态码
 zt2 = "";                    任务二状态码
 bh          编号
 */
@property (nonatomic, copy) NSDictionary *location1Dict;
@property (nonatomic, copy) NSDictionary *location2Dict;
//任务一坐标
@property (nonatomic, copy) NSString *task1Location;
//任务二坐标
@property (nonatomic, copy) NSString *task2Location;

//是否发送了到达任务一装货
@property (nonatomic, assign) BOOL isSendLocation1;

//是否发送了到达任务二装货
@property (nonatomic, assign) BOOL isSendLocation2;

//是否发送了到达任务一卸货
@property (nonatomic, assign) BOOL isLocation1;

//是否发送了到达任务二卸货
@property (nonatomic, assign) BOOL isLocation2;

@property (nonatomic, copy) NSString *nowLocationStr;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@end

@implementation DriverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置默认值
    self.isSendLocation1 = NO;
    self.isSendLocation2 = NO;
    self.isLocation1 = NO;
    self.isLocation2 = NO;

    
    //设置webview
    [self setUpWKWebView];
    
    //定位
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    //距离
    self.locationManager.distanceFilter = 1;
    
//    //注册通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeZhd:) name:ZHDNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeHhd:) name:XHDNotification object:nil];
    
}

////装货单
//- (void)changeZhd:(NSNotification *)noti {
//
//    self.isSendLocation1 = YES;
//    self.isSendLocation2 = YES;
//    
//}
//
////卸货单
//- (void)changeHhd:(NSNotification *)noti {
//
//    self.isLocation1 = YES;
//    self.isLocation2 = YES;
//}

//切换任务
- (IBAction)clickSegment:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 0) {
        [self loadExamplePage:self.wkWebView urlStr:DriverNow_URL];
    } else {
        [self loadExamplePage:self.wkWebView urlStr:DriverHistory_URL];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
    
- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
    [self.wkWebView.scrollView.mj_header beginRefreshing];
}

// viewWillAppear和viewWillDisappear对setWebViewDelegate处理，不处理会导致内存泄漏
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //[self loadExamplePage:self.wkWebView urlStr:DriverNow_URL];
    
    if (self.bridge) {
        [self.bridge setWebViewDelegate:self];
        //地理位置
        [_bridge callHandler:@"orderTasks" data:@"oc调用js端方法" responseCallback:^(id responseData) {
            
            NSArray *array = (NSArray *)responseData;
            
            //NSLog(@"%@, %@", array.firstObject, array.lastObject);
            
            self.location1Dict = array.firstObject;
            self.location2Dict = array.lastObject;
            
            [self setLoction];
        }];
    }
    
    [self setLoction];
    
    //开启定位
    [self.locationManager startUpdatingLocation];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.bridge setWebViewDelegate:nil];
    
    //停止定位
    [self.locationManager stopUpdatingLocation];
}

// 第一界面中dealloc中移除监听的事件
- (void)dealloc{
    // 移除当前对象监听的事件
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//设置webview
- (void)setUpWKWebView {
    self.wkWebView =  [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 64)];
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.UIDelegate = self;
    [self.view addSubview:self.wkWebView];
    
    [WKWebViewJavascriptBridge enableLogging];
    _bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.wkWebView];
    [_bridge setWebViewDelegate:self];
    
    
    self.wkWebView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if (self.segment.selectedSegmentIndex == 0) {
            [self loadExamplePage:self.wkWebView urlStr:DriverNow_URL];
            
            [_bridge callHandler:@"orderTasks" data:@"oc调用js端方法" responseCallback:^(id responseData) {
                
                NSArray *array = (NSArray *)responseData;
                
                //NSLog(@"%@, %@", array.firstObject, array.lastObject);
                
                self.location1Dict = array.firstObject;
                self.location2Dict = array.lastObject;
                
                [self setLoction];
                
            }];
            
        } else {
            [self loadExamplePage:self.wkWebView urlStr:DriverHistory_URL];
        }
//        [self.wkWebView.scrollView.mj_header endRefreshing];
    }];
    
    //地理位置
    [_bridge callHandler:@"orderTasks" data:@"oc调用js端方法" responseCallback:^(id responseData) {
        
        NSArray *array = (NSArray *)responseData;
        
        //NSLog(@"%@, %@", array.firstObject, array.lastObject);
        
        self.location1Dict = array.firstObject;
        self.location2Dict = array.lastObject;
        
        [self setLoction];
        
    }];
    
    //电话
    [_bridge registerHandler:@"zhuanyuan" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        
        NSString *phoneStr = (NSString *)data;
        [CallPhone callPhoneWithPhoneStr:phoneStr];
    }];
    
    //填写装货单
    [_bridge registerHandler:@"addzhd" handler:^(id data, WVJBResponseCallback responseCallback) {

        
        NSString *orderID = (NSString *)data;
        
        AddZhdViewController *zhdVC = [[AddZhdViewController alloc]init];
        
        zhdVC.orderID = orderID;
        
        [self.navigationController pushViewController:zhdVC animated:YES];
        
    }];
    
    //填写卸货单
    [_bridge registerHandler:@"addxhd" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        
        NSString *orderID = (NSString *)data;
        
        AddXhdViewController *xhdVC = [[AddXhdViewController alloc]init];
        
        xhdVC.orderID = orderID;
        
        [self.navigationController pushViewController:xhdVC animated:YES];
        
    }];
    
    //点击我已到达装货
    [_bridge registerHandler:@"update" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        [self loadExamplePage:self.wkWebView urlStr:DriverNow_URL];
        
    }];
    
    //导航
    [_bridge registerHandler:@"Navigation" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        

        NSString *str = (NSString *)data;
        NSString *endPointStr;
        if ([str isEqualToString:self.location1Dict[@"bh"]]) {
            endPointStr = self.task1Location;
        } else {
            endPointStr = self.task2Location;
        }
        
  
         NavMapViewController *navMapVC = [[NavMapViewController alloc]init];
         
         navMapVC.endPointStr = endPointStr;
         
         [self.navigationController pushViewController:navMapVC animated:YES];
        
    }];
    
    
    [self loadExamplePage:self.wkWebView urlStr:DriverNow_URL];
}





// 加载h5
- (void)loadExamplePage:(WKWebView*)webView urlStr:(NSString *)urlStr {
    
    //加载司机当前任务
    //参数 uuid 用户id  pageSize
    NSString *orderManagement = [NSString stringWithFormat:@"%@?uuid=%@&pageSize=0", urlStr, GetUuid];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:orderManagement]]];
    
}



//获取定位信息
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode {
    //NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    
    
    self.nowLocationStr = [NSString stringWithFormat:@"%f,%f", location.coordinate.longitude, location.coordinate.latitude];
    
    //1.将两个经纬度点转成投影点
    
    MAMapPoint minePoint = MAMapPointForCoordinate(location.coordinate);
    
    
    //[self setLoction];
    
    //判断是否有位置信息
    if (self.task1Location) {
        CLLocationCoordinate2D task1Coordnate = [self creatLocationWithStr:self.task1Location];
        MAMapPoint task1LocationPoint = MAMapPointForCoordinate(task1Coordnate);
        //2.计算距离
        CLLocationDistance distance1 = MAMetersBetweenMapPoints(minePoint,task1LocationPoint);
        
        NSLog(@"1: %f", distance1);
        
        if (distance1 <= 1000000000000000) {
            
            self.isSendLocation1 = YES;
            
            if (self.isSendLocation1 == YES) {
                
                NSString *sendStr = [self creatSendStrWithBH:self.location1Dict[@"bh"] coordinate:location.coordinate];
                
                //我已到达装货启用
                [_bridge callHandler:@"updateLoadBtnState" data:sendStr responseCallback:^(id responseData) {
                    
                   // NSString *str = (NSString *)responseData;
                    
                    //NSLog(@"%@", str);
                    
                }];
                
                
                self.isSendLocation1 = NO;
            }
            
            self.isLocation1 = YES;
            
            if (self.isLocation1 == YES) {
                
                NSString *sendStr = [self creatSendStrWithBH:self.location1Dict[@"bh"] coordinate:location.coordinate];
                
                //我已到达卸货启用
                [_bridge callHandler:@"updateDischargeState" data:sendStr responseCallback:^(id responseData) {
                    
                }];
                
                self.isLocation1 = NO;
            }
            
        }
    }
    
    if (self.task2Location) {
        CLLocationCoordinate2D task2Coordnate = [self creatLocationWithStr:self.task2Location];
 
        MAMapPoint task2LocationPoint = MAMapPointForCoordinate(task2Coordnate);
        
        CLLocationDistance distance2 = MAMetersBetweenMapPoints(minePoint,task2LocationPoint);
        NSLog(@"2: %f", distance2);
        
        if (distance2 <= 1000000000000000) {
            
            self.isSendLocation2 = YES;
            
            if (self.isSendLocation2 == YES) {
                
                NSString *sendStr = [self creatSendStrWithBH:self.location2Dict[@"bh"] coordinate:location.coordinate];
                
                [_bridge callHandler:@"updateLoadBtnState" data:sendStr responseCallback:^(id responseData) {
                    
                }];
                
//                //我已到达卸货启用
//                [_bridge callHandler:@"updateDischargeState" data:sendStr responseCallback:^(id responseData) {
//                    
//                    
//                }];
                
                self.isSendLocation2 = NO;
            }
            
            self.isLocation2 = YES;
            
            if (self.isLocation2 == YES) {
                
                NSString *sendStr = [self creatSendStrWithBH:self.location2Dict[@"bh"] coordinate:location.coordinate];
                
                //我已到达卸货启用
                [_bridge callHandler:@"updateDischargeState" data:sendStr responseCallback:^(id responseData) {
                    
                }];
                
                self.isLocation2 = NO;
            }
            
        }
    }

    
}


//编号和坐标转为字符串
- (NSString *)creatSendStrWithBH:(NSString *)BH coordinate:(CLLocationCoordinate2D)coordinate {

    CLLocationDegrees latitude = coordinate.latitude;
    CLLocationDegrees longitude = coordinate.longitude;
    
    NSString *sendStr = [NSString stringWithFormat:@"%@;%@-%@", BH, [NSString stringWithFormat:@"%f",longitude], [NSString stringWithFormat:@"%f",latitude]];
    
    return sendStr;
    
}

//字符串转坐标
- (CLLocationCoordinate2D)creatLocationWithStr:(NSString *)locationStr {

    NSArray *array = [locationStr componentsSeparatedByString:@","]; //从字符A中分隔成2个元素的数组
    //NSLog(@"array:%@",array); //结果是adfsfsfs和dfsdf
    
    NSString *firstStr = array.firstObject;
    NSString *lastStr = array.lastObject;
    
    CLLocationDegrees longitude = [firstStr floatValue];
    CLLocationDegrees latitude = [lastStr floatValue];
    
    CLLocationCoordinate2D coordinate2D = {
        latitude,
        longitude
    };
    
    return coordinate2D;
    
    
}

//设置坐标
- (void)setLoction {
    
    if ([self.location1Dict[@"zt1"] isEqualToString:@"0"]) {
        self.task1Location = self.location1Dict[@"z1"];
    } else {
        self.task1Location = self.location1Dict[@"x1"];
    }
    
    if ([self.location2Dict[@"zt2"] isEqualToString:@"0"]) {
        self.task2Location = self.location2Dict[@"z2"];
    } else {
        self.task2Location = self.location2Dict[@"x2"];
    }
    
}

LoadWebViewHUD

/*
  orderTasks 任务经纬度
 updateLoadBtnState 装货地附近
 */

/*
 ysdjhxxzt ,运输单状态 0:已分配 1：已装货 2：已卸货 3：已完成 4：已终止 11:装货已到达 21：卸货已到达
 */

@end
