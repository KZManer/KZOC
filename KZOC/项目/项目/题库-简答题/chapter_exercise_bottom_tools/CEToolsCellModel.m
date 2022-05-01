//
//  CEToolsCellModel.m
//  KZOC
//
//  Created by Zzz... on 2021/12/6.
//

#import "CEToolsCellModel.h"

@implementation CEToolsCellModel

- (instancetype)initWithNormalImageName:(NSString *_Nonnull)normalImageName
                        selectImageName:(NSString *_Nonnull)selectImageName
                            normalTitle:(NSString *_Nonnull)normalTitle
                            selectTitle:(NSString *_Nonnull)selectTitle {
    self = [super init];
    if (self) {
        self.normalImageName = normalImageName;
        self.selectImageName = selectImageName;
        self.normalTitle     = normalTitle;
        self.selectTitle     = selectTitle;
        self.isSelected      = false;
    }
    return self;
}

+ (instancetype)toolsCellModelWithNormalImageName:(NSString *_Nonnull)normalImageName
                                  selectImageName:(NSString *_Nonnull)selectImageName
                                      normalTitle:(NSString *_Nonnull)normalTitle
                                      selectTitle:(NSString *_Nonnull)selectTitle {
    return [[self alloc]initWithNormalImageName:normalImageName selectImageName:selectImageName normalTitle:normalTitle selectTitle:selectTitle];
}

+ (NSArray<CEToolsCellModel *> *)shortAnswerToolsModels {
    NSArray *normalImageNames = @[@"q_ce_star_grey",@"q_ce_recite",@"q_ce_correction",@"q_ce_answer"];
    NSArray *selectImageNames = @[@"q_ce_star_yellow",@"q_ce_do",@"q_ce_correction",@"q_ce_answer"];
    NSArray *normalTitles = @[@"收藏",@"背题",@"纠错",@"答题卡"];
    NSArray *selectTitles = @[@"已收藏",@"做题",@"纠错",@"答题卡"];
    NSMutableArray *models = [NSMutableArray array];
    for (int i = 0; i < normalImageNames.count; i++) {
        CEToolsCellModel *model = [CEToolsCellModel toolsCellModelWithNormalImageName:normalImageNames[i] selectImageName:selectImageNames[i] normalTitle:normalTitles[i] selectTitle:selectTitles[i]];
        [models addObject:model];
    }
    return models;
}

@end
