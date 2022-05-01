//
//  TSingleton.h
//  KZOC
//
//  Created by KZ on 2022/5/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSingleton : NSObject

+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
