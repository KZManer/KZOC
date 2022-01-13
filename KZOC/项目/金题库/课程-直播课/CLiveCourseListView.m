//
//  CLiveCourseListView.m
//  KZOC
//
//  Created by Zzz... on 2022/1/5.
//

#import "CLiveCourseListView.h"

@interface CLiveCourseListView ()
@property (nonatomic, assign) CLCTopItemType topItemType;
@property (nonatomic, assign) CLCListType listType;
@end

@implementation CLiveCourseListView

- (instancetype)initWithFrame:(CGRect)frame topItemType:(CLCTopItemType)topItemType listType:(CLCListType)listType {
    self = [super initWithFrame:frame];
    if (self) {
        self.topItemType = topItemType;
        self.listType = listType;
        [self doViewUI];
    }
    return self;
}

- (void)doViewUI {
    self.backgroundColor = [[KTools tools_colorRandom] colorWithAlphaComponent:.4];
    
    UILabel *label = [[UILabel alloc]init];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    NSString *itemTitle = @"未知";
    switch (self.topItemType) {
        case CLCTopItemType_GaoDuan:
            itemTitle = @"高端直播课"; break;
        case CLCTopItemType_JingPin:
            itemTitle = @"精品直播课"; break;
        case CLCTopItemType_JingXuan:
            itemTitle = @"精选微课"; break;
        default: break;
    }
    
    NSString *showTitle = @"未知";
    switch (self.listType) {
        case CLCListType_All:
            showTitle = @"全部"; break;
        case CLCListType_New:
            showTitle = @"最新"; break;
        case CLCListType_Hot:
            showTitle = @"最热"; break;
        case CLCListType_Discount:
            showTitle = @"最优惠"; break;
        default:break;
    }
    label.text = [NSString stringWithFormat:@"%@-%@",itemTitle,showTitle];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.font = [UIFont font_fontPingFangSCBold:34];
    label.textColor = [KTools tools_colorRandom];
    
}

@end
