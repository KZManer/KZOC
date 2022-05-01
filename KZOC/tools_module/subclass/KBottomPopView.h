//
//  KBottomPopView.h
//  Runner
//
//  Created by KZ on 2021/6/16.
//  数据选择器二

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^KBottomPopViewSelectFinishHandler)(NSInteger selectIndex,NSString *selectTitle);

@interface KBottomPopView : UIView

/**可定制参数*/

/**取消 & 确认按钮的背景色*/
@property (nonatomic, strong) UIColor *pickerButtonColor;

/**数据列数（默认为3）*/
//@property (nonatomic, assign) NSInteger *columnNum;

/************/

/**
 @brief 数据选择器，block返回选中数据的下标和内容
 @param view        要展示在哪个view上
 @param titleArr    数据源（数组）
 @param showIndex   默认要展示下标为几的数据
 @param handler     结果回调
 @return 返回view对象
 */
+ (instancetype)showInView:(UIView *)view titleArr:(NSArray *)titleArr showIndex:(NSInteger)showIndex finishHandler:(KBottomPopViewSelectFinishHandler)handler;

@end

NS_ASSUME_NONNULL_END
