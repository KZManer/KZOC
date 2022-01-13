//
//  CLiveCourseListView.h
//  KZOC
//
//  Created by Zzz... on 2022/1/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

///顶部item枚举
typedef enum : NSUInteger {
    ///高端直播课
    CLCTopItemType_GaoDuan = 0,
    ///精品直播课
    CLCTopItemType_JingPin,
    ///精选微课
    CLCTopItemType_JingXuan,
    ///未知类型
    CLCTopItemType_Unknown,
    
} CLCTopItemType;

typedef enum : NSUInteger {
    ///未知类型
    CLCListType_Unknown,
    ///全部
    CLCListType_All,
    ///最新
    CLCListType_New,
    ///最热
    CLCListType_Hot,
    ///最优惠
    CLCListType_Discount,
    
} CLCListType;

@interface CLiveCourseListView : UIView

- (instancetype)initWithFrame:(CGRect)frame topItemType:(CLCTopItemType)topItemType listType:(CLCListType)listType;

@end

NS_ASSUME_NONNULL_END
