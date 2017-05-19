//
//  SendCarModel.h
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/3.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SendCarModel : NSObject

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

//承载吨数
@property (nonatomic, copy) NSString *czds;

+ (instancetype)sendCarModelWithDict:(NSDictionary *)dict;

- (NSDictionary *)creatDict;

@end
