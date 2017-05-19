//
//  CarInfoCell.h
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/2.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SendCarModel;

@interface CarInfoCell : UITableViewCell

@property (nonatomic, copy) void(^deleteCarInfoBlock)(NSInteger cellIdx);

@property (nonatomic, assign) BOOL isHiddenDelete;

//标记cell
@property (nonatomic, assign) NSInteger cellIdx;

//派车模型
@property (nonatomic, strong) SendCarModel *sendCarModel;

@end
