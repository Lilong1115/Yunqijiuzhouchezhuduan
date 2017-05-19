//
//  DailyDispatchTableViewController.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/2.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

//每日派遣
#import "DailyDispatchTableViewController.h"
#import "BLDatePickerView.h"
#import "CarInfoCell.h"
#import "AddCarsView.h"
#import "CarModel.h"
#import "UserInfo.h"
#import "DriverModel.h"
#import "SendCarModel.h"


static NSString *kCarInfoCellID = @"kCarInfoCellID";

@interface DailyDispatchTableViewController ()<BLDatePickerViewDelegate>

//日期选择器
@property (nonatomic, strong) BLDatePickerView *datePickerView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *dateView;

//选择车辆视图
@property (nonatomic, strong) AddCarsView *addCarsView;

//确定按钮
@property (nonatomic, strong) UIButton *confirmButton;
//关闭按钮
@property (nonatomic, strong) UIButton *closeButton;
//车辆数据
@property (nonatomic, strong) NSArray *carList;
//司机数据
@property (nonatomic, strong) NSArray *driverList;

//信息列表
@property (nonatomic, strong) NSMutableArray *sendCarList;

@end

@implementation DailyDispatchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //请求车辆信息
    [self requestCarList];
    //请求司机信息
    [self requestDirverList];
    
    self.navigationItem.title = @"每日派车";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加车辆" style:UIBarButtonItemStylePlain target:self action:@selector(addCars)];

    self.dateLabel.text = [self currentDate];
    
    //添加选择时间手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selecteDate:)];
    [self.dateView addGestureRecognizer:tap];
    
    //注册
    [self.tableView registerClass:[CarInfoCell class] forCellReuseIdentifier:kCarInfoCellID];
    self.tableView.rowHeight = 44;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.bounces = NO;
    UIView *grayView = [[UIView alloc]init];
    grayView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.tableFooterView = grayView;
    
    //确认添加
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"确认添加" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addButton setBackgroundColor:[UIColor redColor]];
    addButton.frame = CGRectMake(0, ScreenH - 50 - 64, ScreenW, 50);
    [self.view addSubview:addButton];
    [addButton addTarget:self action:@selector(addInfo) forControlEvents:UIControlEventTouchUpInside];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.sendCarList.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CarInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kCarInfoCellID forIndexPath:indexPath];
    
    //是否隐藏删除
    cell.isHiddenDelete = (indexPath.section == 0 && indexPath.row == 0);
    cell.cellIdx = indexPath.row;
    
    if (indexPath.row != 0) {
        cell.sendCarModel = self.sendCarList[indexPath.row - 1];
    }
    
    //删除车辆信息
    __weak DailyDispatchTableViewController *weakSelf = self;
    cell.deleteCarInfoBlock = ^(NSInteger cellIdx){
    
        __strong DailyDispatchTableViewController *strongSelf = weakSelf;
        
        [strongSelf.sendCarList removeObjectAtIndex:cellIdx - 1];
        
        [tableView reloadData];
    };
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}

//获取当前时间
- (NSString *)currentDate {

    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    return dateStr;
}

//关闭添加车辆
- (void)close {

    [self.addCarsView removeFromSuperview];
    [self.confirmButton removeFromSuperview];
    [self.closeButton removeFromSuperview];
}


//确定
- (void)confirm {

    BOOL judge = [self judge];
    
    NSLog(@"%d", judge);
    
    if (judge == YES) {
        [self addSendInfo];
    } else {
        NSLog(@"失败");
    }

}

- (BOOL)judge{

    __block BOOL judge = YES;
    
    //不能为空
    if (self.addCarsView.czds.length == 0) {
        [LLGHUD showErrorWithStatus:@"请输入车载吨数"];
        return NO;
    }
    
    //不能超过45
    if ([self.addCarsView.czds floatValue] > 45) {
        [LLGHUD showErrorWithStatus:@"车载吨数不超过45吨"];
        return NO;
    }
    
    //不能超过剩余总量
    __block CGFloat total = [self.addCarsView.czds floatValue];
    [self.sendCarList enumerateObjectsUsingBlock:^(SendCarModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        total -= [model.czds floatValue];
        
    }];
    
    if (self.sendCarTransportation < total) {
        [LLGHUD showErrorWithStatus:@"承载吨数不得超过货物总量"];
        return NO;
    }
    
    //选择车辆和司机
    if (self.addCarsView.selectedCarModel == nil) {
        [LLGHUD showErrorWithStatus:@"请选择车辆"];
        return NO;
    }
    
    if (self.addCarsView.selectedDriverModel == nil) {
        [LLGHUD showErrorWithStatus:@"请选择司机"];
        return NO;
    }
    
    
    //判断不能使用相同车辆和相同司机
    [self.selectedCarsList enumerateObjectsUsingBlock:^(SendCarModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        //车辆编号
        if ([self.addCarsView.selectedCarModel.clbh isEqualToString:model.clbh]) {
            [LLGHUD showErrorWithStatus:@"不得选择相同车辆"];
            judge = NO;
            return;
        } else {
            
            //司机编号
            if ([self.addCarsView.selectedDriverModel.ygbh isEqualToString:model.ygbh]) {
                [LLGHUD showErrorWithStatus:@"不得选择相同司机"];
                judge = NO;
                return;
            }
            
        }
    }];
    
    [self.sendCarList enumerateObjectsUsingBlock:^(SendCarModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        //车辆编号
        if ([self.addCarsView.selectedCarModel.clbh isEqualToString:model.clbh]) {
            [LLGHUD showErrorWithStatus:@"不得选择相同车辆"];
            judge = NO;
            return;
        } else {
            
            //司机编号
            if ([self.addCarsView.selectedDriverModel.ygbh isEqualToString:model.ygbh]) {
                [LLGHUD showErrorWithStatus:@"不得选择相同司机"];
                judge = NO;
                return;
            }
            
        }
    }];
    
    return judge;
}

//添加数据
- (void)addSendInfo {

    JCAlertController *alert = [JCAlertController alertWithTitle:@"确认" message:@"您确认添加吗?" type:JCAlertTypeNormal];
    
    [alert addButtonWithTitle:@"取消" type:JCButtonTypeWarning clicked:nil];
    [alert addButtonWithTitle:@"确定" type:JCButtonTypeWarning clicked:^{
        
        //添加数据
        NSDictionary *dict = @{
                               //车辆编号
                               @"clbh": self.addCarsView.selectedCarModel.clbh,
                               //车牌号
                               @"clcp": self.addCarsView.selectedCarModel.clcp,
                               //司机名称
                               @"ygmc": self.addCarsView.selectedDriverModel.ygmc,
                               //手机号
                               @"ygsjh": self.addCarsView.selectedDriverModel.ygsjh,
                               //编号
                               @"ygbh": self.addCarsView.selectedDriverModel.ygbh,
                               //承载吨数
                               @"czds": self.addCarsView.czds
                               };
        
        SendCarModel *model = [SendCarModel sendCarModelWithDict:dict];
        [self.sendCarList addObject:model];
        
        [self.addCarsView removeFromSuperview];
        [self.confirmButton removeFromSuperview];
        [self.closeButton removeFromSuperview];
        
        [self.tableView reloadData];
    }];
    
    [self jc_presentViewController:alert presentType:JCPresentTypeFIFO presentCompletion:nil dismissCompletion:nil];
}

//确认添加
- (void)addInfo {
    
    //不得相同日期
    if ([self.dateLabel.text isEqualToString:self.firstDate]) {
        [LLGHUD showErrorWithStatus:@"不得添加同一天货运"];
        return;
    }
    
    JCAlertController *alert = [JCAlertController alertWithTitle:@"确认" message:@"您确认添加吗?" type:JCAlertTypeNormal];
    
    [alert addButtonWithTitle:@"取消" type:JCButtonTypeWarning clicked:nil];
    [alert addButtonWithTitle:@"确定" type:JCButtonTypeWarning clicked:^{
        
        NSDictionary *sendDict = @{
                                   @"date": self.dateLabel.text,
                                   @"data": self.sendCarList
                                   };
        
        //转为json
        //NSString *json = [NSString ObjectTojsonString:sendDict];
        
        //创建通知
        NSNotification *notification =[NSNotification notificationWithName:SendCarNotification object:sendDict userInfo:nil];
        
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    [self jc_presentViewController:alert presentType:JCPresentTypeFIFO presentCompletion:nil dismissCompletion:nil];
    
    
}

//添加车辆
- (void)addCars {
    
    //提示没有信息,重新请求数据
    if (self.carList == nil) {
        [LLGHUD showErrorWithStatus:@"没有车辆信息"];
        [self requestCarList];
        return;
    }
    
    if (self.driverList == nil) {
        [LLGHUD showErrorWithStatus:@"没有司机信息"];
        [self requestDirverList];
        return;
    }
    
    [self.view addSubview:self.addCarsView];
    [self.view addSubview:self.confirmButton];
    [self.view addSubview:self.closeButton];
}

//选择日期
- (void)selecteDate:(UITapGestureRecognizer *)tap {

    [self.datePickerView bl_show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - - lazy load
// 第一步
- (BLDatePickerView *)datePickerView{
    if (!_datePickerView) {
        _datePickerView = [[BLDatePickerView alloc] init];
        _datePickerView.pickViewDelegate = self;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [formatter setDateFormat:@"YYYY"];
        
        //现在时间,你可以输出来看下是什么格式
        
        NSDate *datenow = [NSDate date];
        
        //----------将nsdate按formatter格式转成nsstring
        
        NSInteger yearNum = [[formatter stringFromDate:datenow] integerValue];
        
        [formatter setDateFormat:@"MM"];
        NSInteger monthNum = [[formatter stringFromDate:datenow] integerValue];
        [formatter setDateFormat:@"dd"];
        NSInteger dayNum = [[formatter stringFromDate:datenow] integerValue];
        
        [_datePickerView bl_setUpDefaultDateWithYear:yearNum month:monthNum day:dayNum];
        
        _datePickerView.topViewBackgroundColor = [UIColor grayColor];
        
        
    }
    return _datePickerView;
}


#pragma mark - - BLDatePickerViewDelegate
//选择之后
- (void)bl_selectedDateResultWithYear:(NSString *)year
                                month:(NSString *)month
                                  day:(NSString *)day{
    
    NSString *yearStr = [year substringToIndex:year.length - 1];
    NSString *monthStr = [month substringToIndex:month.length - 1];
    NSString *dayStr = [day substringToIndex:day.length - 1];
    
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *endDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@-%@-%@",yearStr,monthStr,dayStr]];
    
    NSInteger idx = [self calcDaysFromBegin:[NSDate date] end:endDate];
    
    
    if (idx < 0 || idx > 7 - 1) {
        self.dateLabel.text = [self currentDate];
        
        [LLGHUD showErrorWithStatus:@"请选择七天之内的时间"];
        
    } else {
        
        self.dateLabel.text = [dateFormatter stringFromDate:endDate];
        //[NSString stringWithFormat:@"%@-%@-%@",yearStr,monthStr,dayStr];
    }
 
}


- (NSInteger) calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate
{
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval time=[endDate timeIntervalSinceDate:beginDate];
    
    int days=((int)time)/(3600*24);
    //int hours=((int)time)%(3600*24)/3600;
    //NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
    return days;
}


- (AddCarsView *)addCarsView {

    if (_addCarsView == nil) {
        _addCarsView = [[AddCarsView alloc]initWithFrame:CGRectMake(0, ScreenH * 0.3, ScreenW, ScreenH - ScreenH * 0.3 - 50 - 64) style:UITableViewStylePlain];
        _addCarsView.carList = self.carList;
        _addCarsView.driverList = self.driverList;
    }
    
    return _addCarsView;
}

//确定按钮
- (UIButton *)confirmButton {
    
    if (_confirmButton == nil) {
        
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton setBackgroundColor:[UIColor redColor]];
        _confirmButton.frame = CGRectMake(0, ScreenH - 50 - 64, ScreenW, 50);
        //[self.view addSubview:_confirmButton];
        [_confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmButton;
}

- (UIButton *)closeButton {

    if (_closeButton == nil) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setTitle:@"取消" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_closeButton setBackgroundColor:[UIColor clearColor]];
        _closeButton.frame = CGRectMake(ScreenW - 8 - 50, ScreenH * 0.3 - 8 - 30, 50, 30);
        [_closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeButton;
}

//请求车辆列表
- (void)requestCarList {

    [[XSJNetworkTool sharedNetworkTool] requestDataWithRequestType:GET andUrlString:[NSString stringWithFormat:@"%@%@", GetCarList_URL, GetUuid] andParameters:nil andSuccessBlock:^(id result) {
        
        NSArray *array = (NSArray *)result;
        NSMutableArray *arrayM = [NSMutableArray array];
        [array enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            
            CarModel *model = [CarModel carModelWithDict:dict];
            [arrayM addObject:model];
        }];
        
        self.carList = arrayM.copy;
        
    } andFailBlock:^(NSError *error) {
        //NSLog(@"%@", error);
    }];
}

//请求司机列表
- (void)requestDirverList {
    
    [[XSJNetworkTool sharedNetworkTool] requestDataWithRequestType:GET andUrlString:[NSString stringWithFormat:@"%@%@", GetDirverList_URL, GetUuid] andParameters:nil andSuccessBlock:^(id result) {

        NSArray *array = (NSArray *)result;
        NSMutableArray *arrayM = [NSMutableArray array];
        [array enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            
            CarModel *model = [CarModel carModelWithDict:dict];
            [arrayM addObject:model];
        }];
        
        self.driverList = arrayM.copy;

    } andFailBlock:^(NSError *error) {
        //NSLog(@"%@", error);
    }];
}

- (NSMutableArray *)sendCarList {

    if (_sendCarList == nil) {
        _sendCarList = [NSMutableArray array];
    }
    
    return _sendCarList;
}

@end
