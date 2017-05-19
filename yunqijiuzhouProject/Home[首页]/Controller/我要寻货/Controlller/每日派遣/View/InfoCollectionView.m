//
//  InfoCollectionView.m
//  yunqijiuzhouProject
//
//  Created by 李龙 on 2017/5/2.
//  Copyright © 2017年 yunqijiuzhou. All rights reserved.
//

#import "InfoCollectionView.h"
#import "InfoCollectionViewCell.h"

static NSString *kInfoCollectionViewCellID = @"kInfoCollectionViewCellID";

@interface InfoCollectionView()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) InfoCollectionViewCell *selectedCell;

@end

@implementation InfoCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {

    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = [UIColor clearColor];
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[InfoCollectionViewCell class] forCellWithReuseIdentifier:kInfoCollectionViewCellID];
        self.bounces = NO;
    }
    
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.infoList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    InfoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kInfoCollectionViewCellID forIndexPath:indexPath];
    
    //cell.backgroundColor = RandomColor;
    cell.model = self.infoList[indexPath.item];
    //cell.driverModel = self.driverInfoList[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    InfoCollectionViewCell *cell = (InfoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
     
    self.selectedCell.isSelected = NO;
    cell.isSelected = YES;
    self.selectedCell = cell;
    
    self.selectedBlock(indexPath.item);
    
}


- (CGFloat)cellHeight {

    return (self.infoList.count / self.columns + 1) * 30;
}

@end
