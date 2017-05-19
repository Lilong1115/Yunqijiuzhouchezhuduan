//
//  DriverModel.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/3.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import "DriverModel.h"

@implementation DriverModel

+ (instancetype)driverModelWithDict:(NSDictionary *)dict {
    
    DriverModel *model = [[DriverModel alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setNilValueForKey:(NSString *)key {
    
    
}

@end
