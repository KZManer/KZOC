//
//  TLModel.h
//  KZOC
//
//  Created by Zzz... on 2021/12/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**级别*/
typedef enum : NSUInteger {
    /**未知级别*/
    TLLevelUnknown,
    /**一级*/
    TLLevelFirst,
    /**二级*/
    TLLevelSecond,
    /**三级*/
    TLLevelThird,
} TLLevel;
@interface TLModel : NSObject

/**id*/
@property (nonatomic, copy) NSString *iid;
/**父id*/
@property (nonatomic, copy) NSString *fid;
/**级别*/
@property (nonatomic, assign) TLLevel level;
/**标题*/
@property (nonatomic, copy) NSString *title;
/**副标题*/
@property (nonatomic, copy) NSString *subhead;
/**是否折叠*/
@property (nonatomic, assign) BOOL fold;

+ (instancetype)modelWithId:(NSString *)iid fid:(NSString *)fid level:(TLLevel)level title:(NSString *)title subhead:(NSString *)subhead fold:(BOOL)fold;

@end

NS_ASSUME_NONNULL_END
