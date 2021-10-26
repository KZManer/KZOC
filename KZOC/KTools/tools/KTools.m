//
//  KTools.m
//  KZProduct
//
//  Created by KZ on 2019/11/8.
//  Copyright © 2019年 ZK. All rights reserved.
//

#import "KTools.h"
#import <CommonCrypto/CommonDigest.h>

@implementation KTools

#pragma mark - 控件高度-宽度
//获取屏幕宽度
+ (CGFloat)tools_widthOfScreen {
    return [UIScreen mainScreen].bounds.size.width;
}

//获取屏幕高度
+ (CGFloat)tools_heightOfScreen {
    return [UIScreen mainScreen].bounds.size.height;
}
//获取状态栏的高度
+ (CGFloat)tools_heightOfStatusBar {
    
    if (@available(iOS 13,*)) {
//        iOS 13.0 之后使用
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        CGRect statusBarRectFrame = statusBarManager.statusBarFrame;
        return statusBarRectFrame.size.height;
    } else {
//        iOS 13.0 之前使用
        CGRect statusBarRectFrame = [[UIApplication sharedApplication] statusBarFrame];
        return statusBarRectFrame.size.height;
    }
}

//获取导航栏的高度
+ (CGFloat)tools_heightOfNavigationBar {

    return 44.0;
}

// 获取状态栏+导航栏的高度
+ (CGFloat)tools_heightOfStatusBarAndNavigationBar {
    return ([self tools_heightOfStatusBar] + [self tools_heightOfNavigationBar]);
}
//获取菜单栏的高度
+ (CGFloat)tools_heightOfTabBar {
    return [self tools_deviceIsIphoneX]?(49.f + 34.f):49.f;
}
//获取主屏幕的高度（设备的高度-状态栏高度-菜单栏高度-导航栏高度）
+ (CGFloat)tools_heightOfActiveArea {
    CGFloat height = [KTools tools_heightOfScreen] - [KTools tools_heightOfStatusBarAndNavigationBar] - [KTools tools_heightOfTabBar];
    return height;
}
//获取主屏幕的高度（设备的高度-状态栏高度-导航栏高度）
+ (CGFloat)tools_heightOfActiveAreaWithTabBar {
    CGFloat height = [KTools tools_heightOfScreen] - [KTools tools_heightOfStatusBarAndNavigationBar];
    return height;
}

//计算文本高度
+ (CGFloat)tools_getTextHeight:(NSString *)text width:(CGFloat)width font:(UIFont *)font {
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return textRect.size.height;
}
//计算文本的宽度
+ (CGFloat)tools_getTextWidth:(NSString *)text font:(UIFont * _Nonnull)font height:(CGFloat)height {
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
    return size.width;
}
//计算textView的高度
+ (CGFloat)tools_getTextViewHeight:(NSString *)text font:(UIFont*)font width:(CGFloat)width {
    //初始化textView
    UITextView *textView = [[UITextView alloc] init];
    [textView setText:text];
    [textView setFont:font];
    
    CGSize size = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return size.height;
}
#pragma mark - 字符串处理
//字符串拼接
+ (NSString *)tools_JointStringWithPreString:(NSString *)perStr sufString:(NSString *)sufStr {
    if ([self tools_isBlankString:perStr]) {
        perStr = @"";
    }
    if ([self tools_isBlankString:sufStr]) {
        sufStr = @"";
    }
    NSString *jointStr = [NSString stringWithFormat:@"%@%@",perStr,sufStr];
    return jointStr;
}

//设置字符串的固定范围颜色
+ (NSAttributedString *)tools_stringWithCustomColor:(NSString *)string attributeArr:(NSArray *)arr {
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:string];
    
    for (NSArray *ar in arr) {
        
        if (ar.count != 3) {
            NSAssert(false, @"KTools : array count error,should be three elements");break;
        }
        
        id colorId = ar[0];
        if (![colorId isKindOfClass:[UIColor class]]) {
            NSAssert(false, @"颜色类型设置错误");
            break;
        }
        UIColor *color = (UIColor *)colorId;
        NSUInteger loc = [ar[1] intValue];
        NSUInteger len = [ar[2] intValue];
        
        //要进行富文本的子字符串 超出父字符串的范围，返回
        if (loc >= string.length || (loc+len)>string.length ) {
            NSAssert(false, @"NSRange范围越界");
            break;
        }
        
        [attString addAttributes:@{NSForegroundColorAttributeName:color} range:NSMakeRange(loc, len)];
    };
    return attString;
}
/**去除空格*/
+ (NSString *)tools_stringKillBlankWithString:(NSString *)string {
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];;
}

/**过滤掉重复的名称，如果省和市一样，过滤掉一个*/
+ (NSString *_Nullable)tools_filterRepeatString:(NSString *_Nullable)province city:(NSString *_Nullable)city district:(NSString *_Nullable)district {
    NSString *pro = province == nil ? @"" : province;
    NSString *cit = city == nil ? @"" : city;
    NSString *dis = district == nil ? @"" : district;
    
    if ([pro isEqualToString:cit]) {
        if ([cit isEqualToString:dis]) {
            return pro;
        }
        return [NSString stringWithFormat:@"%@%@",pro,dis];
    } else {
        if ([cit isEqualToString:dis]) {
            return [NSString stringWithFormat:@"%@%@",pro,cit];
        }
    }
    return [NSString stringWithFormat:@"%@%@%@",pro,cit,dis];
}
#pragma mark 富文本
/**
 简单的富文本封装
 @[@{
    @"foregroundColor":[UIColor redColor],
    @"font":[UIFont systemFontOfSize:22],
    @"location":@0,
    @"length":@4,
    },@{
    @"foregroundColor":[UIColor orangeColor],
    @"location":@4,
    @"length":@3,
    },]
 */
+ (NSAttributedString *_Nonnull)tools_stringRichText:(NSString *_Nonnull)text attrArr:(NSArray *_Nullable)attrArr {
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:text];
    
    for (NSDictionary *dic in attrArr) {
        
        //字体颜色（默认黑色）
        NSString *foregroundKey = @"foregroundColor";//字体颜色
        UIColor *foregroundColor = [UIColor blackColor];
        if (dic[foregroundKey] && [dic[foregroundKey] isKindOfClass:[UIColor class]]) {
            foregroundColor = dic[foregroundKey];
        }
        //字体大小（默认15）
        NSString *fontKey = @"font";
        UIFont *font = [UIFont systemFontOfSize:15.f];
        if (dic[fontKey] && [dic[fontKey] isKindOfClass:[UIFont class]]) {
            font = dic[fontKey];
        }
        //作用范围，默认(0,0)
        NSString *locKey = @"location";
        int location = [dic[locKey] intValue];
        NSString *lenKey = @"length";
        int length = [dic[lenKey] intValue];
        NSRange range = NSMakeRange(location, length);

        [attrString setAttributes:@{
            NSForegroundColorAttributeName:foregroundColor,
            NSFontAttributeName:font,
        } range:range];
    }
    
    return attrString;
}
//段落简单的富文本封装
//@[@{
//   @"text":@"第一段文本",
//   @"font":[UIFont fontWithName: @"Arial-BoldMT" size:18],
//   @"foregroundColor":[UIColor redColor],
//   },@{
//   @"text":@"第二段文本",
//   @"font":[UIFont systemFontOfSize:18],
//   @"foregroundColor":[UIColor orangeColor],
//   },]

+ (NSAttributedString *)tools_stringRichTextParagraphSpaceing:(CGFloat)space textAlignment:(NSTextAlignment)textAlignment attrArr:(NSArray *)attrArr {
    NSString *textKey = @"text";//段落文本
    NSString *fontKey = @"font";//段落字体大小
    NSString *foregroundKey = @"foregroundColor";//段落字体颜色
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:@""];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    //行间距
//    paragraphStyle.lineSpacing = 0;
    paragraphStyle.paragraphSpacing = space;
    paragraphStyle.alignment = textAlignment;
    
    NSString *completeString = @"";
    
    for (NSDictionary *dic in attrArr) {
        //段落内容
        NSString *text = @"请设置段落文本";
        if (dic[textKey] && [dic[textKey] isKindOfClass:[NSString class]]) {
            text = dic[textKey];
        }
        //字体大小（默认15）
        UIFont *font = [UIFont systemFontOfSize:15.f];
        if (dic[fontKey] && [dic[fontKey] isKindOfClass:[UIFont class]]) {
            font = dic[fontKey];
        }
        //字体颜色
        UIColor *foregroundColor = [UIColor blackColor];
        if (dic[foregroundKey] && [dic[foregroundKey] isKindOfClass:[UIColor class]]) {
            foregroundColor = dic[foregroundKey];
        }
        
//        NSAttributedString *tempText = [[NSAttributedString alloc]initWithString:text];
//        [attributedText appendAttributedString:tempText];
        
        if ([completeString isEqualToString:@""]) {
            completeString = [completeString stringByAppendingString:text];
            NSAttributedString *tempText = [[NSAttributedString alloc]initWithString:text];
            [attributedText appendAttributedString:tempText];
        } else {
            completeString = [completeString stringByAppendingFormat:@"\n%@",text];
            NSAttributedString *tempText = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n%@",text]];
            [attributedText appendAttributedString:tempText];
        }
        NSRange range = [completeString rangeOfString:text];
        
        //设置段落文字样式
        [attributedText setAttributes:@{
            NSForegroundColorAttributeName:foregroundColor,
            NSFontAttributeName:font,
            NSParagraphStyleAttributeName:paragraphStyle,//设置行间距
        } range:range];
    }
    
    return attributedText;
}

#pragma mark - 判断
//判断字符串是否为空
+ (BOOL)tools_isBlankString:(NSString *)string {
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        return YES;
    }
    
    return NO;
}
#pragma mark - 手机判断

//判断设备是否为手机&&刘海屏幕
+ (BOOL)tools_deviceIsIphoneX {
    
    BOOL isPhone;
    if (@available(ios 13,*)) {
        
        isPhone = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
        
    } else {
        
        isPhone = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
        
    }
    BOOL isiOS11 = [[[UIDevice currentDevice]systemVersion]floatValue]>=11.f;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    BOOL minBool = (MIN(screenSize.width, screenSize.height) >= 375.f);
    BOOL maxBool = (MAX(screenSize.width, screenSize.height) >= 812.f);
    if (isPhone && isiOS11 && minBool && maxBool) {
        return YES;
    }
    return NO;
    
}
#pragma mark - 比较
/**比较两个日期，第一个是不是比第二个大（第一个日期靠后）*/
+ (BOOL)tools_firstDateBigThanSecondDate:(NSDate *_Nonnull)firstDate secondDate:(NSDate *_Nonnull)secondDate {
    return false;
}
#pragma mark - 颜色相关

//返回一个随机的颜色
+ (UIColor *)tools_colorRandom {
    int arcRed = arc4random()%256;
    int arcGreen = arc4random()%256;
    int arcBlue = arc4random()%256;
    //    float arcAlpha = arc4random()%101/100.0;
    float arcAlpha = 1.0;
    UIColor *color = [UIColor colorWithRed:arcRed/255.0 green:arcGreen/255.0 blue:arcBlue/255.0 alpha:arcAlpha];
    return color;
}

//16进制 => UIColor
+ (UIColor *)tools_colorWithHexString:(NSString *)hexColor {
    return [self tools_colorWithHexString:hexColor alpha:1.0f];
}

//16进制 => UIColor
+ (UIColor *)tools_colorWithHexString:(NSString *)hexColor alpha:(CGFloat)alpha {
    //删除字符串中的空格
    NSString *cString = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

#pragma mark - 手机号

//随机生成11位手机号
+ (void)tools_phoneRandomNum:(void (^)(NSString *fullNum,NSString *secretNum))phoneNum {
    /*中国电信号段
     133、149、153、173、177、180、181、189、191、193、199
     中国联通号段
     130、131、132、145、155、156、166、171、175、176、185、186
     中国移动号段
     134、135、136、137、138、139、147、150、151、152、157、158、159、172、178、182、183、184、187、188、195、198
     */
    NSString *fullPhoneNum = @"";
    NSArray *frontNum = @[@"133",@"149",@"153",@"173",@"177",@"180",@"181",@"189",@"191",@"193",@"199",@"130",@"131",@"132",@"145",@"155",@"156",@"166",@"171",@"175",@"176",@"185",@"186",@"134",@"135",@"136",@"137",@"138",@"139",@"147",@"150",@"151",@"152",@"157",@"158",@"159",@"172",@"178",@"182",@"183",@"184",@"187",@"188",@"195",@"198"];
    NSInteger index = arc4random()%(frontNum.count);
    fullPhoneNum = [fullPhoneNum stringByAppendingFormat:@"%@",frontNum[index]];
    for (int i = 0; i<8; i++) {
        int oneNum = arc4random()%10;
        fullPhoneNum = [fullPhoneNum stringByAppendingFormat:@"%d",oneNum];
    }
    if (phoneNum) {
        NSMutableString *secretPhoneNum = [NSMutableString stringWithString:fullPhoneNum];
        [secretPhoneNum replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        phoneNum(fullPhoneNum,secretPhoneNum);
    }
}

/**拨打电话*/
+ (void)tools_phoneCall:(NSString *_Nonnull)phoneNum completionHandler:(void (^)(BOOL success))completionHandler {
    NSString * phone = [NSString stringWithFormat:@"telprompt://%@",phoneNum];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone] options:@{} completionHandler:completionHandler];
}
#pragma mark - 时间处理
//获得当前时区的时间戳
//格林尼治平均时(GMT, Greenwich Mean Time)
+ (NSString *)tools_getCurrentDateLine {
    //时区(中国时区 东八区)
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //当前时区和格林尼治所在时区相差时间的秒数（8小时 28800秒）
    NSTimeInterval delta = [zone secondsFromGMTForDate:[NSDate date]];
    //当前时区的时间到格林尼治时间的秒数（格林尼治的时间戳 ＋ 28800秒）
    NSString *string = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] + delta];
    //去掉毫秒
    NSString *dateString = [[string componentsSeparatedByString:@"."]objectAtIndex:0];
    return dateString;
}
/**
 *  获取当前时区的时间
 *
 *  @return 当前时区的时间
 */
+ (NSString *)tools_getCurrentDate:(NSString *)format {
    
    if (format == nil || [format isEqualToString:@""]) {
        format = @"YYYY-MM-dd HH:mm:ss";
    }
    //格林尼治日期
    NSDate *date = [NSDate date];
    //初始化时间格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //给时间格式设置时区（中国 东八区）
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:timeZone];
    //给时间格式设置格式参数
    //YYYY:MM:dd-HH:mm:ss
    [dateFormatter setDateFormat:format];
    //获取date对应dateFormatter格式的字符串
    NSString *timeString = [dateFormatter stringFromDate:date];
    return timeString;
}
/**时间转换为时间戳*/
+ (NSString *_Nullable)tools_timeConvertToTimestamp:(NSString *_Nullable)date dateFormatter:(NSString *)formatter {
    
    if (formatter == nil || [formatter isEqualToString:@""]) {
        if (date.length == 4) {
            formatter = @"YYYY-MM-dd";
            date = [NSString stringWithFormat:@"%@-01-01",date];
        } else if (date.length == 7) {
            formatter = @"YYYY-MM-dd";
            date = [NSString stringWithFormat:@"%@-01",date];
        } else if (date.length == 10) {
            formatter = @"YYYY-MM-dd";
        } else if (date.length == 13) {
            formatter = @"YYYY-MM-dd HH";
        } else if (date.length == 16) {
            formatter = @"YYYY-MM-dd HH:mm";
        } else {
            formatter = @"YYYY-MM-dd HH:mm:ss";
        }
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:formatter];
    NSDate *logDate = [dateFormatter dateFromString:date];
    
    // 转换成时间戳
    NSString *timestamp = [NSString stringWithFormat:@"%ld", (long)[logDate timeIntervalSince1970]];
    return timestamp;
}

/**时间戳转换为时间*/
+ (NSString *)tools_timeTimestampConvertToTime:(NSString *)timestamp dateFormatter:(NSString *)formatter {
    if ([KTools tools_isBlankString:timestamp]) {
        return @"";
    }
    if ([KTools tools_isBlankString:formatter]) {
        formatter = @"YYYY-MM-dd HH:mm:ss";
    }
    long long time = [timestamp longLongValue];
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:formatter];
    NSString *timeString = [dateFormatter stringFromDate:date];
    return timeString;
}
//时间：NSString => NSDate
+ (NSDate *)tools_timeStringConvertToDate:(NSString *)timeStr dateFormatter:(NSString *)formatter {
    if ([KTools tools_isBlankString:formatter] || [KTools tools_isBlankString:timeStr]) {
        return [NSDate date];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = formatter;
    NSDate *date = [dateFormatter dateFromString:timeStr];
    return date;
}
//时间：NSDate => NSString
+ (NSString *)tools_timeDateConvertToString:(NSDate *)date dateFormatter:(NSString *)formatter {
    if ([KTools tools_isBlankString:formatter]) {
        formatter = @"YYYY-MM-dd HH:mm:ss";
    }
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = formatter;
    NSString *timeString = [format stringFromDate:date];
    return timeString;
}

#pragma mark - 转换
#pragma mark 类型转换

+ (NSString *)tools_arrayConvertToString:(NSArray *)array {
    //把数组转换为字符串
    NSError *error;
    NSData *textData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *textString = [[NSString alloc] initWithData:textData encoding:NSUTF8StringEncoding];
    return textString;
}
//把字符串转换为数组
+ (NSArray *)tools_stringConvertToArray:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return array;
}

//将字符串数组中以separator作为分隔符转换为字符串
+ (NSString *_Nullable)tools_arrayConvertToString:(NSArray<NSString *> *_Nullable)array separator:(NSString *_Nullable)separator {
    if (!separator) {
        separator = @",";
    }
    if (!array || array.count == 0) {
        return @"";
    }
    if (array.count == 1) {
        return [array firstObject];
    }
    if (array.count > 1) {
        NSString *string = @"";
        for (int i = 0; i<array.count; i++) {
            if (i != array.count - 1) {
                string = [string stringByAppendingFormat:@"%@%@",array[i],separator];
            } else {
                string = [string stringByAppendingString:array[i]];
            }
        }
        return string;
    }
    return @"";
}

//图片 -> base64
+ (NSString *_Nullable)tools_imageConvertToBase64:(UIImage *_Nullable)image compressionQuality:(CGFloat)quality {
    NSData *data = UIImageJPEGRepresentation(image, quality);
    NSString *base64 = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return base64;
}

//base64 -> 图片
+ (UIImage *_Nullable)tools_base64ConvertToImage:(NSString *_Nullable)base64 {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}
//将数组转换为json数组
+ (NSString *)tools_arrayConvertToJsonArray:(NSArray *)array {

    if (![array isKindOfClass:[NSArray class]] || ![NSJSONSerialization isValidJSONObject:array]) {
        return nil;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:0 error:nil];

    NSString *strJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return strJson;
}

//将图片数组转换为base64串，多张图片用逗号分隔
+ (NSString *_Nullable)tools_imagesConvertToBase64String:(NSArray<UIImage *> *_Nullable)images {
    if (images == nil || images.count == 0) {
        return @"";
    }
    NSString *string = @"";
    for (int i = 0; i<images.count; i++) {
        UIImage *image = images[i];
        NSString *base64 = [KTools tools_imageConvertToBase64:image compressionQuality:0.8];
        if (i == 0) {
            string = base64;
        } else {
            string = [NSString stringWithFormat:@"%@,%@",string,base64];
        }
    }
    return string;
}

#pragma mark 单位转换
//米=>公里
+ (NSString *)tools_convertMeterToKilometer:(CGFloat)distance {
    
    NSString *kilometer = nil;
    
    NSString *suffix = @".0";
    
    kilometer = [NSString stringWithFormat:@"%.1f", distance / 1000.0];
    
    BOOL zeroEnd = [kilometer hasSuffix:suffix];
    
    // .0结尾, 去掉尾数.
    if (zeroEnd) {
        kilometer = [kilometer substringWithRange:NSMakeRange(0, kilometer.length - suffix.length)];
    }
    
    return kilometer;
}

#pragma mark - 文本 加密（MD5 SHA256）
//'kobe'字符串
//md5加密结果：7450758CED9CB51BCFCEF1B098829CAC
//SHA256加密结果：D8FA869B7B14569FBAECC89EF9B02C9E923E41361CFE5DD164119EB8CE58040C
+ (NSString *)tools_MD5:(NSString *)string {
    //MD5加密
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    
    return result;
}

//SHA256加密
+ (NSString *)tools_SHA256:(NSString *)string {
    const char *str = [string UTF8String];
    unsigned char digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(str, (CC_LONG)strlen(str), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    return result;
}

#pragma mark - 图片
//打印图片的大小
+ (void)tools_imageFileSize:(UIImage *)image {
    NSData *data = UIImagePNGRepresentation(image);
    if (!data) {
        data = UIImageJPEGRepresentation(image, 1.0);//需要改成0.5才接近原图片大小，原因请看下文
    }
    double dataLength = [data length] * 1.0;
    NSArray *typeArray = @[@"bytes",@"KB",@"MB",@"GB",@"TB",@"PB", @"EB",@"ZB",@"YB"];
    NSInteger index = 0;
    while (dataLength > 1024) {
        dataLength /= 1024.0;
        index ++;
    }
    NSLog(@"image = %.3f %@",dataLength,typeArray[index]);
}

//图片添加水印
+ (UIImage *)tools_imageAddWatermark:(UIImage *)image showText:(NSString *)showText {
    
    if(showText == nil || [showText isEqualToString: @""]) {
        showText = @" 请设置水印内容 ";
    } else {
        showText = [NSString stringWithFormat:@"%@",showText];
    }
    
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    
    //高分辨率图的话进行了压缩，宽度设置为了600，高度按原图宽高比设置
    CGFloat pixW = 600;
    if (pixW > imageW) {
        pixW = imageW;
    }
    CGFloat pixH = imageH / imageW * pixW;
    CGSize pixSize = CGSizeMake(pixW, pixH);
    
//    pixW = imageW;
//    pixH = imageH;
//    pixSize = image.size;
    
    //开始上下文
//    UIGraphicsBeginImageContext(image.size);
    UIGraphicsBeginImageContext(pixSize);
    
    
    [image drawInRect:CGRectMake(0, 0, pixW, pixH)];
    
    //设置段落属性
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentRight;
    //设置文字属性
    NSDictionary *attribute = @{
        NSFontAttributeName: [UIFont systemFontOfSize:24],
        NSParagraphStyleAttributeName: paragraphStyle,
        NSForegroundColorAttributeName : [UIColor whiteColor],
        NSBackgroundColorAttributeName:[[UIColor blackColor]colorWithAlphaComponent:.4],
//        NSTextEffectAttributeName: NSTextEffectLetterpressStyle
    };
    CGFloat watermarkH = 30;
    [showText drawInRect:CGRectMake(0, pixH - watermarkH,pixW , watermarkH) withAttributes:attribute];
    //获取到新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - 打印设备信息

+ (void)tools_printEquipParameter {
    CGFloat screenH = [KTools tools_heightOfScreen];
    CGFloat screenW = [KTools tools_widthOfScreen];
    CGFloat statusH = [KTools tools_heightOfStatusBar];
    CGFloat navigaH = [KTools tools_heightOfNavigationBar];
    CGFloat tabbarH = [KTools tools_heightOfTabBar];
    UIDevice *device = [UIDevice currentDevice];
    
    NSLog(@"\n*****************\n\u3000设备名称：%@ \n\u3000系统版本：%@ %@ \n状态栏高度：%.1f \n导航栏高度：%.1f \n菜单栏高度：%.1f   \n屏幕的宽度：%.1f \n屏幕的高度：%.1f \n*****************",device.name,device.systemName,device.systemVersion,statusH,navigaH,tabbarH,screenW,screenH);
}

@end

#pragma mark - ***************** KViewTools *****************

@implementation KViewTools

//展示提示信息
+ (void)viewTools_showAlertWithTitle:(NSString *)title message:(NSString *)message showViewController:(UIViewController *)showVC {
    if (!title) title = @"";
    if (!message) message = @"";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:confirmAction];
    [showVC presentViewController:alertController animated:YES completion:nil];
}

//展示提示信息，回调操作

+ (void)viewTools_showAlertWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message certainTitle:(NSString *)certainTitle showViewController:(UIViewController *_Nonnull)showVC confirmAction:(void(^_Nullable)(UIAlertAction *_Nonnull confirmAction))confirmHandler {
    if (!title) title = @"";
    if (!message) message = @"";
    if (!certainTitle) certainTitle = @"确定";
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    //修改标题属性
    NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17]}];
    [alertController setValue:titleStr forKey:@"attributedTitle"];
    //title属性的修改，           key为：attributedTitle
    //message属性的修改，         key为：attributedMessage
    //UIAlertAction文字属性的修改，key为：titleTextColor
    //[cancelAction setValue:[UIColor redColor] forKey:@"titleTextColor"];
    
    //取消按钮
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    //确认按钮
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:certainTitle style:UIAlertActionStyleDefault handler:confirmHandler];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    [showVC presentViewController:alertController animated:YES completion:nil];
}

@end

