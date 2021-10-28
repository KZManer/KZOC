//
//  SectionModel.h
//  demo
//
//  Created by KZ on 2021/10/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SectionModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray *rowNames;

@property (nonatomic, strong) NSArray *classNames;

+ (NSArray *)sectionTitles;

+ (NSArray <SectionModel *> *)allSectionInfos;

@end

NS_ASSUME_NONNULL_END
