//
//  KTools.h
//  KZProduct
//
//  Created by KZ on 2019/11/8.
//  Copyright © 2019年 ZK. All rights reserved.
//
/**
 *********************************************************
 ******************                ***********************
                        工具类
 ******************                ***********************
 *********************************************************
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KTools : NSObject

#pragma mark - 控件高度-宽度 define
//屏幕宽度
#define Width_Screen [KTools tools_widthOfScreen]
//屏幕高度
#define Height_Screen [KTools tools_heightOfScreen]
//状态栏高度
#define Height_Status [KTools tools_heightOfStatus]
//导航栏高度
#define Height_Navigation [KTools tools_heightOfNavigation]
//状态栏+导航栏高度
#define Height_Status_Navigation [KTools tools_heightOfStatusAndNavigation]
//菜单栏高度
#define Height_TabBar [KTools tools_heightOfTabBar]
//主屏幕高度1（设备高度-状态栏高度-菜单栏高度-导航栏高度）
#define Height_Active_Min [KTools tools_heightOfActiveAreaMin]
//主屏幕高度2（设备高度-状态栏高度-导航栏高度）
#define Height_Active_Max [KTools tools_heightOfActiveAreaMax]
//底部区域,具有刘海儿的屏幕底部为34,其他手机为0,目前适配到iPhone13，之后的机型还没出
#define Height_Bottom_Space [KTools tools_heightOfBottomSpace]

#pragma mark - 控件高度-宽度

/**
 * 获取屏幕宽度
 */
+ (CGFloat)tools_widthOfScreen;

/**
 * 获取屏幕高度
 */
+ (CGFloat)tools_heightOfScreen;

/**
 * 获取状态栏的高度
*/
+ (CGFloat)tools_heightOfStatus;

/**
*  获取导航栏的高度
*/
+ (CGFloat)tools_heightOfNavigation;

/**
* 获取状态栏+导航栏的高度
 */
+ (CGFloat)tools_heightOfStatusAndNavigation;

/**
*  获取菜单栏的高度
*/
+ (CGFloat)tools_heightOfTabBar;

/**
 *  获取主屏幕的高度（设备的高度-状态栏高度-菜单栏高度-导航栏高度）
 */
+ (CGFloat)tools_heightOfActiveAreaMin;

/**
 *  获取主屏幕的高度（设备的高度-状态栏高度-导航栏高度）
 */
+ (CGFloat)tools_heightOfActiveAreaMax;

/**
 底部区域,具有刘海儿的屏幕底部为34,其他手机为0
 目前适配到iPhone13，之后的机型还没出
 */
+ (CGFloat)tools_heightOfBottomSpace;

/**
* 根据文字内容计算文本高度
 */
+ (CGFloat)tools_getTextHeight:(NSString *_Nullable)text width:(CGFloat)width font:(UIFont *_Nonnull)font;

/**计算文本的宽度*/
+ (CGFloat)tools_getTextWidth:(NSString *_Nullable)text font:(UIFont *_Nonnull)font height:(CGFloat)height;
/**
* 计算textView的高度
 */
+ (CGFloat)tools_getTextViewHeight:(NSString *_Nullable)text font:(UIFont *_Nonnull)font width:(CGFloat)width;

#pragma mark - 字符串处理
/** 字符串拼接 */
+ (NSString *_Nullable)tools_JointStringWithPreString:(NSString *_Nullable)perStr sufString:(NSString *_Nullable)sufStr;

/**
 设置字符串的固定范围颜色,格式：@[@[UIColor,int,int]] 第一个参数：颜色 | 第二个参数：NSRnage的loc ｜ 第三个参数：NSRange的len，可以添加多个数组
 @param string 要操作的字符串
 @param arr 具体操作范围 格式：
 
 @return 返回更新后的字符串
 */
+ (NSAttributedString *_Nonnull)tools_stringWithCustomColor:(NSString *_Nonnull)string attributeArr:(NSArray *_Nullable)arr;

/**
 @brief 去除空格
 @param string 原始字符串
 @return 去除空格后的字符串
 */
+ (NSString *_Nullable)tools_stringKillBlankWithString:(NSString *_Nonnull)string;

/**
 @brief 过滤掉重复的名称，如果省和市一样，过滤掉一个
 @param province 省
 @param city     市
 @param district 区
 @return 过滤后的字符串
 */
+ (NSString *_Nullable)tools_filterRepeatString:(NSString *_Nullable)province city:(NSString *_Nullable)city district:(NSString *_Nullable)district;

#pragma mark 富文本
/**
 @brief 简单的富文本封装（使用见.m方法实现）
 @param text    要操作的文本内容
 @param attrArr 要改变的属性数组
 @return 改变后的富文本
 */
+ (NSAttributedString *_Nonnull)tools_stringRichText:(NSString *_Nonnull)text attrArr:(NSArray *_Nullable)attrArr;

/**
 @brief 段落富文本封装（使用见.m方法实现）
 @param space         段落之间的间隔
 @param textAlignment 文本对齐方式
 @param attrArr       要改变的段落属性数组
 @return 改变后的富文本
 */
+ (NSAttributedString *_Nullable)tools_stringRichTextParagraphSpaceing:(CGFloat)space textAlignment:(NSTextAlignment)textAlignment attrArr:(NSArray *_Nullable)attrArr;

#pragma mark - 判断

/**
*  判断字符串是否为空
 */
+ (BOOL)tools_isBlankString:(NSString *_Nullable)string;

#pragma mark 手机判断

/**
 * 判断设备是否为手机&&刘海屏幕
 */
+ (BOOL)tools_deviceIsIphoneX;

#pragma mark - 比较
/**
 @brief:比较两个时间哪个大(yyyy-MM-dd HH:mm:ss)
 @param firstTime 第一个时间
 @param secondTime 第二个时间
 @return 0:相等 1:firstTime大 -1:firstTime小 2:未知
 */
+ (int)tools_compareTimeWithFirstTime:(NSString *_Nonnull)firstTime secondTime:(NSString *_Nonnull)secondTime;
/**
 @brief:比较指定时间是否比当前时间大(yyyy-MM-dd HH:mm:ss)
 @param givenTime 指定的时间
 @return ture:当前时间大 false:指定时间大
 */
+ (BOOL)tools_compareCurrentTimeBigWithGivenTime:(NSString *_Nonnull)givenTime;

#pragma mark - 手机号

/**
 @brief 随机生成11位手机号
*/
+ (void)tools_phoneRandomNum:(void (^_Nullable)(NSString * _Nonnull fullNum,NSString *_Nonnull secretNum))phoneNum ;

/**
 @brief 拨打电话
 @param phoneNum          电话号码
 @param completionHandler 回调结果
  */
+ (void)tools_phoneCall:(NSString *_Nonnull)phoneNum completionHandler:(void (^_Nullable)(BOOL success))completionHandler;

#pragma mark - 时间处理
/**
*  获得当前时区的时间戳
*  格林尼治平均时(GMT, Greenwich Mean Time)
*/
+ (NSString *_Nonnull)tools_getCurrentDateLine;

/**
 *  获取当前时区的时间
 *
 *  @return 当前时区的时间
 */
+ (NSString *_Nullable)tools_getCurrentDate:(NSString *_Nonnull)format;

/**
 @brief 时间转换为时间戳(formatter ：类似YYYY-MM-dd hh:mm:ss，hh为12小时制,HH为24小时制，根据具体时间格式传入对应的formatter)
 @param date 时间
 @param formatter 时间格式
 */
+ (NSString *_Nullable)tools_timeConvertToTimestamp:(NSString *_Nullable)date dateFormatter:(NSString *_Nullable)formatter;

/**
 @brief 时间戳转时间
 @param timestamp 时间戳
 @param formatter 要转换的时间格式
 @return 转换后的时间
 */
+ (NSString *_Nonnull)tools_timeTimestampConvertToTime:(NSString *_Nullable)timestamp dateFormatter:(NSString *_Nullable)formatter;
/**
 @brief 时间：NSString => NSDate
 @param timeStr   时间字符串
 @param formatter 时间格式
 @note 如果timeStr为空或者不能解析，会返回当日时间
 */
+ (NSDate *_Nonnull)tools_timeStringConvertToDate:(NSString *_Nullable)timeStr dateFormatter:(NSString *_Nullable)formatter;

/**
 @brief 时间：NSDate => NSString
 @param date      时间(NSDate)
 @param formatter 时间格式
 */
+ (NSString *_Nonnull)tools_timeDateConvertToString:(NSDate *_Nullable)date dateFormatter:(NSString *_Nullable)formatter;

#pragma mark - 转换
#pragma mark 类型转换
+ (NSString *_Nonnull)tools_arrayConvertToString:(NSArray *_Nonnull)array;

+ (NSArray *_Nonnull)tools_stringConvertToArray:(NSString *_Nonnull)string;

/**
 @brief 将字符串数组中以separator作为分隔符转换为字符串,默认逗号(,)分隔
 @param array     要转换的数组
 @param separator 分隔符
 @return 转换后的字符串
 */
+ (NSString *_Nullable)tools_arrayConvertToString:(NSArray<NSString *> *_Nullable)array separator:(NSString *_Nullable)separator;

/**
 *  @brief 图片 -> base64
 *  @param image 图片
 *  @param quality 压缩系数(0-1)
 *  @return base64
 */
+ (NSString *_Nullable)tools_imageConvertToBase64:(UIImage *_Nullable)image compressionQuality:(CGFloat)quality ;

/**
 *  @brief base64 -> 图片
 *  @param base64 base64字符串
 *  @return 图片
 */
+ (UIImage *_Nullable)tools_base64ConvertToImage:(NSString *_Nullable)base64;

/**
 @brief 将数组转换为json数组
 @param array 要转换的数组
 @return json数组
 */
+ (NSString *_Nullable)tools_arrayConvertToJsonArray:(NSArray *_Nullable)array;
/**
 @brief 将图片数组转换为base64串，多张图片用逗号分隔
 @param images 图片数组
 @return base64串
 */
+ (NSString *_Nullable)tools_imagesConvertToBase64String:(NSArray<UIImage *> *_Nullable)images;

/**
 @brief 根据颜色生成对应颜色的图片
 @param color 要生成的图片的颜色
 @return 生成的图片
 */
+ (UIImage *_Nullable)tools_convertImageWithColor:(UIColor *_Nonnull)color;

#pragma mark 单位转换
/**
 @brief 单位转换 米=>公里
 @param distance 距离（单位米）
 @return 转换后的公里（NSString类型）
 */
+ (NSString *_Nonnull)tools_convertMeterToKilometer:(CGFloat)distance;

#pragma mark - 文本 加密（MD5 SHA256）

+ (NSString *_Nonnull)tools_MD5:(NSString *_Nonnull)string;

+ (NSString *_Nonnull)tools_SHA256:(NSString *_Nonnull)string;

#pragma mark - 颜色相关

/**
*  返回一个随机的颜色
*/
+ (UIColor *_Nonnull)tools_colorRandom;

/**
 @brief 16进制 => UIColor
 @param hexColor 16进制色值
 @return UIColor
 */
+ (UIColor *_Nonnull)tools_colorWithHexString:(NSString *_Nonnull)hexColor;

/**
 @brief 16进制 => UIColor
 @param hexColor 16进制色值
 @param alpha    透明度
 @return UIColor
 */
+ (UIColor *_Nonnull)tools_colorWithHexString:(NSString *_Nonnull)hexColor alpha:(CGFloat)alpha;

#pragma mark - 图片
/**
 @brief 打印图片的大小
 @param image 图片
 */
+ (void)tools_imageFileSize:(UIImage *_Nullable)image;

/**
 @brief 图片添加水印
 @param image    图片
 @param showText 展示的内容
 @return 添加完水印的图片
 */
+ (UIImage *_Nonnull)tools_imageAddWatermark:(UIImage *_Nonnull)image showText:(NSString *_Nullable)showText;

/**
 @brief 截取当前屏幕
 @return 返回截屏图
 */
+ (UIImage *_Nonnull)tools_imageSnapshotWithScreen;

/**
 @brief 将指定的view转成图片
 @param view 要转成图片的view
 @return 转换后的图片
 */
+ (UIImage *_Nonnull)tools_imageSnapshotWithView:(UIView *_Nonnull)view;

/**
 @brief 获取某个scrollView上的截图
 @param scrollView 要截取的scrollView
 @return 转换后的图片
 */
+ (UIImage *_Nonnull)tools_imageSnapshotWithScrollviewShot:(UIScrollView *_Nonnull)scrollView;

/**
 @brief 获得某个范围内的屏幕图像
 @param innerView 要操作view
 @param rect 要截取的大小
 @return 转换后的图片
 */
+ (UIImage *_Nonnull)tools_imageSnapshotWithCurrentInnerViewShot:(UIView *_Nonnull) innerView atFrame:(CGRect)rect;

#pragma mark - 动画

/**
 @brief 闪烁动画：使用[view.layer addAnimation:[KTools tools_animationOpacityForever:0.6] forKey:nil];
 @param time 变换时长
 */
+ (CABasicAnimation *_Nonnull)tools_animationOpacityForever:(float)time;

#pragma mark - 打印设备信息
/**
 @brief 打印设备信息
 */
+ (void)tools_printEquipParameter;


@end


#pragma mark - ***************** KViewTools *****************

@interface KViewTools : UIView

/**
 @brief 展示提示信息，只做展示
 
 @param title       标题
 @param message     展示信息
 @param showVC      要展示在哪个viewcontroller上
 */
+ (void)viewTools_showAlertWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message showViewController:(UIViewController *_Nonnull)showVC;

/**
 @brief 展示提示信息，增加确认按钮处理事件
 
 @param title           标题
 @param message         展示信息
 @param showVC          要展示在哪个viewcontroller上
 @param confirmHandler  确认按钮事件
 */
+ (void)viewTools_showAlertWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message certainTitle:(NSString *_Nullable)certainTitle showViewController:(UIViewController *_Nonnull)showVC confirmAction:(void(^_Nullable)(UIAlertAction *_Nonnull confirmAction))confirmHandler;
@end

