//
//  KNetworkManager.h
//  TimeInternational
//
//  Created by KZ on 2021/8/1.
//

#import "AFHTTPSessionManager.h"
#import "KNetworkConfig.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^requestSuccessBlock)(NSInteger statusCode, int backCode,NSDictionary *successDic, id data);
typedef void (^requestFailureBlock)(NSInteger errorCode, NSError *error);


@interface KNetworkManager : AFHTTPSessionManager

+ (instancetype)shareManager;

// about net status
@property (nonatomic, assign) AFNetworkReachabilityStatus status;


/**
 *  发送GET 请求 到服务器
 *  @param url      相对的url地址
 *  @param params  请求参数
 *  @param success 成功后回调  回传json
 *  @param failure 失败后回调  回传error
 *
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)success failure:(requestFailureBlock _Nullable)failure;

/**
 *  发送POST 请求 到服务器（其他参数同上）
 */
+ (void)post:(NSString *)url params:(NSDictionary *_Nullable)params success:(requestSuccessBlock)success failure:(requestFailureBlock _Nullable)failure;


/**
 图片上传
 
 @param url 地址
 @param params 参数
 @param imageData 图片
 @param name 如果 params 为空  传@"upFile[]"   否侧 最好保持不同 （但是服务器已经重命名 但是不可为空）
 @param fileName 一定要后缀 eg. @"xxxxx.xxx"
 @param success 成功
 @param failure 失败
 */
+ (void)uploadImage:(NSString *)url params:(NSDictionary *)params imageData:(NSData *)imageData name:(NSString *)name fileName:(NSString *)fileName success:(requestSuccessBlock)success failure:(requestFailureBlock)failure;

/**
 多图上传
 */
+ (void)uploadImage:(NSString *)url params:(NSDictionary *)params imageDatas:(NSArray *)imageDatas name:(NSString *)name success:(requestSuccessBlock)success failure:(requestFailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
