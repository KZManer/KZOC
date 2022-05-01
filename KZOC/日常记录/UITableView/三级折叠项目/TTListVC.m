//
//  TTListVC.m
//  KZOC
//
//  Created by KZ on 2022/1/2.
//

#import "TTListVC.h"
#import "KNetworkManager.h"
#import "TTListView.h"
#import "TTNodeModel.h"

@interface TTListVC ()

@property (nonatomic, strong) TTListView *homeView;
@property (nonatomic, strong) NSArray<TTFirstNode *> *nodeInfos;

@end

@implementation TTListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self doViewUI];
    [self doRequest];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)doViewUI {
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.homeView = [[TTListView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.homeView];
}
- (void)doRequest {
    [MBProgressHUD cg_textLoading:@"加载中..."];
    [[KNetworkManager manager]GET:@"https://api.jinyingjie.com/JinTiKuLive/getFreeNetCourse?sign=c8a89e457a52b4ea4dfaede5f71ad3e3&userid=9887111112940100310811&professionid=45&user_id=9887111112940100310811&new_subject_id=54&from_Client=iOS" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.nodeInfos = [TTFirstNode mj_objectArrayWithKeyValuesArray:responseObject[@"entity"][@"category_list"]];
        NSLog(@"first level nums is %lu",self.nodeInfos.count);
        for (TTFirstNode *firstNode in self.nodeInfos) {
            NSLog(@"second level nums is %lu",firstNode.children.count);
        }
        [self.homeView echoContent:self.nodeInfos];
        
        [MBProgressHUD cg_hide];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD cg_hide];
        //失败的话加载本地数据
//        [self doConfig];
    }];
}
@end
