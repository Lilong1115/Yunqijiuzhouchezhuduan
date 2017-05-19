//
//  NetPort.h
//  salesPlatform
//
//  Created by 李龙 on 17/3/6.
//  Copyright © 2017年 xiaoshoujia.com.cn. All rights reserved.
//

#ifndef NetPort_h
#define NetPort_h


#define Base_URL @"http://222.35.27.155:8888/"

//222.35.27.155:8888
//192.168.100.232:8080
//192.168.100.136:8080

//首页
#define Home_URL @"http://222.35.27.155:8999/antu/MovewebhomeCon.con/Carindex"
//我要寻货
#define ToFindGoods_URL @"http://222.35.27.155:8999/antu/XgoodsCon.con/getList"

//城市接口
#define CityAddress_URL @"http://222.35.27.155:8999/antu/RrgisterCon.con/Address"
//油品类型
#define OilType_URL @"http://222.35.27.155:8999/antu/XgoodsCon.con/hwlx"
//登录
#define Login_URL @"http://222.35.27.155:8999/antu/login.con/login"
//登录
#define Login2_URL @"http://222.35.27.155:8999/antu/login.con/login"
//修改照片
#define SaveIcon_URL @"http://222.35.27.155:8999/antu/androidModInfo.con/modiInfo"
//提交发货
#define Delivery_URL @"http://222.35.27.155:8999/antu/AndroidIndentCon.con/Addindent"
//提交发货
#define Delivery2_URL @"http://222.35.27.155:8999/antu/AndroidIndentCon.con/Addindent"
//服务协议
#define ServiceAgreement_URL @"http://222.35.27.155:8999/antu/serverDeal.con/getServerDeal"
//意见提交
#define SubmitOption_URL @"http://222.35.27.155:8999/antu/serverDeal.con/addOption"

//取消订单
#define CancelOrder_URL @"http://222.35.27.155:8999/antu/AndroidOwnerOrdersCon.con/cancelOwnerOrders"

//确认订单
#define ConfirmOrder_URL @"http://222.35.27.155:8999/antu/AndroidOwnerOrdersCon.con/updateOwnerOrders"

//h5
//订单管理
//已报价
#define YBJOrderManagement_URL @"http://222.35.27.155:8999/antu/MovewebindentCon.con/QuotedIndent"
//已签约
#define YQYOrderManagement_URL @"http://222.35.27.155:8999/antu/MovewebindentCon.con/SignedIndent"
//已完成
#define YWCOrderManagement_URL @"http://222.35.27.155:8999/antu/MovewebindentCon.con/CompletedIndent"
//订单详情
#define OrderDetails_URL @"http://222.35.27.155:8999/antu/MovewebindentCon.con/OwnerCheck"
//运输协议
#define TransportAgreement_URL @"http://222.35.27.155:8999/antu/MovewebindentCon.con/TransportAgreement"
//车辆定位
#define CarsPosition_URL @"http://222.35.27.155:8999/antu/MovewebManageCon.con/carsInfoPosition"
//定位
#define Position_URL @"http://222.35.27.155:8999/antu/"
//查看任务
#define Task_URL @"http://222.35.27.155:8999/antu/MovewebManageCon.con/task"
//查看装货单
#define CheckZhdInvoice_URL @"http://222.35.27.155:8999/antu/MovewebManageCon.con/selectZhd"
//查看卸货单
#define CheckXhdInvoice_URL @"http://222.35.27.155:8999/antu/MovewebManageCon.con/selectXhd"

//认证信息
//车辆信息
#define CarInfo_URL @"http://222.35.27.155:8999/antu/MovewebManageCon.con/carInfo?uuid="
//添加车辆
#define AddCar_URL @"http://222.35.27.155:8999/antu/AddCarCon.con/AddCar?uuid="
//添加司机
#define AddDriver_URL @"http://222.35.27.155:8999/antu/MovewebindentCon.con/AddDriver?uuid="


//司机
//司机当前任务
#define DriverNow_URL @"http://222.35.27.155:8999/antu/IosDriverCon.con/getList"
//历史任务
#define DriverHistory_URL @"http://222.35.27.155:8999/antu/IosDriverCon.con/HistoryList"
//填写装货单
#define ReadZhdInvoice_URL @"http://222.35.27.155:8999/antu/IosDriverCon.con/driverwith?id="
//填写卸货单
#define ReadXhdInvoice_URL @"http://222.35.27.155:8999/antu/IosDriverCon.con/driveraddxhd?xhdvalue="

//圈子
#define Circle_URL @"http://222.35.27.155:8999/antu/MovewebcircleCon.con/circle?yhbh="

//添加圈子
#define AddCircle_URL @"http://222.35.27.155:8999/antu/MovewebcircleCon.con/addcircle?yhbh="

//商城
#define Mall_URL @"http://222.35.27.155:8999/antu/MovewebMySettingsCon.con/IntegralShop?yhbh="


#endif /* NetPort_h */
