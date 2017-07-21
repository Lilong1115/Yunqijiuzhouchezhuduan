//
//  SendCarsViewController.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/2.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import "SendCarsViewController.h"
#import "CallPhone.h"
#import "DailyDispatchTableViewController.h"
#import "SendCarHeaderView.h"
#import "CarInfoTableView.h"
#import "UserInfo.h"
#import "SendCarModel.h"

@interface SendCarsViewController ()

//内容信息
@property (nonatomic, strong) CarInfoTableView *carInfoView;

//头视图
@property (nonatomic, weak) SendCarHeaderView *headerView;

@end

@implementation SendCarsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.title = @"报价与派遣计划";
    
    //NSLog(@"%@", self.sendCarDict[@"rysjh"]);
 
    //头视图
    SendCarHeaderView *headerView = [[SendCarHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 150)];
    headerView.onePrice = self.sendCarDict[@"ysdj"];
    headerView.isOneOrCanOffer = self.sendCarDict[@"sfyj"];
    headerView.totalGoodsStr = self.sendCarDict[@"hwzl"];
    __weak SendCarsViewController *weakSelf = self;
    headerView.sendCarBlock = ^(){
    
        //不得多于两天
        if (self.carInfoView.dataList.count >= 2) {
            [LLGHUD showErrorWithStatus:@"不得多于两天派车"];
            return;
        }
        
        // - 获取storyboard文件
        UIStoryboard *sBoard = [UIStoryboard storyboardWithName:@"DailyDispatch" bundle:nil];
        
        // - 实例化文件中的初始化控制器[或者根据标记实例化控制器]
        // 多态,父类的指针指向之类的对象!
        DailyDispatchTableViewController *vc = [sBoard instantiateInitialViewController];
        
        //vc.bh = bh;
        
        //剩余运输总量 = 货物总量 - 运输总量
        vc.sendCarTransportation = [weakSelf.headerView.totalGoodsStr floatValue] - [weakSelf.headerView.totalTransportationStr floatValue];
        //获取第一天日期和第一天车辆司机信息
        if (weakSelf.carInfoView.dataList.count != 0) {
            vc.firstDate = weakSelf.carInfoView.dataList[0][@"date"];
            vc.selectedCarsList = weakSelf.carInfoView.dataList[0][@"data"];
        } else {
            vc.firstDate = @"";
            vc.selectedCarsList = @[];
        }
        
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
    
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendCarInfo:) name:SendCarNotification object:nil];

    UIButton *callPhone = [UIButton creatButtonWithTitle:@"联系运营专员" imageName:@"tel" color:[UIColor blackColor]];
    [callPhone addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
    UIButton *checkInvoice = [UIButton creatButtonWithTitle:@"提交" imageName:nil color:[UIColor redColor]];
    [checkInvoice addTarget:self action:@selector(totask) forControlEvents:UIControlEventTouchUpInside];

    callPhone.frame = CGRectMake(0, ScreenH - 44 - 64, ScreenW / 2, 44);
    checkInvoice.frame = CGRectMake(ScreenW / 2, ScreenH - 44 - 64, ScreenW / 2, 44);

    [self.view addSubview:callPhone];
    [self.view addSubview:checkInvoice];

}


//提交
- (void)totask {
    
    NSLog(@"%@", self.headerView.hanshui);
    
    
    JCAlertController *alert = [JCAlertController alertWithTitle:@"提示" message:@"确认提交?" type:JCAlertTypeNormal];
    
    [alert addButtonWithTitle:@"取消" type:JCButtonTypeWarning clicked:nil];
    [alert addButtonWithTitle:@"确定" type:JCButtonTypeWarning clicked:^{
        
        //单价
        NSString *dj;
        if ([self.sendCarDict[@"sfyj"] isEqualToString:@"1"]) {
            dj = self.sendCarDict[@"ysdj"];
        } else {
            dj = self.headerView.price;
        }
        
        if (dj.length == 0) {
            [LLGHUD showErrorWithStatus:@"请填写可报价"];
            return;
        }
        
        if (self.carInfoView.dataList.count == 0) {
            [LLGHUD showErrorWithStatus:@"增加一日派车计划"];
            return;
        }
        
        NSMutableArray *datesM = [NSMutableArray array];
        
        [self.carInfoView.dataList enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString *date = dict[@"date"];
            
            NSMutableArray *carsM = [NSMutableArray array];
            
            [dict[@"data"] enumerateObjectsUsingBlock:^(SendCarModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSDictionary *modelDict = @{
                                            @"fpyl": model.czds,
                                            @"sjbh": model.ygbh,
                                            @"clbh": model.clbh
                                            };
                [carsM addObject:modelDict];
                
            }];
            
            NSDictionary *carDict = @{
                                      @"date": date,
                                      @"cars": carsM.copy
                                      };
            
            [datesM addObject:carDict];
            
        }];
        
        //NSString *dates = [NSString ObjectTojsonString:datesM.copy];
        
        NSDictionary *datesDict = @{
                                    @"dates": datesM
                                    };
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              self.sendCarDict[@"fhdbh"],@"fhdbh",
                              self.sendCarDict[@"fhdxtbh"],@"fhdxtbh",
                              self.sendCarDict[@"fbbh"],@"fbbh",
                              GetUuid,@"yhbh",
                              self.sendCarDict[@"sfyj"],@"sfyj",
                              dj,@"dj",
                              self.headerView.hanshui,@"sfhs",
                              nil];
        
        
        //json
        NSString *jsonDict = [self deleteFirstWithStr:[NSString ObjectTojsonString:dict]];
        NSString *jsonDates = [self deleteFirstWithStr:[NSString ObjectTojsonString:datesDict]];
        
        NSString *json = [NSString stringWithFormat:@"{%@,%@}", jsonDict, jsonDates];
        
        NSDictionary *parameters = @{
                                     @"jsonStr": json
                                     };
        

        [[XSJNetworkTool sharedNetworkTool] requestDataWithRequestType:GET andUrlString:SendCarsSubmit_URL andParameters:parameters andSuccessBlock:^(id result) {
            
            [LLGHUD showSuccessWithStatus:@"派车成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } andFailBlock:^(NSError *error) {
            [LLGHUD showErrorWithStatus:@"网络连接错误"];
        }];

        
    }];
    
    [self jc_presentViewController:alert presentType:JCPresentTypeFIFO presentCompletion:nil dismissCompletion:nil];
    
    
    
    
}

//删除首尾字符
- (NSString *)deleteFirstWithStr:(NSString *)str {

    //删除字符串两端的尖括号
    NSMutableString *mString = [NSMutableString stringWithString:str];
    //第一个参数是要删除的字符的索引，第二个是从此位开始要删除的位数
    [mString deleteCharactersInRange:NSMakeRange(0, 1)];
    [mString deleteCharactersInRange:NSMakeRange(mString.length-1, 1)];
    //NSLog(@"mString:%@",mString);
    
    return mString;
    
}

//电话
- (void)callPhone {
    
    [CallPhone callPhoneWithPhoneStr:self.sendCarDict[@"rysjh"]];
    
}

//获取具体数据
- (void)sendCarInfo:(NSNotification *)noti {

    
    self.carInfoView.sendCarDict = noti.object;

    //设置运输总量
    self.headerView.totalTransportationStr = self.carInfoView.totalTransportationStr;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 第一界面中dealloc中移除监听的事件
- (void)dealloc
{
    NSLog(@"dealloc==dealloc==");
    // 移除当前对象监听的事件
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (CarInfoTableView *)carInfoView {

    if (_carInfoView == nil) {
        
        _carInfoView = [[CarInfoTableView alloc]initWithFrame:CGRectMake(0, 150, ScreenW, ScreenH - 150 - 50 - 64) style:UITableViewStylePlain];
        
        __weak SendCarsViewController *weakSelf = self;
        _carInfoView.deleteDataBlock = ^(){
        
            weakSelf.headerView.totalTransportationStr = weakSelf.carInfoView.totalTransportationStr;
        };
        
        [self.view addSubview:_carInfoView];
    }
    
    return _carInfoView;
}



@end
