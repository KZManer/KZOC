//
//  NavMenuModel.h
//  KZOC
//
//  Created by KZ on 2021/10/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NavMenuModel : NSObject
/**菜单名称*/
@property (nonatomic, copy) NSString *name;
/**是否处于活跃状态*/
@property (nonatomic, assign) BOOL active;

+ (NSArray<NavMenuModel *> *)menuModels;

@end

NS_ASSUME_NONNULL_END
