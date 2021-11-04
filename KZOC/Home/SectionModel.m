//
//  SectionModel.m
//  demo
//
//  Created by KZ on 2021/10/23.
//

#import "SectionModel.h"

@implementation SectionModel

+ (NSArray *)sectionTitles {
    return @[
        @"系统相关",
        @"功能实验",
        @"组件封装",
        @"三方框架",
    ];
}

+ (NSArray<SectionModel *> *)allSectionInfos {
    
    NSMutableArray *sectionArray = [NSMutableArray array];
    NSArray *sectionTitles = [self sectionTitles];
    NSArray *rowTitles = @[
        @[@"VC生命周期",
          @"UITableView",
          @"UICollectionView",
          @"Runtime",
          @"UITextField(正则表达式)"
        ],
        @[@"导航栏淡入淡出",@"图片水印"],
        @[@"Cell选择器"],
        @[
            @"MBProgressHUD",
            @"LEEAlert",
            @"SPPageMenu",
            @"时间选择器",
            @"SAMKeychain(钥匙串)",
            @"TXScrollLabelView(跑马灯)",
            @"DataGridComponent(类似Excel表格)",
            @"密码输入框",
            @"倒计时",
        ],
    ];
    NSArray *classNames = @[
        @[@"VCLifeCycle",
          @"TableViewVC",
          @"CollectionVC",
          @"RuntimeVC",
          @"TextFieldVC"
        ],
        @[@"NavigationVC",@"ImageWatermarkVC"],
        @[@"CellSelectVC"],
        @[
            @"BMProgressHUDVC",
            @"LeeAlertVC",
            @"SPPageMenuVC",
            @"DatePickerVC",
            @"SAMKeychainVC",
            @"TXScrollLabelViewVC",
            @"DataGridComponentVC",
            @"CRBoxVC",
            @"TimeCountVC",
        ],
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
