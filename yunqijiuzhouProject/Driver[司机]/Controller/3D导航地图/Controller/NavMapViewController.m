//
//  NavMapViewController.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 17/4/21.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import "NavMapViewController.h"
#import "MAMapKit/MAMapKit.h"
#import "AMapFoundationKit/AMapFoundationKit.h"
#import "AMapSearchKit/AMapSearchKit.h"
#import "AMapNaviKit/AMapNaviKit.h"

//不带界面的语音合成控件
#import <iflyMSC/IFlySpeechSynthesizerDelegate.h>
#import <iflyMSC/IFlySpeechSynthesizer.h>
#import <iflyMSC/IFlyMSC.h>
//需要实现IFlySpeechSynthesizerDelegate，为合成会话的服务代理
@interface NavMapViewController ()<AMapNaviDriveViewDelegate, AMapNaviDriveManagerDelegate, MAMapViewDelegate, IFlySpeechSynthesizerDelegate>

@property (nonatomic, strong) AMapNaviDriveView *driveView;

@property (nonatomic, strong) AMapNaviDriveManager *driveManager;

@property (nonatomic, strong) AMapNaviPoint *endPoint;

@property (nonatomic, strong) MAMapView *mapView;

//语音导航
@property (nonatomic, strong) IFlySpeechSynthesizer *iFlySpeechSynthesizer;

@end

@implementation NavMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"导航";
    
    [self initDriveView];
    
    [self initDriveManager];
    
    [self initProperties];
    
    [self.driveManager calculateDriveRouteWithEndPoints:@[self.endPoint] wayPoints:nil drivingStrategy:AMapNaviDrivingStrategySingleDefault];
    
}

- (void)initProperties
{
    NSArray *array = [self.endPointStr componentsSeparatedByString:@","]; //从字符A中分隔成2个元素的数组
    //NSLog(@"array:%@",array); //结果是adfsfsfs和dfsdf
    
    self.endPoint = [AMapNaviPoint locationWithLatitude:[array.lastObject floatValue] longitude:[array.firstObject floatValue]];
}



- (void)initDriveView
{
    if (self.driveView == nil)
    {
        self.driveView = [[AMapNaviDriveView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        self.driveView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.driveView setDelegate:self];
        
        [self.view addSubview:self.driveView];
    }
}

- (void)initDriveManager
{
    if (self.driveManager == nil)
    {
        self.driveManager = [[AMapNaviDriveManager alloc] init];
        [self.driveManager setDelegate:self];
        
        //将driveView添加为导航数据的Representative，使其可以接收到导航诱导数据
        [self.driveManager addDataRepresentative:self.driveView];
        
    }
}


- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"导航开始");
    
    //算路成功后开始GPS导航
    [self.driveManager startGPSNavi];
    
    // 创建合成对象，为单例模式
    self.iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    self.iFlySpeechSynthesizer.delegate = self;
    
    //设置语音合成的参数
    //语速,取值范围 0~100
    [self.iFlySpeechSynthesizer setParameter:@"50" forKey:[IFlySpeechConstant SPEED]];
    //音量;取值范围 0~100
    [self.iFlySpeechSynthesizer setParameter:@"100" forKey: [IFlySpeechConstant VOLUME]];
    //发音人,默认为”xiaoyan”;可以设置的参数列表可参考个 性化发音人列表
    [self.iFlySpeechSynthesizer setParameter:@"xiaoyan" forKey: [IFlySpeechConstant VOICE_NAME]];
    //音频采样率,目前支持的采样率有 16000 和 8000
    [self.iFlySpeechSynthesizer setParameter:@"8000" forKey: [IFlySpeechConstant SAMPLE_RATE]];
    //asr_audio_path保存录音文件路径，如不再需要，设置value为nil表示取消，默认目录是documents
    [self.iFlySpeechSynthesizer setParameter:nil forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];
    
    //启动合成会话
    //[self.iFlySpeechSynthesizer startSpeaking:@"你好，我是科大讯飞的小燕"];
    
} 

- (BOOL)driveManagerIsNaviSoundPlaying:(AMapNaviDriveManager *)driveManager
{
    return [self.iFlySpeechSynthesizer isSpeaking];
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType
{
    //NSLog(@"playNaviSoundString:{%ld:%@}", (long)soundStringType, soundString);
    
    [self.iFlySpeechSynthesizer startSpeaking:soundString];
}


- (void)dealloc {

    [self.driveManager stopNavi];
    [self.iFlySpeechSynthesizer stopSpeaking];
    //self.iFlySpeechSynthesizer = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//合成结束，此代理必须要实现
- (void) onCompleted:(IFlySpeechError *) error{}
//合成开始
- (void) onSpeakBegin{}
//合成缓冲进度
- (void) onBufferProgress:(int) progress message:(NSString *)msg{}
//合成播放进度
- (void) onSpeakProgress:(int) progress{}


@end
