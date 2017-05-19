//
//  UIButton+Extension.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/4.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

//创建底部按钮
+ (UIButton *)creatButtonWithTitle:(NSString *)title imageName:(NSString *)imageName color:(UIColor *)color {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [button setBackgroundColor:color];
    
    return button;
}

@end
