//
//  ArrowPopVC.m
//  KZOC
//
//  Created by KZ on 2021/11/6.
//

#import "ArrowPopVC.h"
#import "LFPopupMenu.h"
#import "CountdownTimer.h"

@interface ArrowPopVC ()

@property (nonatomic, strong) NSArray<LFPopupMenuItem *> *items;
@property (nonatomic, strong) LFPopupMenu *popupMenu;
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation ArrowPopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.8];
    [button addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
//    [self.view layoutIfNeeded];
    
    LFPopupMenuItem *item1 = [LFPopupMenuItem createWithTitle:@"请选择合适科目" image:nil];
    self.items = @[item1];
    self.popupMenu = [[LFPopupMenu alloc]init];
    self.popupMenu.direction = PopupMenuDirection_Up;
    self.popupMenu.fillColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.popupMenu.textColor = [UIColor whiteColor];
//    [self.popupMenu configWithItems:self.items action:^(NSInteger index) {
//        NSLog(@"点击了第%zi个",index);
//    }];
    [self.popupMenu configWithItems:self.items action:nil];
}

- (void)pressedButton:(UIButton *)sender {
    [self.popupMenu showArrowToView:sender];
    [CountdownTimer startTimerWithKey:CountdownKeyFirst count:5 callBack:^(NSInteger count, BOOL isFinished) {
        NSLog(@"%d - %d",count,isFinished);
        if (isFinished) {
            [self.popupMenu dismiss];
        }
    }];
}

@end
