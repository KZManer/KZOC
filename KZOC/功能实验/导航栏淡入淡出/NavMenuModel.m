//
//  NavMenuModel.m
//  KZOC
//
//  Created by KZ on 2021/10/28.
//

#import "NavMenuModel.h"

@implementation NavMenuModel

+ (NSArray<NavMenuModel *> *)menuModels {
    NSArray *titles = @[@"宝贝",@"评论",@"详情"];
    NSMutableArray *models = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++) {
        NavMenuModel *model = [[NavMenuModel alloc]init];
        model.name = titles[i];
        model.active = i == 0 ? true : false;
        [models addObject:model];
    }
    return [models copy];
}

@end
