//
//  OilModel.h
//  yunqijiuzhouProject
//
//  Created by 李龙 on 17/4/14.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OilModel : NSObject

//货物类型
@property (nonatomic, copy) NSString *hwlxmc;
//货物编号
@property (nonatomic, assign) NSInteger hwlxbh;

+ (instancetype)oilModelWithDict:(NSDictionary *)dict;


@end
/*
 hwlxbh": 1,
 "hwlxmc": "重油",
 "hwsjlx": 0,
 "hwlxtp": "/ANTUTUP/zhongyou.jpg",
 "hwxlbz": "wertyuh",
 "lxzt": "0"
 */
