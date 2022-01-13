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
        @"UITableView",
        @"UICollectionView",
        @"系统相关",
        @"功能实验",
        @"组件封装",
        @"三方框架",
        @"动画相关",
    ];
}

+ (NSArray *)sectionModels {
    
    return @[
        //UITableView
        @[
            [self sectionWithName:@"Cell类型" className:@"TableViewVC"],
            [self sectionWithName:@"高度自适应" className:@"TableViewVC1"],
            [self sectionWithName:@"二级折叠" className:@"FoldVC"],
            [self sectionWithName:@"三级折叠" className:@"ThreeLevelFoldVC"],
            [self sectionWithName:@"三级树列表" className:@"TTListVC"],
        ],
        //UICollectionView
        @[
            [self sectionWithName:@"Cell边距问题" className:@"CollectionVC"],
            [self sectionWithName:@"Cell复用问题" className:@"CollectionReuseVC"],
        ],
        //系统相关
        @[
            [self sectionWithName:@"VC生命周期" className:@"VCLifeCycle"],
            [self sectionWithName:@"Runtime" className:@"RuntimeVC"],
            [self sectionWithName:@"UITextField(正则表达式)" className:@"TextFieldVC"],
        ],
        //功能实验
        @[
            [self sectionWithName:@"整屏横向滑动八按钮" className:@"SlideFullScreenVC"],
            [self sectionWithName:@"导航栏淡入淡出" className:@"NavigationVC"],
            [self sectionWithName:@"图片水印" className:@"ImageWatermarkVC"],
            [self sectionWithName:@"读取剪切板内容" className:@"ShearVC"],
            [self sectionWithName:@"ScrollView手势冲突" className:@"GestureVC"],
            [self sectionWithName:@"UILabel加标签" className:@"LabelWithTagVC"],
            [self sectionWithName:@"导航栏角标" className:@"NavigationBadgeVC"],
        ],
        //组件封装
        @[
            [self sectionWithName:@"Cell选择器" className:@"CellSelectVC"],
            [self sectionWithName:@"箭头弹窗" className:@"ArrowPopVC"],
            [self sectionWithName:@"轮播广告" className:@"SlideshowVC"],
        ],
        //三方框架
        @[
            [self sectionWithName:@"MBProgressHUD" className:@"BMProgressHUDVC"],
            [self sectionWithName:@"LEEAlert" className:@"LeeAlertVC"],
            [self sectionWithName:@"SPPageMenu" className:@"SPPageMenuVC"],
            [self sectionWithName:@"时间选择器" className:@"DatePickerVC"],
            [self sectionWithName:@"SAMKeychain(钥匙串)" className:@"SAMKeychainVC"],
            [self sectionWithName:@"TXScrollLabelView(跑马灯)" className:@"TXScrollLabelViewVC"],
            [self sectionWithName:@"DataGridComponent(类似Excel表格)" className:@"DataGridComponentVC"],
            [self sectionWithName:@"密码输入框" className:@"CRBoxVC"],
            [self sectionWithName:@"倒计时" className:@"TimeCountVC"],
            [self sectionWithName:@"TABAnimated(骨架屏)" className:@"TabAnimatedVC"],
        ],
        //动画相关
        @[
            [self sectionWithName:@"分割View" className:@"CutOffViewVC"],
        ],
    ];
}

+ (NSArray *)sectionProjectTitles {
    return @[
        @"金题库",
    ];
}

+ (NSArray *)sectionProjectModels {
    
    return @[
        //金题库
        @[
            [self sectionWithName:@"金题库首页" className:@"KTHomeVC"],
            [self sectionWithName:@"我的-我的地址" className:@"AddressVC"],
            [self sectionWithName:@"我的-新建收货地址" className:@"AddressOperateVC"],
            [self sectionWithName:@"题库-简答题" className:@"ShortAnswerQuestionVC"],
            [self sectionWithName:@"简答题-设置" className:@"ShortAnswerSettingVC"],
            [self sectionWithName:@"课程-直播课" className:@"CLiveCourseVC"],
        ],
    ];
}

- (instancetype)initWithName:(NSString *)name className:(NSString *)className {
    self = [super init];
    if (self) {
        self.name = name;
        self.className = className;
    }
    return self;
}

+ (instancetype)sectionWithName:(NSString *)name className:(NSString *)className {
    return [[self alloc]initWithName:name className:className];
}

@end
