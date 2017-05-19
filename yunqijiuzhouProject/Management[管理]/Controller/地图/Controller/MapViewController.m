//
//  MapViewController.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 17/4/14.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import "MapViewController.h"
#import "MAMapKit/MAMapKit.h"
#import "AMapFoundationKit/AMapFoundationKit.h"
#import "AMapSearchKit/AMapSearchKit.h"


@interface MapViewController ()<MAMapViewDelegate, AMapSearchDelegate>

//地图
@property (nonatomic, strong) MAMapView *mapView;

//第一个定位
@property (nonatomic, assign) CLLocationCoordinate2D coordinate2D;
@end

@implementation MapViewController


- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
    //缩放比例
    [self.mapView setZoomLevel:16 animated:YES];
    
    //调整中心
    [self.mapView setCenterCoordinate:self.coordinate2D animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"定位";
    
    ///初始化地图
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    
    self.mapView.showsCompass = NO;
    self.mapView.showsScale = NO;
    
    self.mapView.delegate = self;
    
    ///把地图添加至view
    [self.view addSubview:self.mapView];
    
    [self.coordinate2DArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSArray *array = [obj componentsSeparatedByString:@","]; //从字符A中分隔成2个元素的数组
        //NSLog(@"array:%@",array); //结果是adfsfsfs和dfsdf
        
        NSString *firstStr = array.firstObject;
        NSString *lastStr = array.lastObject;
        
        CLLocationDegrees longitude = [firstStr floatValue];
        CLLocationDegrees latitude = [lastStr floatValue];
        
        CLLocationCoordinate2D coordinate2D = {
            latitude,
            longitude
        };
        
        if (idx == 0) {
            self.coordinate2D = coordinate2D;
        }
        
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc]init];
        pointAnnotation.coordinate = coordinate2D;
        [self.mapView addAnnotation:pointAnnotation];
        
    }];
    
    
}



//地图代理方法
//修改图标
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"ygc"];
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    
    return nil;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
