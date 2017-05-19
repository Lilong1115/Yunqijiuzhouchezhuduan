//
//  CarModel.h
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/3.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarModel : NSObject

/*
 clbh = 8ef3f8fd6c17442fa05fa75af8d1a7cd;
 clcp = "\U9c81EA9502";
 clcpnum = 0;
 clgjbh = "";
 clzt = 1;
 ssyhbh = 1fcb7128b94e4d69a8597f655aa63228;
 


rws = 1;
ssyhbh = 1fcb7128b94e4d69a8597f655aa63228;
ygbh = ab4da48e1aa94e0fb6063c1c50e93613;
ygmc = "\U5458\U5de58";
ygsjh = 15131006363;
*/

//车辆编号
@property (nonatomic, copy) NSString *clbh;
//车牌号
@property (nonatomic, copy) NSString *clcp;

//司机名称
@property (nonatomic, copy) NSString *ygmc;
//手机号
@property (nonatomic, copy) NSString *ygsjh;
//编号
@property (nonatomic, copy) NSString *ygbh;

+ (instancetype)carModelWithDict:(NSDictionary *)dict;


@end
