//
//  KTImageTextView.h
//  KZOC
//
//  Created by Zzz... on 2021/12/18.
//

#import <UIKit/UIKit.h>
#import "KTImageTextModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol KTImageTextViewDelegate <NSObject>

@optional
- (void)dg_imageTextItemDidSelect:(NSInteger)clickIndex;

@end

@interface KTImageTextView : UIView

/**image和text之间的间隔*/
@property (nonatomic, assign) CGFloat spaceImageText;

@property (nonatomic, weak) id<KTImageTextViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame datasource:(NSArray<KTImageTextModel *> *)datasource column:(NSInteger)column;

@end

NS_ASSUME_NONNULL_END
