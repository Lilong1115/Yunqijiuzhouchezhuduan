//
//  CarInfoTableView.h
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/4.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarInfoTableView : UITableView

//一组数据
@property (nonatomic, copy) NSDictionary *sendCarDict;

//数据源
@property (nonatomic, copy) NSMutableArray *dataList;

//运输总量
@property (nonatomic, copy) NSString *totalTransportationStr;

@property (nonatomic, copy) void(^deleteDataBlock)();

@end
