//
//  InfoCollectionViewCell.h
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/2.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CarModel, DriverModel;

@interface InfoCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) BOOL isSelected;

//车辆模型
@property (nonatomic, strong) CarModel *model;
//司机模型
@property (nonatomic, strong) DriverModel *driverModel;

@end
