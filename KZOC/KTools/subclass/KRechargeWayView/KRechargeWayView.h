//
//  KRechargeWayView.h
//  Runner
//
//  Created by KZ on 2021/7/24.
//  充值途径：微信？支付宝？

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    /**微信支付*/
    RechargeWayWechat = 0,
    /**支付宝支付*/
    RechargeWayAlipay,
    /**未选择支付方式*/
    RechargeWayNone,
} RechargeWay;

typedef void(^KRechargeSelectFinishHandler)(RechargeWay rechargeWay);

@interface KRechargeWayView : UIView

/************/

/**
 @brief 支付方式选择器，block返回选中支付方式
 @param view          要展示在哪个view上
 @param rechargeMoney 要充值的金额
 @param handler       结果回调
 @return 返回view对象
 */
+ (instancetype)showInView:(UIView *)view rechargeMoney:(NSString *)rechargeMoney finishHandler:(KRechargeSelectFinishHandler)handler;

@end

NS_ASSUME_NONNULL_END
