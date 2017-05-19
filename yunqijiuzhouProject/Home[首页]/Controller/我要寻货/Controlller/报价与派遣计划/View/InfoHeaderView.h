//
//  InfoHeaderView.h
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/4.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoHeaderView : UIView

//日期
@property (nonatomic, copy) NSString *dateStr;

@property (nonatomic, copy) void(^deleteDataBlock)();

@end
