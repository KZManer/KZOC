//
//  SectionModel.m
//  demo
//
//  Created by KZ on 2021/10/23.
//

#import "SectionModel.h"

@implementation SectionModel

+ (NSArray<SectionModel *> *)allSectionInfos {
    
    NSMutableArray *sectionArray = [NSMutableArray array];
    NSArray *sectionTitles = @[
        @"系统组件",
        @"自定义组件",
        @"第三方框架",
    ];
    NSArray *rowTitles = @[
        @[@"ViewController生命周期",@"UITableView",@"UICollectionView"],
        @[@"Cell选择器",@"导航栏渐进色"],
        @[@"LEEAlert",@"SPPageMenu"],
    ];
    NSArray *classNames = @[
        @[@"VCLifeCycle",@"TableViewVC",@"CollectionVC"],
        @[@"CellSelectVC",@"NavigationVC"],
        @[@"LeeAlertVC",@"SPPageMenuVC"],
    ];
    
    if (sectionTitles.count != rowTitles.count || sectionTitles.count != classNames.count) return nil;
    
    int i = 0;
    
    do {
        SectionModel *model = [self sectionInfoWithName:sectionTitles[i] rows:rowTitles[i] classNames:classNames[i]];
        [sectionArray addObject:model];
        i++;
    } while (i < sectionTitles.count);
    
    return sectionArray;
}

+ (instancetype)sectionInfoWithName:(NSString *)name rows:(NSArray *)rowNames classNames:(NSArray *)classNames {
    SectionModel *model = [[SectionModel alloc]init];
    model.name = name;
    model.rowNames = rowNames;
    model.classNames = classNames;
    return model;
}


@end
