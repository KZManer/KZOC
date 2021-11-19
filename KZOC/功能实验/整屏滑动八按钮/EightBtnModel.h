//
//  EightBtnModel.h
//  KZOC
//
//  Created by Zzz... on 2021/11/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EightBtnModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageLink;

+ (instancetype)eightBtnWithTitle:(NSString *)title imageLink:(NSString *)imageLink;

@end

NS_ASSUME_NONNULL_END
