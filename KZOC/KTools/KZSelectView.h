//
//  KZSelectView.h
//  demo
//
//  Created by KZ on 2021/10/23.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class KZSelectView;

typedef NSString *_Nullable(^KSelectAction)(NSString *cellName, NSInteger cellIndex);

typedef KZSelectView *_Nonnull(^KFrame)(CGRect);
typedef KZSelectView *_Nonnull(^KBackgroundColor)(UIColor *);
typedef KZSelectView *_Nonnull(^KShow)(UIView *);
typedef KZSelectView *_Nonnull(^KDatasource)(NSArray *_Nullable);
typedef KZSelectView *_Nonnull(^KSelectCell)(KSelectAction action);

@interface KZSelectView : UIView

@property (nonatomic, copy, readonly) KFrame kFrame;
@property (nonatomic, copy, readonly) KBackgroundColor kBackgroundColor;
@property (nonatomic, copy, readonly) KShow kShow;
@property (nonatomic, copy, readonly) KDatasource kDatasource;
@property (nonatomic, copy, readonly) KSelectCell kSelectCell;

+ (instancetype)view;

@end

NS_ASSUME_NONNULL_END
