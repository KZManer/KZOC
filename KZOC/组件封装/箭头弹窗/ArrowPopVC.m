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

@property (nonatomic, strong) LFPopupMenu *popupMenu2;

@end

@implementation ArrowPopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color_Hex(@"f5f5f5");
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.8];
    [button addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
    
    LFPopupMenuItem *item1 = [LFPopupMenuItem createWithTitle:@"请选择合适科目" image:nil];
    self.items = @[item1];
    self.popupMenu = [[LFPopupMenu alloc]init];
    self.popupMenu.direction = PopupMenuDirection_Up;
    self.popupMenu.fillColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.popupMenu.textColor = [UIColor whiteColor];
    [self.popupMenu configWithItems:self.items action:nil];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"全部商品" forState:UIControlStateNormal];
    [button2 setBackgroundColor:UIColor.whiteColor];
    [button2 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(pressedButton2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.height.mas_equalTo(44);
        make.top.equalTo(button.mas_bottom).offset(50);
    }];
    [button2 view_setCornerRadius:8 borderColor:nil borderWidth:0];
}

- (void)pressedButton:(UIButton *)sender {
    [self.popupMenu showArrowToView:sender];
    [CountdownTimer startTimerWithKey:CountdownKeyFirst count:5 callBack:^(NSInteger count, BOOL isFinished) {
        NSLog(@"%ld - %d",(long)count,isFinished);
        if (isFinished) {
            [self.popupMenu dismiss];
        }
    }];
}

- (void)pressedButton2:(UIButton *)sender {
    
    //0全部;1高频考题;2金品试卷;3冲刺密卷;4终极密押;5考点口诀;6模考大赛;7历年真题;
    NSArray *itemTitles = @[@"全部",@"高频考题",@"金品试卷",@"冲刺密卷",@"终极密押",@"考点口诀",@"模考大赛",@"历年真题"];
    int random = arc4random_uniform(6);
    NSMutableArray *newArr = [NSMutableArray array];
    for (int i = 0; i<random; i++) {
        [newArr addObject:itemTitles[arc4random_uniform(8)]];
    }

    NSMutableArray *items = [NSMutableArray array];
    for (NSString *string in newArr) {
        LFPopupMenuItem *item = [LFPopupMenuItem createWithTitle:string image:nil];
        [items addObject:item];
    }

    [self.popupMenu2 configWithItems:items action:^(NSInteger index) {
        NSLog(@"click %lu item",index);
    }];
    
    [self.popupMenu2 showArrowToView:sender];
    
    self.popupMenu2 = nil;
}


#pragma mark - lazy loading
- (LFPopupMenu *)popupMenu2 {
    if (!_popupMenu2) {
        _popupMenu2 = [[LFPopupMenu alloc]init];
        _popupMenu2.direction = PopupMenuDirection_Up;
        _popupMenu2.minWidth = self.view.width - 100;
        _popupMenu2.cornerRadius = 8;
        _popupMenu2.lineColor = Color_Hex(@"f5f5f5");
        _popupMenu2.fillColor = UIColor.whiteColor;
        _popupMenu2.arrowH = 0;
        _popupMenu2.arrowW = 0;
        _popupMenu2.maskView.backgroundColor = [UIColor clearColor];
    }
    return _popupMenu2;
}

@end
