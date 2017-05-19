//
//  SearchView.h
//  yunqijiuzhouProject
//
//  Created by 李龙 on 17/4/28.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchView : UIView

@property (nonatomic, copy) void(^sendBlock)(NSString *sendStr);

@end
