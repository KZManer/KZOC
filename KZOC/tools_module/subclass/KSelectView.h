//
//  KSelectView.h
//  demo
//
//  Created by KZ on 2021/10/23.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class KSelectView;

typedef void (^KSelectAction)(NSString *cellName, NSInteger cellIndex);

typedef KSelectView *_Nonnull(^KFrame)(CGRect);
typedef KSelectView *_Nonnull(^KBackgroundColor)(UIColor *);
typedef KSelectView *_Nonnull(^KShow)(UIView *);
typedef KSelectView *_Nonnull(^KDatasource)(NSArray *_Nullable);
typedef KSelectView *_Nonnull(^KSelectCell)(KSelectAction action);

@interface KSelectView : UIView

@property (nonatomic, copy, readonly) KFrame kFrame;
@property (nonatomic, copy, readonly) KBackgroundColor kBackgroundColor;
@property (nonatomic, copy, readonly) KShow kShow;
@property (nonatomic, copy, readonly) KDatasource kDatasource;
@property (nonatomic, copy, readonly) KSelectCell kSelectCell;

+ (instancetype)view;

@end

NS_ASSUME_NONNULL_END
