//
//  CEToolsCellModel.h
//  KZOC
//
//  Created by Zzz... on 2021/12/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CEToolsCellModel : NSObject

@property (nonatomic, copy) NSString *normalImageName;
@property (nonatomic, copy) NSString *selectImageName;
@property (nonatomic, copy) NSString *normalTitle;
@property (nonatomic, copy) NSString *selectTitle;
@property (nonatomic, assign) BOOL isSelected;

+ (NSArray<CEToolsCellModel *> *)shortAnswerToolsModels;

@end

NS_ASSUME_NONNULL_END
