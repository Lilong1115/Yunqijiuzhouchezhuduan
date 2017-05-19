//
//  SearchView.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 17/4/28.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import "SearchView.h"
#import "OilModel.h"

@interface SearchView()<UIPickerViewDataSource,UIPickerViewDelegate>

//油品选择
@property (nonatomic, weak) UITextField *oilText;

//出发地
@property (nonatomic, weak) UITextField *startText;
//目的地
@property (nonatomic, weak) UITextField *endText;

@property (nonatomic, strong) UIPickerView *picker;

//picker内容
@property (nonatomic, strong) NSArray *arrayData;

@property (nonatomic, strong) OilModel *selectedModel;

@end

@implementation SearchView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        self.layer.borderWidth = 1;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    //油品选择
    UITextField *oilText = [[UITextField alloc]init];
    //自定义键盘选择器
    self.picker = [[UIPickerView alloc] init];
    
    self.picker.delegate = self;
    self.picker.dataSource = self;
    //选择指示器
    [self.picker setShowsSelectionIndicator:YES];
    
    [self requestData];
    
    oilText.inputView = self.picker;
    oilText.placeholder = @"油品选择";
    oilText.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    oilText.textAlignment = NSTextAlignmentCenter;
    oilText.layer.borderWidth = 1;
    oilText.font = TextFont14;
    oilText.rightView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"huisan"]];
    oilText.rightViewMode = UITextFieldViewModeAlways;
    [self addSubview:oilText];
    self.oilText = oilText;
    
    //监听键盘的弹出通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    //搜索
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    searchButton.layer.borderWidth = 1;
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self addSubview:searchButton];
    [searchButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *arrowImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"db_arrow"]];
    [self addSubview:arrowImage];
    
    //出发地
    UITextField *startText = [self creatLabelWithPlaceholder:@"出发地"];
    self.startText = startText;
    UITextField *endText = [self creatLabelWithPlaceholder:@"目的地"];
    self.endText = endText;
    
    //布局
    [oilText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.mas_equalTo(self);
        make.height.mas_equalTo(self);
        make.width.mas_equalTo(80);
    }];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.trailing.mas_equalTo(self);
        make.height.mas_equalTo(self);
        make.width.mas_equalTo(80);
    }];
    [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
    [startText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(oilText.mas_trailing);
        make.top.height.mas_equalTo(self);
        make.trailing.mas_equalTo(arrowImage.mas_leading);
    }];
    [endText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(searchButton.mas_leading);
        make.top.height.mas_equalTo(self);
        make.leading.mas_equalTo(arrowImage.mas_trailing);
    }];
    
    
}

- (void)search {

    NSString *oil;
    NSString *start;
    NSString *end;
    
    if (self.oilText.text.length == 0 || [self.selectedModel.hwlxmc  isEqual:@"全部"] ) {
        oil = @"";
    } else {
        oil = [NSString stringWithFormat:@"%ld", self.selectedModel.hwlxbh];
    }
    
    if (self.startText.text.length == 0) {
        start = @"";
    } else {
        start = self.startText.text;
    }
    
    if (self.endText.text.length == 0) {
        end = @"";
    } else {
        end = self.endText.text;
    }
    
    self.sendBlock([NSString stringWithFormat:@"%@;%@;%@", oil, start, end]);
}

- (void)keyboardDidHide:(NSNotification *)noti {

    NSDictionary *infoDic = [noti userInfo];
    
    //由字典的键值对可知键盘的位置属性
    CGRect rect = [[infoDic objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    if (rect.origin.y == ScreenH) {
        NSString *oil;
        NSString *start;
        NSString *end;
        
        if (self.oilText.text.length == 0 || [self.selectedModel.hwlxmc  isEqual:@"全部"] ) {
            oil = @"";
        } else {
            oil = [NSString stringWithFormat:@"%ld", self.selectedModel.hwlxbh];
        }
        
        if (self.startText.text.length == 0) {
            start = @"";
        } else {
            start = self.startText.text;
        }
        
        if (self.endText.text.length == 0) {
            end = @"";
        } else {
            end = self.endText.text;
        }
        
        self.sendBlock([NSString stringWithFormat:@"%@;%@;%@", oil, start, end]);
        
    }
   
}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

//请求数据
- (void)requestData {

    [[XSJNetworkTool sharedNetworkTool] requestDataWithRequestType:GET andUrlString:OilType_URL andParameters:nil andSuccessBlock:^(id result) {
        
        NSArray *array = (NSArray *)result;
        NSMutableArray *arrayM = [NSMutableArray array];
        NSDictionary *dict = @{
                               @"hwlxbh": @"",
                               @"hwlxmc": @"全部"
                               };
        OilModel *model = [OilModel oilModelWithDict:dict];
        [arrayM addObject:model];
        
        [array enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            
            OilModel *model = [OilModel oilModelWithDict:dict];
            
            [arrayM addObject:model];
            
        }];
        
        self.arrayData = arrayM.copy;
        
        [self.picker reloadComponent:0];
        
    } andFailBlock:^(NSError *error) {
        
    }];
}


#pragma mark - UIPickerViewDelegate 和 UIPickerViewDataSource
//必须实现
// returns the number of 'columns' to display. ->选择器一共有多少列!
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component.. -> 选择器每列有多少行!
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.arrayData.count;
}

//选择器每行名称
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    OilModel *model = self.arrayData[row];
    
    return model.hwlxmc;
    
}



- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    OilModel *model = self.arrayData[row];
    
    self.selectedModel = model;
    
    self.oilText.text = model.hwlxmc;
}

- (UITextField *)creatLabelWithPlaceholder:(NSString *)placeholder {

    UITextField *text = [[UITextField alloc]init];
    text.placeholder = placeholder;
    text.textAlignment = NSTextAlignmentCenter;
    [self addSubview:text];
    return text;
}


@end
