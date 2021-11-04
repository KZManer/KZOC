//
//  CRBoxFlowLayout.m
//  CaiShenYe
//
//  Created by Chobits on 2019/1/3.
//  Copyright © 2019 Chobits. All rights reserved.
//

#import "CRBoxFlowLayout.h"

@implementation CRBoxFlowLayout

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self initPara];
    }
    
    return self;
}

- (void)initPara
{
    self.ifNeedEqualGap = YES;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsZero;
    self.itemNum = 1;
}

- (void)prepareLayout
{
    if (_ifNeedEqualGap) {
        [self autoCalucateLineSpacing];
    }
    
    [super prepareLayout];
}

- (void)autoCalucateLineSpacing
{
    self.minimumLineSpacing = 7;
    self.minimumInteritemSpacing = 7;
}

@end
