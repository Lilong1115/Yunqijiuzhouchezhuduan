//
//  HeaderView.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/2.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import "HeaderView.h"
#import "CarModel.h"

@interface HeaderView()

//标题
@property (nonatomic, weak) UILabel *title;
//内容
@property (nonatomic, weak) UILabel *contentLabel;
//输入内容
@property (nonatomic, weak) UITextField *contentText;

@end

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
        
    }
    
    return self;
}

- (void)setupUI {

    UILabel *title = [[UILabel alloc]init];
    title.text = @"选择车辆";
    [self addSubview:title];
    self.title = title;
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.textColor = [UIColor redColor];
    //contentLabel.text = @"123";
    [self addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UITextField *contentText = [[UITextField alloc]init];
    contentText.layer.borderWidth = 1;
    contentText.layer.borderColor = [UIColor redColor].CGColor;
    contentText.layer.cornerRadius = 5;
    contentText.layer.masksToBounds = YES;
    contentText.keyboardType = UIKeyboardTypeDecimalPad;
    [self addSubview:contentText];
    self.contentText = contentText;
    //监听文本改变
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange) name:UITextFieldTextDidChangeNotification object:contentText];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.mas_equalTo(self).mas_offset(8);
        make.bottom.mas_equalTo(self).mas_offset(-8);
    }];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(title.mas_trailing).mas_offset(10);
        make.centerY.mas_equalTo(title);
    }];
    [contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(title);
        make.leading.mas_equalTo(title.mas_trailing).mas_offset(10);
        make.width.mas_equalTo(50);
    }];
}

- (void)setHeaderTitle:(NSString *)headerTitle {

    _headerTitle = headerTitle;
    
    self.title.text = headerTitle;
}

- (void)setIsText:(BOOL)isText {

    _isText = isText;
    self.contentText.hidden = !isText;
    self.contentLabel.hidden = isText;
}

- (void)setSelectedModel:(CarModel *)selectedModel {

    _selectedModel = selectedModel;
    
    if (selectedModel.clcp) {
        self.contentLabel.text = selectedModel.clcp;
    } else {
        self.contentLabel.text = selectedModel.ygmc;
    }
}

- (NSString *)czds {

    return self.contentText.text;
}

////监听文本改变
//- (void)textFieldTextDidChange {
//
//    self.czds = self.contentText.text;
//    
//}


@end
