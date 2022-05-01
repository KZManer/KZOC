//
//  KRechargeModel.m
//  test
//
//  Created by KZ on 2021/7/26.
//

#import "KRechargeModel.h"
#import "MJExtension.h"

@implementation KRechargeModel

@end

@implementation KRechargeWechatModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
        @"partnerId":@"partnerid",
        @"prepayId":@"prepayid",
        @"nonceStr":@"noncestr",
        @"timeStamp":@"timestamp",
    };
}

@end
