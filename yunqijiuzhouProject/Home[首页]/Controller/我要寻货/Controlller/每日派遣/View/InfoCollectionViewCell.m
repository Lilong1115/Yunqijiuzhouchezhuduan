//
//  InfoCollectionViewCell.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/2.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import "InfoCollectionViewCell.h"
#import "CarModel.h"
#import "DriverModel.h"

@interface InfoCollectionViewCell()

//内容
@property (nonatomic, weak) UILabel *contentLabel;

@end

@implementation InfoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {

    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.layer.borderWidth = 0.5;
    contentLabel.layer.borderColor = [UIColor blackColor].CGColor;
    contentLabel.layer.cornerRadius = 5;
    contentLabel.layer.masksToBounds = YES;
    contentLabel.text = @"123";
    contentLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView).mas_offset(UIEdgeInsetsMake(4, 4, 4, 4));
    }];
}

- (void)setIsSelected:(BOOL)isSelected {

    _isSelected = isSelected;
    
    if (isSelected == YES) {
        self.contentLabel.layer.borderColor = [UIColor redColor].CGColor;
        self.contentLabel.backgroundColor = [UIColor grayColor];
        self.contentLabel.textColor = [UIColor whiteColor];
    } else {
        self.contentLabel.layer.borderColor = [UIColor blackColor].CGColor;
        self.contentLabel.backgroundColor = [UIColor clearColor];
        self.contentLabel.textColor = [UIColor blackColor];
    }
    
}

- (void)setModel:(CarModel *)model {

    _model = model;
    
    if (model.clcp) {
        self.contentLabel.text = model.clcp;
    } else {
        self.contentLabel.text = model.ygmc;
    }
    
    
}


@end
