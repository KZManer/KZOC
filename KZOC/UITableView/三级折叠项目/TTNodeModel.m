//
//  TTNodeModel.m
//  KZOC
//
//  Created by KZ on 2022/1/2.
//

#import "TTNodeModel.h"

@implementation TTNodeModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
        @"iid":@"id",
    };
}

@end

//树节点 - 三级节点模型
@implementation TTThirdNode

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
        @"shortName":@"shortname",
    };
}

@end

//树节点 - 二级节点模型
@implementation TTSecondNode

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
        @"children":@"child_video",
    };
}
+ (NSDictionary *)mj_objectClassInArray {
    return @{
        @"children":[TTThirdNode class],
    };
}

@end

//树节点 - 一级节点（根节点）模型
@implementation TTFirstNode

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
        @"children":@"child",
    };
}
+ (NSDictionary *)mj_objectClassInArray {
    return @{
        @"children":[TTSecondNode class],
    };
}

@end
