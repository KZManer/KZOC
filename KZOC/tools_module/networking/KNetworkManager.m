//
//  KNetworkManager.m
//  TimeInternational
//
//  Created by KZ on 2021/8/1.
//


#import "KNetworkManager.h"
#import "AFNetworking.h"

/** 请求类型 */
typedef NS_ENUM(NSUInteger, KHTTPRequestType) {
    KHTTPRequestTypeGET = 0,
    KHTTPRequestTypePOST = 1,
};

//static NSString * const JDHTTPRequestCacheName = @"JDHTTPRequestCacheName";

@interface KNetworkManager()

@end

@implementation KNetworkManager

- (void)dealloc {
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

+ (instancetype)shareManager {
    static KNetworkManager *manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:Base_Domain_Name]];
    });
    return manager;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    if (self = [super initWithBaseURL:url]) {
        // HTTPS 相关设置
        self.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [self.securityPolicy setAllowInvalidCertificates:YES];
        [self.securityPolicy setValidatesDomainName:NO];
        
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        [self.requestSerializer setTimeoutInterval:Request_timeoutInterval];
        [self.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"application/json",@"text/html",@"text/css",@"text/plain",@"multipart/form-data", nil];
        
        // 网络监控
        self.status = AFNetworkReachabilityStatusUnknown;
        AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
        [mgr startMonitoring];
        __weak AFNetworkReachabilityManager *weekMgr = mgr;
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            self.status = weekMgr.networkReachabilityStatus;
            if (weekMgr.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
                [MBProgressHUD cg_error:@"您的网络状况不佳"];
            } else if (weekMgr.networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
                [MBProgressHUD cg_error:@"网络已断开"];
            }
            
        }];
    }
    return self;
}


/**
 *  发送GET 请求 到服务器
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)success failure:(requestFailureBlock)failure {
    [self requestMethod:KHTTPRequestTypeGET urlString:url params:params success:success failure:failure];
}

/**
 *  发送POST 请求 到服务器
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)success failure:(requestFailureBlock)failure {
    [self requestMethod:KHTTPRequestTypePOST urlString:url params:params success:success failure:failure];
}


/**
 *  请求的基础方法
 *
 *  @param type          请求类型 GET  POST
 *  @param url           相对Url
 *  @param params        请求参数的字典
 *  @param success       成功
 *  @param failure       失败
 *
 */
+ (void)requestMethod:(KHTTPRequestType)type urlString:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)success failure:(requestFailureBlock)failure {
    if (!params) {
        params = @{};
    }
    [MBProgressHUD cg_showLoadingOnly];
    
    NSMutableDictionary *tempParams = [NSMutableDictionary dictionary];
    KNetworkManager *manager = [[self class] shareManager];
    
    
//    NSString *token = [WicepManager shareManager].token;
    NSString *token = @"";
//    if (token) {
//        //添加请求头
//        [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
//    }
    NSDictionary *headers = @{
        @"token":token,
    };
    
    switch (type) {
            
        case KHTTPRequestTypeGET: {
            
            [tempParams addEntriesFromDictionary:params];
           
            [manager GET:url parameters:tempParams headers:headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD cg_hide];
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                int code = [responseObject[@"code"] intValue];
                if (httpResponse.statusCode == 200) {
                    if (success) {
                        success(httpResponse.statusCode,code,responseObject,responseObject[@"data"]);
                    }
                } else {
                    [MBProgressHUD cg_error:[NSString stringWithFormat:@"%@",responseObject[@"msg"]]];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD cg_hide];
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                if (failure) {
                    failure(httpResponse.statusCode, error);
                }
                if (error.code == -1009) {
                    [MBProgressHUD cg_error:@"网络已断开"];
                } else if (error.code == -1001) {
                    [MBProgressHUD cg_error:@"您的网络状况不佳"];
                }
            }];
        }break;
            
        case KHTTPRequestTypePOST: {
            
            [tempParams addEntriesFromDictionary:params];
            
            [manager POST:url parameters:tempParams headers:headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD cg_hide];
                
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                int code = [responseObject[@"code"] intValue];
                if (httpResponse.statusCode == 200 && code != 0) {
                    if (success) {
                        success(httpResponse.statusCode,code,responseObject,responseObject[@"data"]);
                    }
                } else {
                    [MBProgressHUD cg_error:[NSString stringWithFormat:@"%@",responseObject[@"msg"]]];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD cg_hide];
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                if (failure) {
                    failure(httpResponse.statusCode, error);
                }
                
                if (error.code == -1009) {
                    [MBProgressHUD cg_error:@"网络已断开"];
                } else if (error.code == -1001) {
                    [MBProgressHUD cg_error:@"您的网络状况不佳"];
                }
                
            }];
        }break;
    }
}



/**
 图片上传
 
 @param url 地址
 @param params 参数
 @param imageData 图片
 @param name 如果 params 为空  传@"upFile"   否侧 最好保持不同 （但是服务器已经重命名 但是不可为空）
 @param fileName 一定要后缀 eg. @"xxxxx.xxx"
 @param success 成功
 @param failure 失败
 */
+ (void)uploadImage:(NSString *)url params:(NSDictionary *)params imageData:(NSData *)imageData name:(NSString *)name fileName:(NSString *)fileName success:(requestSuccessBlock)success failure:(requestFailureBlock)failure {
    AFHTTPSessionManager *mgr = [[self class] shareManager];
    mgr.requestSerializer.timeoutInterval = UploadImage_timeoutInterval;

    [mgr POST:url parameters:@{@"data":params} headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        int code = [responseObject[@"code"] intValue];
        success(httpResponse.statusCode,code,responseObject,responseObject[@"data"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        if (failure) {
            failure(httpResponse.statusCode, error);
        }
    }];
}

+ (void)uploadImage:(NSString *)url params:(NSDictionary *)params imageDatas:(NSArray *)imageDatas name:(NSString *)name success:(requestSuccessBlock)success failure:(requestFailureBlock)failure {
    NSMutableDictionary *tempParams = [NSMutableDictionary dictionary];
    KNetworkManager  *mgr = [[self class] shareManager];
    mgr.requestSerializer.timeoutInterval = 60;
    
    [mgr POST:url parameters:tempParams headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            // 拼接imageData操作
            for(NSInteger i = 0; i < imageDatas.count; i++) {
                NSData *imageData = UIImageJPEGRepresentation(imageDatas[i],1);
                // 验证照片的大小   不超过 1M
                float dataSize = imageData.length/1024;
                if (dataSize > 1 * 256) {
                    imageData = UIImageJPEGRepresentation(imageDatas[i],0.8);
                }
                NSString *fileName = [NSString stringWithFormat:@"upFile%zd.png",i];
                [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"%@[]",name] fileName:fileName mimeType:@"image/jpeg"];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"******%@",uploadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
            int code = [responseObject[@"code"] intValue];
            success(httpResponse.statusCode,code,responseObject,responseObject[@"data"]);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
            if (failure) {
                failure(httpResponse.statusCode, error);
            }
        }];
    
}

@end
