//
//  HeaderView.h
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/2.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CarModel;

@interface HeaderView : UIView

//头标题
@property (nonatomic, copy) NSString *headerTitle;
//是否输入框
@property (nonatomic, assign) BOOL isText;

//模型
@property (nonatomic, strong) CarModel *selectedModel;

@property (nonatomic, copy) NSString *czds;

@end
