//
//  CJReportProgressView.h
//  KingTalent
//
//  Created by 崔敬通 on 2020/9/30.
//  Copyright © 2020 yizhilu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJReportProgressView : UIView
/**
 进度条色
 */
@property (nonatomic,strong)UIColor * progressColor;

/**
 进度条背景色
 */
@property (nonatomic,strong)UIColor * progressBackColor;

/**
 进度0~1
 */
@property (nonatomic,assign)CGFloat   proportion;

/**
 数据
 */
@property (nonatomic,strong)NSString * data;

/**
 数据名称
 */
@property (nonatomic,strong)NSString * dataName;
/**
 初始化方法
 @param frame 位置
 @param backColor 进度条背景色,默认白色
 @param color 进度条颜色
 */
+(instancetype)createProgressWithFrame:(CGRect)frame backColor:(UIColor *)backColor color:(UIColor *)color proportion:(CGFloat)proportion;

/**
 展示进度条
 */
-(void)showProgress;

/**
 展示数据内容
 */
-(void)showContentData;
@end

NS_ASSUME_NONNULL_END
