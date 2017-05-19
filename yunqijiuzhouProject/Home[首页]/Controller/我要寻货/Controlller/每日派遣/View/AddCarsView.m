//
//  AddCarsView.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/2.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import "AddCarsView.h"
#import "InfoCollectionView.h"
#import "HeaderView.h"
#import "CarModel.h"

static NSString *kAddCarsCellID = @"kAddCarsCellID";

@interface AddCarsView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) InfoCollectionView *carsView;
@property (nonatomic, strong) InfoCollectionView *driverView;

//确定按钮
@property (nonatomic, strong) UIButton *confirmButton;

//头视图
@property (nonatomic, weak) HeaderView *headerView;


@end

@implementation AddCarsView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        
        self.delegate = self;
        self.dataSource = self;
        //[self registerClass:[UITableViewCell class] forCellReuseIdentifier:kAddCarsCellID];
        self.bounces = NO;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return self;
}

//数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //取消复用
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAddCarsCellID forIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAddCarsCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kAddCarsCellID];
    }
    
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        [cell.contentView addSubview:self.carsView];
    } else if (indexPath.section == 1) {
        [cell.contentView addSubview:self.driverView];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return self.carsView.cellHeight;
    } else if (indexPath.section == 1) {
        return self.driverView.cellHeight;
    } else {
        return 0;
    }
}

/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    return @"选择车牌";
}
*/
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        HeaderView *headerView = [[HeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44)];
        headerView.headerTitle = @"选择车辆";
        headerView.isText = NO;
        if (self.selectedCarModel) {
            headerView.selectedModel = self.selectedCarModel;
        }
        return headerView;
    } else if (section == 1) {
        HeaderView *headerView = [[HeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44)];
        headerView.headerTitle = @"选择司机";
        headerView.isText = NO;
        if (self.selectedDriverModel) {
            headerView.selectedModel = self.selectedDriverModel;
        }
        return headerView;
    } else {
        HeaderView *headerView = [[HeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44)];
        headerView.headerTitle = @"请输入承载量:";
        headerView.isText = YES;
        self.headerView = headerView;
        return headerView;
    }

}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 44;
}


- (InfoCollectionView *)carsView {

    if (_carsView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake(ScreenW / 4, 30);
        
        CGFloat height = (self.carList.count / 4 + 1) * 30;
        
        _carsView = [[InfoCollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, height) collectionViewLayout:flowLayout];
        _carsView.columns = 4;
        _carsView.infoList = self.carList;
        __weak AddCarsView *weakSelf = self;
        _carsView.selectedBlock = ^(NSInteger selectedItem){
        
            __strong AddCarsView *strongSelf = weakSelf;
            //NSLog(@"%ld", selectedItem);
            strongSelf.selectedCarModel = strongSelf.carList[selectedItem];
            //第一个section刷新
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
            [strongSelf reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        };
    }
    
    return _carsView;
}

- (InfoCollectionView *)driverView {
    
    if (_driverView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake(ScreenW / 3, 30);
        
        CGFloat height = (self.driverList.count / 3 + 1) * 30;
        
        _driverView = [[InfoCollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, height) collectionViewLayout:flowLayout];
        _driverView.columns = 3;
        _driverView.infoList = self.driverList;
        __weak AddCarsView *weakSelf = self;
        _driverView.selectedBlock = ^(NSInteger selectedItem){
            
            __strong AddCarsView *strongSelf = weakSelf;
            //NSLog(@"%ld", selectedItem);
            strongSelf.selectedDriverModel = strongSelf.driverList[selectedItem];
            //第二个section刷新
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:1];
            [strongSelf reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        };
    }
    
    return _driverView;
}


//获取车载吨数
- (NSString *)czds {
    
    //NSLog(@"%@", self.headerView.czds);
    
    return self.headerView.czds;
    
}

@end
