//
//  KTImageTextModel.h
//  KZOC
//
//  Created by Zzz... on 2021/12/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KTImageTextModel : NSObject

@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, copy) NSString *imageName;

+ (instancetype)imageTextWithText:(nonnull NSString *)text imageName:(nonnull NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
