//
//  SlideFullScreenVC.m
//  KZOC
//
//  Created by Zzz... on 2021/11/18.
//

#import "SlideFullScreenVC.h"
#import "HomeEightBtnView.h"
#import "HomeEightBtnModel.h"

@interface SlideFullScreenVC ()

@property (nonatomic, strong) HomeEightBtnView *slideView;

@end

@implementation SlideFullScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //https://randomuser.me/api/portraits/lego/1.jpg
    
    //数据整理
    NSMutableArray *homeEightBtnModels = [NSMutableArray array];
    NSArray *titles = @[
        @"章节练习",@"考点广场",@"快速练习",@"模考大赛",
        @"智能测评",@"刷题计划",@"做题中心",@"报告中心",
    ];
    for (int i = 0; i < titles.count; i++) {
        int random = arc4random_uniform(9);
        HomeEightBtnModel *model = [HomeEightBtnModel eightBtnWithTitle:titles[i] imageLink:[NSString stringWithFormat:@"https://randomuser.me/api/portraits/lego/%d.jpg",random]];
        [homeEightBtnModels addObject:model];
    }
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.slideView = [[HomeEightBtnView alloc]initWithFrame:CGRectMake(0, 200, self.view.width, 100)];
    [self.view addSubview:self.slideView];
    [self.slideView echoContent:homeEightBtnModels];
}


@end
