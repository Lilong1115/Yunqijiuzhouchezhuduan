//
//  CarInfoCell.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/2.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

//车辆信息
#import "CarInfoCell.h"
#import "SendCarModel.h"

@interface CarInfoCell()

//车牌号
@property (nonatomic, weak) UILabel *carNum;
//承运司机
@property (nonatomic, weak) UILabel *driver;
//手机号
@property (nonatomic, weak) UILabel *phoneNum;
//承载吨数
@property (nonatomic, weak) UILabel *tonnage;

//删除按钮
@property (nonatomic, weak) UIButton *deleteButton;

@end

@implementation CarInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {

    UILabel *carNum = [self creatLabelWithTitle:@"车牌号"];
    UILabel *driver = [self creatLabelWithTitle:@"承运司机"];
    UILabel *phoneNum = [self creatLabelWithTitle:@"手机号"];
    UILabel *tonnage = [self creatLabelWithTitle:@"车载吨数"];
    self.carNum = carNum;
    self.driver = driver;
    self.phoneNum = phoneNum;
    self.tonnage = tonnage;
    
    //删除按钮
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setBackgroundImage:[UIImage imageNamed:@"icon_dis_delete"] forState:UIControlStateNormal];
    [self.contentView addSubview:deleteButton];
    self.deleteButton = deleteButton;
    [deleteButton addTarget:self action:@selector(deleteCarInfo) forControlEvents:UIControlEventTouchUpInside];
    
    [carNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.top.mas_equalTo(self.contentView);
        make.width.mas_equalTo(ScreenW / 4 - 5);
    }];
    [driver mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(carNum.mas_trailing);
        make.width.mas_equalTo(ScreenW / 4 - 5);
    }];
    [phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(driver.mas_trailing);
        make.width.mas_equalTo(ScreenW / 4 - 5);
    }];
    [tonnage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(phoneNum.mas_trailing);
        make.width.mas_equalTo(ScreenW / 4 - 5);
    }];
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.trailing.mas_equalTo(self.contentView).mas_offset(-2);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

//删除按钮
- (void)deleteCarInfo {

    //NSLog(@"删除");
    if (self.deleteCarInfoBlock != nil) {
        self.deleteCarInfoBlock(self.cellIdx);
    }
   
}

//创建label
- (UILabel *)creatLabelWithTitle:(NSString *)title {

    UILabel *label = [[UILabel alloc]init];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:label];
    
    return label;
}

//设置是否隐藏删除
- (void)setIsHiddenDelete:(BOOL)isHiddenDelete {

    _isHiddenDelete = isHiddenDelete;
    
    self.deleteButton.hidden = isHiddenDelete;
}

- (void)setSendCarModel:(SendCarModel *)sendCarModel {

    _sendCarModel = sendCarModel;
    
    self.carNum.font = TextFont14;
    self.driver.font = TextFont14;
    self.phoneNum.font = TextFont14;
    self.tonnage.font = TextFont14;
    
    self.carNum.text = sendCarModel.clcp;
    self.driver.text = sendCarModel.ygmc;
    self.phoneNum.text = sendCarModel.ygsjh;
    self.tonnage.text = sendCarModel.czds;
}

@end
