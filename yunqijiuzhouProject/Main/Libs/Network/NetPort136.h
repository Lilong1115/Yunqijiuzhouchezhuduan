//
//  NetPort136.h
//  yunqijiuzhouProject
//
//  Created by 李龙 on 17/4/26.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#ifndef NetPort136_h
#define NetPort136_h

#define Base_URL @"http://www.yun9zhou.com/"

//www.yun9zhou.com
//47.93.46.18:8080

//222.35.27.155:8888
//192.168.100.232:8080
//192.168.100.237:8080/antu
//头像路径 -- http://222.35.27.155:8888 图片基础url
#define PhotoBase_URL @"http://www.yun9zhou.com"

//首页
#define Home_URL [NSString stringWithFormat:@"%@MovewebhomeCon.con/Carindex", Base_URL]
//@"http://192.168.100.136:8080/antu/MovewebhomeCon.con/Carindex"
//我要寻货
#define ToFindGoods_URL [NSString stringWithFormat:@"%@XgoodsCon.con/getList", Base_URL]
//@"http://192.168.100.136:8080/antu/XgoodsCon.con/getList"
//货源详情
#define GoodsTypes_URL [NSString stringWithFormat:@"%@XgoodsCon.con/goodswith?id=", Base_URL]
//@"http://192.168.100.136:8080/antu/XgoodsCon.con/goodswith?id="
//派车报价
#define SendCars_URL [NSString stringWithFormat:@"%@XgoodsCon.con/sendCarPlan?bh=", Base_URL]
//@"http://192.168.100.136:8080/antu/XgoodsCon.con/sendCarPlan?bh="

//派车提交
#define SendCarsSubmit_URL [NSString stringWithFormat:@"%@XgoodsCon.con/InsertPxdd", Base_URL]
//@"http://192.168.100.136:8080/antu/XgoodsCon.con/InsertPxdd"

//每日派车
//车
#define GetCarList_URL [NSString stringWithFormat:@"%@XgoodsCon.con/getCarList?uuid=", Base_URL]
//@"http://192.168.100.136:8080/antu/XgoodsCon.con/getCarList?uuid="
//司机
#define GetDirverList_URL [NSString stringWithFormat:@"%@XgoodsCon.con/getUserList?uuid=", Base_URL]
//@"http://192.168.100.136:8080/antu/XgoodsCon.con/getUserList?uuid="
//确认添加
#define SendCarPlan [NSString stringWithFormat:@"%@XgoodsCon.con/sendCarPlan", Base_URL]
//@"http://192.168.100.136:8080/antu/XgoodsCon.con/sendCarPlan"


//城市接口
#define CityAddress_URL [NSString stringWithFormat:@"%@RrgisterCon.con/Address", Base_URL]
//@"http://192.168.100.136:8080/antu/RrgisterCon.con/Address"
//油品类型
#define OilType_URL [NSString stringWithFormat:@"%@XgoodsCon.con/hwlx", Base_URL]
//@"http://192.168.100.136:8080/antu/XgoodsCon.con/hwlx"
//登录
#define Login_URL [NSString stringWithFormat:@"%@login.con/login", Base_URL]
//@"http://192.168.100.136:8080/antu/login.con/login"

//修改照片
#define SaveIcon_URL [NSString stringWithFormat:@"%@androidModInfo.con/modiInfo", Base_URL]
//@"http://192.168.100.136:8080/antu/androidModInfo.con/modiInfo"
//提交发货
#define Delivery_URL [NSString stringWithFormat:@"%@AndroidIndentCon.con/Addindent", Base_URL]
//@"http://192.168.100.136:8080/antu/AndroidIndentCon.con/Addindent"

//服务协议
#define ServiceAgreement_URL [NSString stringWithFormat:@"%@serverDeal.con/getServerDeal", Base_URL]
//@"http://192.168.100.136:8080/antu/serverDeal.con/getServerDeal"
//意见提交
#define SubmitOption_URL [NSString stringWithFormat:@"%@serverDeal.con/addOption", Base_URL]
//@"http://192.168.100.136:8080/antu/serverDeal.con/addOption"

//取消订单
#define CancelOrder_URL [NSString stringWithFormat:@"%@AndroidOwnerOrdersCon.con/cancelOwnerOrders", Base_URL]
//@"http://192.168.100.136:8080/antu/AndroidOwnerOrdersCon.con/cancelOwnerOrders"

//确认订单
#define ConfirmOrder_URL [NSString stringWithFormat:@"%@AndroidOwnerOrdersCon.con/updateOwnerOrders", Base_URL]
//@"http://192.168.100.136:8080/antu/AndroidOwnerOrdersCon.con/updateOwnerOrders"

//h5
//订单管理
//已报价
#define YBJOrderManagement_URL [NSString stringWithFormat:@"%@MovewebindentCon.con/QuotedIndent", Base_URL]
//@"http://192.168.100.136:8080/antu/MovewebindentCon.con/QuotedIndent"
//已签约
#define YQYOrderManagement_URL [NSString stringWithFormat:@"%@MovewebindentCon.con/SignedIndent", Base_URL]
//@"http://192.168.100.136:8080/antu/MovewebindentCon.con/SignedIndent"
//已完成
#define YWCOrderManagement_URL [NSString stringWithFormat:@"%@MovewebindentCon.con/CompletedIndent", Base_URL]
//@"http://192.168.100.136:8080/antu/MovewebindentCon.con/CompletedIndent"
//订单详情
#define OrderDetails_URL [NSString stringWithFormat:@"%@MovewebindentCon.con/OwnerCheck", Base_URL]
//@"http://192.168.100.136:8080/antu/MovewebindentCon.con/OwnerCheck"
//运输协议
#define TransportAgreement_URL [NSString stringWithFormat:@"%@MovewebindentCon.con/TransportAgreement", Base_URL]
//@"http://192.168.100.136:8080/antu/MovewebindentCon.con/TransportAgreement"
//车辆定位
#define CarsPosition_URL [NSString stringWithFormat:@"%@MovewebManageCon.con/carsInfoPosition", Base_URL]
//@"http://192.168.100.136:8080/antu/MovewebManageCon.con/carsInfoPosition"
//全部定位
#define AllCarsPosition_URL [NSString stringWithFormat:@"%@MovewebManageCon.con/carsInfoPositionDW", Base_URL]

//定位
#define Position_URL [NSString stringWithFormat:@"%@", Base_URL]
//@"http://192.168.100.136:8080/antu/"
//查看任务
#define Task_URL [NSString stringWithFormat:@"%@MovewebManageCon.con/task", Base_URL]
//@"http://192.168.100.136:8080/antu/MovewebManageCon.con/task"
//查看装货单
#define CheckZhdInvoice_URL [NSString stringWithFormat:@"%@MovewebManageCon.con/selectZhd", Base_URL]
//@"http://192.168.100.136:8080/antu/MovewebManageCon.con/selectZhd"
//查看卸货单
#define CheckXhdInvoice_URL [NSString stringWithFormat:@"%@MovewebManageCon.con/selectXhd", Base_URL]
//@"http://192.168.100.136:8080/antu/MovewebManageCon.con/selectXhd"

//运费收入
#define FreightRevenue_URL [NSString stringWithFormat:@"%@MovewebManageCon.con/freightRevenueInfo?uuid=", Base_URL]

//认证信息
//车辆信息
#define CarInfo_URL [NSString stringWithFormat:@"%@MovewebManageCon.con/carInfo?uuid=", Base_URL]
//@"http://192.168.100.136:8080/antu/MovewebManageCon.con/carInfo?uuid="
//添加车辆
#define AddCar_URL [NSString stringWithFormat:@"%@AddCarCon.con/AddCar?uuid=", Base_URL]
//@"http://192.168.100.136:8080/antu/AddCarCon.con/AddCar?uuid="
//添加司机
#define AddDriver_URL [NSString stringWithFormat:@"%@MovewebindentCon.con/AddDriver?uuid=", Base_URL]
//@"http://192.168.100.136:8080/antu/MovewebindentCon.con/AddDriver?uuid="
//司机信息
#define DriverInfo_URL [NSString stringWithFormat:@"%@MovewebManageCon.con/driverInfo?uuid=", Base_URL]
//注册信息
#define UserRegisterInfo_URL [NSString stringWithFormat:@"%@MovewebManageCon.con/fleetInfo?uuid=", Base_URL]

//司机
//司机当前任务
#define DriverNow_URL [NSString stringWithFormat:@"%@IosDriverCon.con/getList", Base_URL]
//@"http://192.168.100.136:8080/antu/IosDriverCon.con/getList"
//历史任务
#define DriverHistory_URL [NSString stringWithFormat:@"%@IosDriverCon.con/HistoryList", Base_URL]
//@"http://192.168.100.136:8080/antu/IosDriverCon.con/HistoryList"
//填写装货单
#define ReadZhdInvoice_URL [NSString stringWithFormat:@"%@IosDriverCon.con/driverwith?id=", Base_URL]
//@"http://192.168.100.136:8080/antu/IosDriverCon.con/driverwith?id="
//填写卸货单
#define ReadXhdInvoice_URL [NSString stringWithFormat:@"%@IosDriverCon.con/driveraddxhd?xhdvalue=", Base_URL]
//@"http://192.168.100.136:8080/antu/IosDriverCon.con/driveraddxhd?xhdvalue="

//圈子
#define Circle_URL [NSString stringWithFormat:@"%@MovewebcircleCon.con/circle?yhbh=", Base_URL]
//@"http://192.168.100.136:8080/antu/MovewebcircleCon.con/circle?yhbh="

//添加圈子
#define AddCircle_URL [NSString stringWithFormat:@"%@MovewebcircleCon.con/addcircle?yhbh=", Base_URL]
//@"http://192.168.100.136:8080/antu/MovewebcircleCon.con/addcircle?yhbh="

//商城
#define Mall_URL [NSString stringWithFormat:@"%@MovewebMySettingsCon.con/IntegralShop?yhbh=", Base_URL]
//@"http://192.168.100.136:8080/antu/MovewebMySettingsCon.con/IntegralShop?yhbh="

//车主注册
#define Register_URL [NSString stringWithFormat:@"%@MovewebManageCon.con/registerPersonal", Base_URL]
//@"http://192.168.100.136:8080/antu/MovewebManageCon.con/registerPersonal"
//车队注册
#define TeamRegister_URL [NSString stringWithFormat:@"%@MovewebManageCon.con/register", Base_URL]
//@"http://192.168.100.136:8080/antu/MovewebManageCon.con/register"

//账号绑定
#define Account_URL [NSString stringWithFormat:@"%@yelistCon.con/Balance", Base_URL]

//绑定银行卡
#define BindingAccount_URL [NSString stringWithFormat:@"%@AddBankCon.con/BindingAccount", Base_URL]

//更多
#define More_URL [NSString stringWithFormat:@"%@MovewebhomeCon.con/MoreOils", Base_URL]

//搜索油品类型
#define OilTypes_URL [NSString stringWithFormat:@"%@XgoodsCon.con/hwlx", Base_URL]

//提现
#define Withdraw_URL [NSString stringWithFormat:@"%@withdraws.con/withdraw", Base_URL]

//余额查询
#define Balance_URL [NSString stringWithFormat:@"%@AndroidBankCon.con/RefreshSelect", Base_URL]

//交易记录
#define Tradeindent_URL [NSString stringWithFormat:@"%@MovewebMySettingsCon.con/Tradeindent?yhbh=", Base_URL]

//修改支付密码
#define ModifyPaymentPassword_URL [NSString stringWithFormat:@"%@ModifyPwdCon.con/ModifyPwd", Base_URL]
//http://192.168.100.232:8080/antu/ModifyPwdCon.con/ModifyPwd?uuid=&yhsjh=
//忘记支付密码
#define ForgetPaymentPassword_URL [NSString stringWithFormat:@"%@ModifyPwdCon.con/forgetPwd", Base_URL]

//消息
#define Message_URL [NSString stringWithFormat:@"%@Moveweb/MySettings/ xxList?token=", Base_URL]

//支付运费
#define PaymentList_URL [NSString stringWithFormat:@"%@MovewebindentCon.con/PaymentList", Base_URL]

//运费
#define SendCarPlanInfo_URL [NSString stringWithFormat:@"%@MovewebManageCon.con/sendCarPlanInfo", Base_URL]

//支付
#define Paymentmoney_URL [NSString stringWithFormat:@"%@MovewebManageCon.con/Paymentmoney", Base_URL]

//线下支付@"AndroidLinePayCon.con/LinePay"
#define OfflinePay_URL [NSString stringWithFormat:@"%@AndroidLinePayCon.con/LinePay", Base_URL]
//线上支付
#define OnlinePay_URL [NSString stringWithFormat:@"%@PayforCon.con/gopay", Base_URL]

#endif /* NetPort136_h */
