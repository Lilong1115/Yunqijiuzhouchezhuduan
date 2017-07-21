//
//  CarInfoTableView.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/4.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import "CarInfoTableView.h"
#import "CarInfoCell.h"
#import "InfoHeaderView.h"
#import "SendCarModel.h"

static NSString *kCarInfoCellID = @"kCarInfoCell";

@interface CarInfoTableView()<UITableViewDelegate, UITableViewDataSource>



@end

@implementation CarInfoTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        
        self.delegate = self;
        self.dataSource = self;
        
        //注册
        [self registerClass:[CarInfoCell class] forCellReuseIdentifier:kCarInfoCellID];
        self.rowHeight = 44;
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.bounces = NO;
        UIView *grayView = [[UIView alloc]init];
        grayView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.tableFooterView = grayView;
    }
    
    return self;
}

//数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    __block CGFloat total;
    
    [self.dataList enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSArray *array = dict[@"data"];
        
        [array enumerateObjectsUsingBlock:^(SendCarModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            total += [model.czds floatValue];
        }];
    }];
    
    self.totalTransportationStr = [NSString stringWithFormat:@"%.2f", total];
    
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.dataList.count == 0) {
        return 0;
    } else {
    
        NSDictionary *dict = self.dataList[section];
        
        NSArray *array = dict[@"data"];
        
        return 1 + array.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //NSLog(@"%@", self.dataList);
    
    CarInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kCarInfoCellID forIndexPath:indexPath];
    
    //是否隐藏删除
    cell.isHiddenDelete = YES;
    cell.cellIdx = indexPath.row;
    
    if (indexPath.row != 0) {
        
        NSDictionary *dict = self.dataList[indexPath.section];
        
        NSArray *array = dict[@"data"];
        
        cell.sendCarModel = array[indexPath.row - 1];
    }
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}

//设置头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    InfoHeaderView *headerView = [[InfoHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44)];
    
    NSDictionary *dict = self.dataList[section];
    
    NSString *dateStr = dict[@"date"];
    
    headerView.dateStr = dateStr;
    
    //删除信息
    __weak CarInfoTableView *weakSelf = self;
    headerView.deleteDataBlock = ^(){
        
        [weakSelf.dataList removeObjectAtIndex:section];
        [tableView reloadData];
        
        if (weakSelf.deleteDataBlock != nil) {
            weakSelf.deleteDataBlock();
        }
        
    };
    
    return headerView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 44;
}

//设置添加数据
- (void)setSendCarDict:(NSDictionary *)sendCarDict {

    _sendCarDict = sendCarDict;
    
    [self.dataList addObject:sendCarDict];
    
    [self reloadData];
    
}

- (NSMutableArray *)dataList {

    if (_dataList == nil) {
        
        _dataList = [NSMutableArray array];
    }
    
    return _dataList;
}


@end
