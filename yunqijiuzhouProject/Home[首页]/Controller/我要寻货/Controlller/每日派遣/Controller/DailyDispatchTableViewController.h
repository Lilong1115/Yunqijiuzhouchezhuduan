//
//  DailyDispatchTableViewController.h
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/2.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyDispatchTableViewController : UITableViewController

@property (nonatomic, copy) NSString *bh;

//剩余运输总量
@property (nonatomic, assign) CGFloat sendCarTransportation;

//第一天日期
@property (nonatomic, copy) NSString *firstDate;

//已选择车辆列表
@property (nonatomic, copy) NSArray *selectedCarsList;

@end
