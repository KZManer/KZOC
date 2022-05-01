//
//  ThreeLevelFoldVC.m
//  KZOC
//
//  Created by Zzz... on 2021/12/31.
//

#import "ThreeLevelFoldVC.h"
#import "KNetworkManager.h"
#import "TLHomeView.h"
#import "TLModel.h"

@interface ThreeLevelFoldVC ()

@property (nonatomic, strong) TLHomeView *homeView;

@end

@implementation ThreeLevelFoldVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self doViewUI];
    [self doRequest];
//    [self doConfig];
}
- (void)doViewUI {
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.homeView = [[TLHomeView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.homeView];
}
- (void)doRequest {
    [MBProgressHUD cg_textLoading:@"加载中..."];
    [[KNetworkManager manager]GET:@"https://api.jinyingjie.com/JinTiKuLive/getFreeNetCourse?sign=c8a89e457a52b4ea4dfaede5f71ad3e3&userid=9887111112940100310811&professionid=45&user_id=9887111112940100310811&new_subject_id=54&from_Client=iOS" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray<TLModel *> *tlInfos = [NSMutableArray array];
        NSArray *firstArr = responseObject[@"entity"][@"category_list"];
        for (NSDictionary *firstDic in firstArr) {
            [tlInfos addObject:[TLModel modelWithId:firstDic[@"id"] fid:firstDic[@"fid"] level:TLLevelFirst title:firstDic[@"name"] subhead:@"" fold:true]];
            NSArray *secondArr = firstDic[@"child"];
            for (NSDictionary *secondDic in secondArr) {
                [tlInfos addObject:[TLModel modelWithId:secondDic[@"id"] fid:secondDic[@"fid"] level:TLLevelSecond title:secondDic[@"name"] subhead:@"" fold:true]];
                NSArray *thirdArr = secondDic[@"child_video"];
                for (NSDictionary *thirdDic in thirdArr) {
                    [tlInfos addObject:[TLModel modelWithId:thirdDic[@"id"] fid:thirdDic[@"fid"] level:TLLevelThird title:thirdDic[@"shortname"] subhead:@"" fold:true]];
                }
            }
        }
        [MBProgressHUD cg_hide];
        if (tlInfos.count == 0) {
            //网络无数据的话加载本地数据
            [self doConfig];
        } else {
            [self.homeView echoContent:tlInfos];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD cg_hide];
        //失败的话加载本地数据
        [self doConfig];
    }];
}
- (void)doConfig {
    NSArray<TLModel *> *flInfos = @[
        [TLModel modelWithId:@"1" fid:@"0" level:TLLevelFirst title:@"一级标题1" subhead:@"" fold:true],
        [TLModel modelWithId:@"11" fid:@"1" level:TLLevelSecond title:@"二级标题11" subhead:@"" fold:true],
        [TLModel modelWithId:@"111" fid:@"11" level:TLLevelThird title:@"三级标题111" subhead:@"" fold:true],
        [TLModel modelWithId:@"112" fid:@"11" level:TLLevelThird title:@"三级标题112" subhead:@"" fold:true],
        [TLModel modelWithId:@"12" fid:@"1" level:TLLevelSecond title:@"二级标题12" subhead:@"" fold:true],
        [TLModel modelWithId:@"13" fid:@"1" level:TLLevelSecond title:@"二级标题13" subhead:@"" fold:true],
        [TLModel modelWithId:@"14" fid:@"1" level:TLLevelSecond title:@"二级标题14" subhead:@"" fold:true],
        [TLModel modelWithId:@"15" fid:@"1" level:TLLevelSecond title:@"二级标题15" subhead:@"" fold:true],
        [TLModel modelWithId:@"16" fid:@"1" level:TLLevelSecond title:@"二级标题16" subhead:@"" fold:true],
        
        [TLModel modelWithId:@"2" fid:@"0" level:TLLevelFirst title:@"一级标题2" subhead:@"" fold:true],
        [TLModel modelWithId:@"21" fid:@"2" level:TLLevelSecond title:@"二级标题21" subhead:@"" fold:true],
        [TLModel modelWithId:@"211" fid:@"21" level:TLLevelThird title:@"三级标题211" subhead:@"" fold:true],
        [TLModel modelWithId:@"212" fid:@"21" level:TLLevelThird title:@"三级标题212" subhead:@"" fold:true],
        [TLModel modelWithId:@"22" fid:@"2" level:TLLevelSecond title:@"二级标题22" subhead:@"" fold:true],
        [TLModel modelWithId:@"23" fid:@"2" level:TLLevelSecond title:@"二级标题23" subhead:@"" fold:true],
        [TLModel modelWithId:@"24" fid:@"2" level:TLLevelSecond title:@"二级标题24" subhead:@"" fold:true],
        [TLModel modelWithId:@"25" fid:@"2" level:TLLevelSecond title:@"二级标题25" subhead:@"" fold:true],
        [TLModel modelWithId:@"26" fid:@"2" level:TLLevelSecond title:@"二级标题26" subhead:@"" fold:true],
    ];
 
    [self.homeView echoContent:flInfos];
}
@end
