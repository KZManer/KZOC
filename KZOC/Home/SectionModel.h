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
@property (nonatomic, copy) NSString *className;

+ (NSArray *)sectionTitles;

+ (NSArray *)sectionModels;

+ (NSArray *)sectionProjectTitles;

+ (NSArray *)sectionProjectModels;

@end

NS_ASSUME_NONNULL_END
