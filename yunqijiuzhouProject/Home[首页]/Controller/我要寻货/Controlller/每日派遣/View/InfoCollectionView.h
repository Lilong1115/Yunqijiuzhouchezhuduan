//
//  InfoCollectionView.h
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/2.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoCollectionView : UICollectionView

//行高
@property (nonatomic, readonly, assign) CGFloat cellHeight;

//列数
@property (nonatomic, assign) NSInteger columns;

//车辆信息列表
@property (nonatomic, copy) NSArray *infoList;
//司机信息列表
@property (nonatomic, copy) NSArray *driverInfoList;

@property (nonatomic, copy) void(^selectedBlock)(NSInteger selectedItem);

@end
