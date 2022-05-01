//
//  KZHomeBaseView.h
//  KZOC
//
//  Created by KZ on 2022/5/1.
//

#import <UIKit/UIKit.h>
@class SectionModel;

NS_ASSUME_NONNULL_BEGIN

@protocol KZHomeBaseViewDelegate <NSObject>

- (void)dg_homeDidSelectRowWithTitle:(NSString *)title className:(NSString *)className;

@end

@interface KZHomeBaseView : UIView

@property (nonatomic, weak) id<KZHomeBaseViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame projectTitles:(NSArray *)titles sectionInfos:(NSArray<NSArray<SectionModel *> *> *)sectionInfos;

@end

NS_ASSUME_NONNULL_END
