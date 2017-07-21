//
//  SendCarHeaderView.h
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/4.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendCarHeaderView : UIView

@property (nonatomic, copy) void(^sendCarBlock)();

//一口价 or 可报价
@property (nonatomic, copy) NSString *isOneOrCanOffer;

//一口价
@property (nonatomic, copy) NSString *onePrice;
//可报价
@property (nonatomic, copy) NSString *price;

//货物总量
@property (nonatomic, copy) NSString *totalGoodsStr;

//运输总量
@property (nonatomic, copy) NSString *totalTransportationStr;

//是否含税
@property (nonatomic, copy) NSString *hanshui;

@end
