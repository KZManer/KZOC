//
//  TTNodeModel.h
//  KZOC
//
//  Created by KZ on 2022/1/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//树节点根类
@interface TTNodeModel : NSObject

@property (nonatomic, copy) NSString *iid;//id
@property (nonatomic, copy) NSString *fid;//父id
@property (nonatomic, copy) NSString *name;//名称

@property (nonatomic, assign) BOOL expand;//是否展开

@end

//树节点 - 三级节点模型
@interface TTThirdNode : TTNodeModel

@property (nonatomic, copy) NSString *shortName;

@end

//树节点 - 二级节点模型
@interface TTSecondNode : TTNodeModel

@property (nonatomic, strong) NSArray<TTThirdNode *> *children;

@end

//树节点 - 一级节点（根节点）模型
@interface TTFirstNode : TTNodeModel

@property (nonatomic, strong) NSArray<TTSecondNode *> *children;

@end

NS_ASSUME_NONNULL_END
