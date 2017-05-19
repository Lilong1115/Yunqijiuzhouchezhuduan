//
//  NetPortWW.h
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/3.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#ifndef NetPortWW_h
#define NetPortWW_h

#define Base_URL @"http://47.93.46.18:8080/"

//222.35.27.155:8888
//192.168.100.232:8080
//192.168.100.136:8080

//首页
#define Home_URL @"http://47.93.46.18:8080/MovewebhomeCon.con/Carindex"
//我要寻货
#define ToFindGoods_URL @"http://47.93.46.18:8080/XgoodsCon.con/getList"
//货源详情
#define GoodsTypes_URL @"http://47.93.46.18:8080/XgoodsCon.con/goodswith?id="
//派车报价
#define SendCars_URL @"http://47.93.46.18:8080/XgoodsCon.con/sendCarPlan?bh="

//派车提交
#define SendCarsSubmit_URL @"http://47.93.46.18:8080/XgoodsCon.con/InsertPxdd"

//每日派车
//车
#define GetCarList_URL @"http://47.93.46.18:8080/XgoodsCon.con/getCarList?uuid="
//司机
#define GetDirverList_URL @"http://47.93.46.18:8080/XgoodsCon.con/getUserList?uuid="
//确认添加
#define SendCarPlan @"http://47.93.46.18:8080/XgoodsCon.con/sendCarPlan"


//城市接口
#define CityAddress_URL @"http://47.93.46.18:8080/RrgisterCon.con/Address"
//油品类型
#define OilType_URL @"http://47.93.46.18:8080/XgoodsCon.con/hwlx"
//登录
#define Login_URL @"http://47.93.46.18:8080/login.con/login"
//登录
#define Login2_URL @"http://47.93.46.18:8080/login.con/login"
//修改照片
#define SaveIcon_URL @"http://47.93.46.18:8080/androidModInfo.con/modiInfo"
//提交发货
#define Delivery_URL @"http://47.93.46.18:8080/AndroidIndentCon.con/Addindent"
//提交发货
#define Delivery2_URL @"http://47.93.46.18:8080/AndroidIndentCon.con/Addindent"
//服务协议
#define ServiceAgreement_URL @"http://47.93.46.18:8080/serverDeal.con/getServerDeal"
//意见提交
#define SubmitOption_URL @"http://47.93.46.18:8080/serverDeal.con/addOption"

//取消订单
#define CancelOrder_URL @"http://47.93.46.18:8080/AndroidOwnerOrdersCon.con/cancelOwnerOrders"

//确认订单
#define ConfirmOrder_URL @"http://47.93.46.18:8080/AndroidOwnerOrdersCon.con/updateOwnerOrders"

//h5
//订单管理
//已报价
#define YBJOrderManagement_URL @"http://47.93.46.18:8080/MovewebindentCon.con/QuotedIndent"
//已签约
#define YQYOrderManagement_URL @"http://47.93.46.18:8080/MovewebindentCon.con/SignedIndent"
//已完成
#define YWCOrderManagement_URL @"http://47.93.46.18:8080/MovewebindentCon.con/CompletedIndent"
//订单详情
#define OrderDetails_URL @"http://47.93.46.18:8080/MovewebindentCon.con/OwnerCheck"
//运输协议
#define TransportAgreement_URL @"http://47.93.46.18:8080/MovewebindentCon.con/TransportAgreement"
//车辆定位
#define CarsPosition_URL @"http://47.93.46.18:8080/MovewebManageCon.con/carsInfoPosition"
//定位
#define Position_URL @"http://47.93.46.18:8080/"
//查看任务
#define Task_URL @"http://47.93.46.18:8080/MovewebManageCon.con/task"
//查看装货单
#define CheckZhdInvoice_URL @"http://47.93.46.18:8080/MovewebManageCon.con/selectZhd"
//查看卸货单
#define CheckXhdInvoice_URL @"http://47.93.46.18:8080/MovewebManageCon.con/selectXhd"

//认证信息
//车辆信息
#define CarInfo_URL @"http://47.93.46.18:8080/MovewebManageCon.con/carInfo?uuid="
//添加车辆
#define AddCar_URL @"http://47.93.46.18:8080/AddCarCon.con/AddCar?uuid="
//添加司机
#define AddDriver_URL @"http://47.93.46.18:8080/MovewebindentCon.con/AddDriver?uuid="

//司机
//司机当前任务
#define DriverNow_URL @"http://47.93.46.18:8080/IosDriverCon.con/getList"
//历史任务
#define DriverHistory_URL @"http://47.93.46.18:8080/IosDriverCon.con/HistoryList"
//填写装货单
#define ReadZhdInvoice_URL @"http://47.93.46.18:8080/IosDriverCon.con/driverwith?id="
//填写卸货单
#define ReadXhdInvoice_URL @"http://47.93.46.18:8080/IosDriverCon.con/driveraddxhd?xhdvalue="

//圈子
#define Circle_URL @"http://47.93.46.18:8080/MovewebcircleCon.con/circle?yhbh="

//添加圈子
#define AddCircle_URL @"http://47.93.46.18:8080/MovewebcircleCon.con/addcircle?yhbh="

//商城
#define Mall_URL @"http://47.93.46.18:8080/MovewebMySettingsCon.con/IntegralShop?yhbh="

#endif /* NetPortWW_h */
