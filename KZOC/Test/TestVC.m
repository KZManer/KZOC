//
//  TestVC.m
//  KZOC
//
//  Created by KZ on 2021/10/28.
//

#import "TestVC.h"
#define ITEM_SIZE   10
#define DISTANCE    20
@interface TestVC ()<UIScrollViewDelegate>

@end

@implementation TestVC {
    UIView *_vCircle;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    UIScrollView *sv = [UIScrollView new];
    sv.delegate = self;
    [self.view addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    UIView *vContain = [UIView new];
    vContain.backgroundColor = [UIColor grayColor];
    [sv addSubview:vContain];

    [vContain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sv);
        make.height.equalTo(self.view.mas_height);
        make.width.equalTo(self.view).multipliedBy(2);
    }];

    _vCircle = [UIView new];
    _vCircle.backgroundColor = [UIColor redColor];
    _vCircle.layer.masksToBounds = YES;
    _vCircle.layer.cornerRadius = ITEM_SIZE / 2.;
    [self.view addSubview:_vCircle];

    [_vCircle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(ITEM_SIZE, ITEM_SIZE));
    }];
}

///基本思路是在横向滑动过程中改变小圆点的宽和X坐标
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat percent = scrollView.contentOffset.x / scrollView.contentSize.width * 2;
    percent = MIN(1, MAX(0, percent));

///小圆点是先变宽 移动到一半后开始恢复
    CGFloat scalePercent = percent < .5 ? percent : 1 - percent;

    [_vCircle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ITEM_SIZE + ITEM_SIZE * scalePercent);
        make.centerX.mas_equalTo(DISTANCE * percent);
    }];
    [_vCircle layoutIfNeeded];
}

@end
