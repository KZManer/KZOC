//
//  TestView.h
//  KZOC
//
//  Created by KZ on 2021/11/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol TestViewDelegate <NSObject>

- (void)testViewGoTo;

@end

@interface TestView : UIView

@property (nonatomic, weak) id<TestViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
