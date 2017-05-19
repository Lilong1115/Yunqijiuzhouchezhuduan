//
//  CarModel.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/3.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import "CarModel.h"


@implementation CarModel

+ (instancetype)carModelWithDict:(NSDictionary *)dict {

    CarModel *model = [[CarModel alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
  
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}

- (void)setNilValueForKey:(NSString *)key {

    
}





@end
