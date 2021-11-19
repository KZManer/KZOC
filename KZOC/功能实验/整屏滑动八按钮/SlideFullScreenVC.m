//
//  SlideFullScreenVC.m
//  KZOC
//
//  Created by Zzz... on 2021/11/18.
//

#import "SlideFullScreenVC.h"
#import "SlideFullScreenView.h"
#import "EightBtnModel.h"

@interface SlideFullScreenVC ()

@property (nonatomic, strong) SlideFullScreenView *slideView;

@end

@implementation SlideFullScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //https://randomuser.me/api/portraits/lego/1.jpg
    
    //数据整理
    NSMutableArray *eightBtnModels = [NSMutableArray array];
    NSArray *titles = @[
        @"章节练习",@"考点广场",@"快速练习",@"模考大赛",
        @"智能测评",@"刷题计划",@"做题中心",@"报告中心",
    ];
    for (int i = 0; i < titles.count; i++) {
        int random = arc4random_uniform(9);
        EightBtnModel *model = [EightBtnModel eightBtnWithTitle:titles[i] imageLink:[NSString stringWithFormat:@"https://randomuser.me/api/portraits/lego/%d.jpg",random]];
        [eightBtnModels addObject:model];
    }
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.slideView = [[SlideFullScreenView alloc]initWithFrame:CGRectMake(0, 200, self.view.width, 100)];
    [self.view addSubview:self.slideView];
//    [self.slideView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.centerY.mas_equalTo(0);
//        make.height.mas_equalTo(80);
//    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
