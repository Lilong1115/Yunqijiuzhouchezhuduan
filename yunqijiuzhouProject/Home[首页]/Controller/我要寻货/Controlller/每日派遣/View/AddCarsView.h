//
//  AddCarsView.h
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/2.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CarModel;

@interface AddCarsView : UITableView

@property (nonatomic, copy) NSArray *carList;

@property (nonatomic, copy) NSArray *driverList;

//选中的车
@property (nonatomic, strong) CarModel *selectedCarModel;

//选中的司机
@property (nonatomic, strong) CarModel *selectedDriverModel;

//承载吨数
@property (nonatomic, strong) NSString *czds;

@end
