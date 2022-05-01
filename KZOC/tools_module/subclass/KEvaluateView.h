//
//  KEvaluateView.h
//  Runner
//
//  Created by KZ on 2021/7/20.
//  评价view 内容多选

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^KSelectFinishHandler)(NSInteger starNum,NSArray *selectIds);

@interface KEvaluateView : UIView

/**可定制参数*/

/**取消 & 确认按钮的背景色*/
@property (nonatomic, strong) UIColor *pickerButtonColor;

/**数据列数（默认为3）*/
//@property (nonatomic, assign) NSInteger *columnNum;

/************/

/**
 @brief 评价选择器，block返回星星个数和评价的内容id数组
 @param view        要展示在哪个view上
 @param titleArr    数据源（name数组）
 @param idArr       数据源（id数组）
 @param handler     结果回调
 @return 返回view对象
 */
+ (instancetype)showInView:(UIView *)view titleArr:(NSArray *)titleArr idArr:(NSArray *)idArr finishHandler:(KSelectFinishHandler)handler;
@end

NS_ASSUME_NONNULL_END
