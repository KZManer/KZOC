//  一级view
//  TLSectionHeader.h
//  KZOC
//
//  Created by Zzz... on 2021/12/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLSectionHeader : UIView

- (void)echoContent:(NSString *)title subhead:(NSString *)subhead fold:(BOOL)fold;

@end

NS_ASSUME_NONNULL_END
