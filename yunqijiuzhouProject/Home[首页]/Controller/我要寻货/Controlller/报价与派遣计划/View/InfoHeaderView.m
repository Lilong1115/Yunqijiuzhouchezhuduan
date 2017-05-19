//
//  InfoHeaderView.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/4.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import "InfoHeaderView.h"

@interface InfoHeaderView()

//日期
@property (nonatomic, weak) UILabel *dateLabel;

@end

@implementation InfoHeaderView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
        [self setupUI];
    }
    
    return self;
}


- (void)setupUI {

    //日期
    UILabel *dateLabel = [[UILabel alloc]init];
    dateLabel.text = @"日期";
    dateLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:dateLabel];
    self.dateLabel =dateLabel;
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [deleteButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    deleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:deleteButton];
    [deleteButton addTarget:self action:@selector(deleteData) forControlEvents:UIControlEventTouchUpInside];
    
    
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.leading.mas_equalTo(self).mas_offset(8);
    }];
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.trailing.mas_equalTo(self).mas_offset(-8);
    }];
    
}

//删除数据
- (void)deleteData {

    if (self.deleteDataBlock != nil) {
        self.deleteDataBlock();
    }
}


- (void)setDateStr:(NSString *)dateStr {

    _dateStr = dateStr;
    
    self.dateLabel.text = dateStr;
}

@end
