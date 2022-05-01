//
//  KRechargeModel.h
//  test
//
//  Created by KZ on 2021/7/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KRechargeModel : NSObject

@end

@interface KRechargeWechatModel : NSObject

@property (nonatomic, copy) NSString *partnerId;
@property (nonatomic, copy) NSString *prepayId;
@property (nonatomic, copy) NSString *package;
@property (nonatomic, copy) NSString *nonceStr;
@property (nonatomic, assign) UInt32 timeStamp;
@property (nonatomic, copy) NSString *sign;

@end

NS_ASSUME_NONNULL_END
