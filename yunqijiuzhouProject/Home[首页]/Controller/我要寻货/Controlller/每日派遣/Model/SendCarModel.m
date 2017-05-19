//
//  SendCarModel.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/3.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import "SendCarModel.h"

@implementation SendCarModel

+ (instancetype)sendCarModelWithDict:(NSDictionary *)dict {

    SendCarModel *model = [[SendCarModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}


- (void)setNilValueForKey:(NSString *)key {

    
}

- (NSDictionary *)creatDict {

    NSDictionary *dict = @{
                           //车辆编号
                           @"clbh": self.clbh,
                           //车牌号
                           @"clcp": self.clcp,
                           //司机名称
                           @"ygmc": self.ygmc,
                           //手机号
                           @"ygsjh": self.ygsjh,
                           //编号
                           @"ygbh": self.ygbh,
                           //承载吨数
                           @"czds": self.czds
                           };
    
    return dict;
}

@end
