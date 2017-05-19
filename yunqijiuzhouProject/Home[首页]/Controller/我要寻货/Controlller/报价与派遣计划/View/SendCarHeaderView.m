//
//  SendCarHeaderView.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/4.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import "SendCarHeaderView.h"

@interface SendCarHeaderView()

//一口价标题
@property (nonatomic, weak) UILabel *priceLabel;
//一口价
@property (nonatomic, weak) UITextField *priceText;
//货物总吨数
@property (nonatomic, weak) UILabel *totalLabel;
//运输总量
@property (nonatomic, weak) UILabel *transportationLabel;

@end

@implementation SendCarHeaderView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    
    return self;
}


- (void)setupUI {

    //一口价
    UILabel *priceLabel = [self creatLabelWithTitle:@"一口价:" font:17 color:[UIColor blackColor]];
    [self addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    //输入框
    UITextField *priceText = [[UITextField alloc]init];
    priceText.borderStyle = UITextBorderStyleRoundedRect;
    priceText.keyboardType = UIKeyboardTypeDecimalPad;
    priceText.layer.borderColor = [UIColor grayColor].CGColor;
    priceText.layer.borderWidth = 0.5;
    priceText.layer.cornerRadius = 5;
    priceText.layer.masksToBounds = YES;
    [self addSubview:priceText];
    self.priceText = priceText;
    
    //监听文本改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange) name:UITextFieldTextDidChangeNotification object:priceText];
    
    //元/吨
    UILabel *unit = [self creatLabelWithTitle:@"(元/吨)" font:14 color:[UIColor blackColor]];
    [self addSubview:unit];
    
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = [UIColor blackColor];
    [self addSubview:lineView1];
    
    //货物总量
    UILabel *totalGoods = [self creatLabelWithTitle:@"货物总量:" font:14 color:[UIColor blackColor]];
    [self addSubview:totalGoods];
    
    //总量数
    UILabel *totalLabel = [self creatLabelWithTitle:@"520.0" font:14 color:[UIColor blackColor]];
    [self addSubview:totalLabel];
    self.totalLabel = totalLabel;
    
    //吨
    UILabel *ton = [self creatLabelWithTitle:@"吨" font:14 color:[UIColor blackColor]];
    [self addSubview:ton];
    
    UIView *lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = [UIColor blackColor];
    [self addSubview:lineView2];
    
    //运输总量
    UILabel *totalTransportation = [self creatLabelWithTitle:@"运输总量:" font:14 color:[UIColor blackColor]];
    [self addSubview:totalTransportation];
    
    //运输量
    UILabel *transportationLabel = [self creatLabelWithTitle:@"0" font:14 color:[UIColor redColor]];
    [self addSubview:transportationLabel];
    self.transportationLabel = transportationLabel;
    
    //吨
    UILabel *ton1 = [self creatLabelWithTitle:@"吨" font:14 color:[UIColor blackColor]];
    [self addSubview:ton1];
    
    UIButton *sendCarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendCarButton setTitle:@"增加一日派车计划" forState:UIControlStateNormal];
    [sendCarButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    sendCarButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:sendCarButton];
    [sendCarButton addTarget:self action:@selector(sendCar) forControlEvents:UIControlEventTouchUpInside];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).mas_offset(8);
        make.top.mas_equalTo(self).mas_offset(10);
    }];
    [priceText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(priceLabel.mas_trailing).mas_offset(8);
        make.centerY.mas_equalTo(priceLabel);
        make.width.mas_equalTo(200);
    }];
    [unit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(priceText);
        make.leading.mas_equalTo(priceText.mas_trailing);
    }];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(priceLabel.mas_bottom).mas_offset(10);
        make.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
    [totalGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).mas_offset(8);
        make.top.mas_equalTo(lineView1).mas_offset(10);
    }];
    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(totalGoods);
        make.leading.mas_equalTo(totalGoods.mas_trailing).mas_offset(8);
    }];
    [ton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(totalLabel);
        make.leading.mas_equalTo(totalLabel.mas_trailing);
    }];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(totalGoods.mas_bottom).mas_offset(10);
        make.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
    [totalTransportation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView2.mas_bottom).mas_offset(10);
        make.leading.mas_equalTo(self).mas_offset(8);
    }];
    [transportationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(totalTransportation);
        make.leading.mas_equalTo(totalTransportation.mas_trailing).mas_offset(8);
    }];
    [ton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(transportationLabel);
        make.leading.mas_equalTo(transportationLabel.mas_trailing);
    }];
    [sendCarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(ton1);
        make.trailing.mas_equalTo(self).mas_offset(-8);
    }];
}


//增加一日派车计划
- (void)sendCar {

    if (self.sendCarBlock != nil) {
        self.sendCarBlock();
    }
}

//设置运输总量
- (void)setTotalTransportationStr:(NSString *)totalTransportationStr {

    _totalTransportationStr = totalTransportationStr;
    
    self.transportationLabel.text = totalTransportationStr;
}

//设置货物总量
- (void)setTotalGoodsStr:(NSString *)totalGoodsStr {

    _totalGoodsStr = totalGoodsStr;
    
    self.totalLabel.text = totalGoodsStr;
}

//设置可报价或一口价
- (void)setIsOneOrCanOffer:(NSString *)isOneOrCanOffer {

    _isOneOrCanOffer = isOneOrCanOffer;
    if ([isOneOrCanOffer isEqualToString:@"0"]) {
        self.priceLabel.text = @"可报价:";
        self.priceText.userInteractionEnabled = YES;
        self.priceText.placeholder = @"";
    } else {
        self.priceLabel.text = @"一口价:";
        self.priceText.userInteractionEnabled = NO;
        self.priceText.placeholder = self.onePrice;
    }
}

//获取价格
- (void)textFieldTextDidChange {

    self.price = self.priceText.text;
}

//创建label
- (UILabel *)creatLabelWithTitle:(NSString *)title font:(CGFloat)font color:(UIColor *)color {

    UILabel *label = [[UILabel alloc]init];
    
    label.text = title;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = color;
    
    return label;
}

@end
