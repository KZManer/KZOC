//
//  ShortAnswerQuestionVC.m
//  KZOC
//
//  Created by Zzz... on 2021/12/4.
//

#import "ShortAnswerQuestionVC.h"
#import "ShortAnswerQuestionView.h"
#import "CEToolsCellModel.h"

@interface ShortAnswerQuestionVC ()

@property (nonatomic, strong) ShortAnswerQuestionView *homeView;

@end

@implementation ShortAnswerQuestionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.homeView = [[ShortAnswerQuestionView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.homeView];
    NSLog(@"%f",self.view.height);
    [self.homeView echoContent:[CEToolsCellModel shortAnswerToolsModels]];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.homeView.frame = self.view.frame;
}
@end
