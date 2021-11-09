//
//  CRBoxVC.m
//  KZOC
//
//  Created by KZ on 2021/11/1.
//

#import "CRBoxVC.h"
#import "CRBoxInputView.h"

@interface CRBoxVC ()

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) CRBoxInputView *boxInputView;

@end

@implementation CRBoxVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;

    CRBoxInputCellProperty *property1 = [[CRBoxInputCellProperty alloc]init];
    property1.borderWidth = 0;
    property1.showLine = true;
    property1.cellCursorColor = Color_Hex(@"#387DFC");
    property1.customLineViewBlock = ^CRLineView * _Nonnull{
        CRLineView *lineView = [[CRLineView alloc]init];
        lineView.underlineColorNormal = Color_Hex(@"#999999");
        lineView.underlineColorSelected = Color_Hex(@"#387DFC");
        [lineView.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(2);
        }];
        return lineView;
    };
    
    CRBoxInputView *boxInputView = [[CRBoxInputView alloc]initWithCodeLength:6];
    self.boxInputView = boxInputView;
    boxInputView.customCellProperty = property1;
    boxInputView.textContentType = UITextContentTypeOneTimeCode;
//    boxInputView.backgroundColor = [UIColor lightGrayColor];
    boxInputView.placeholderText = @"测试一下";
    [boxInputView loadAndPrepareView];
    boxInputView.textDidChangeblock = ^(NSString * _Nullable text, BOOL isFinished) {
        NSLog(@"%@ - %d",text,isFinished);
    };
    boxInputView.textEditStatusChangeblock = ^(CRTextEditStatus editStatus) {
        NSLog(@"%ld",(long)editStatus);
    };
    [boxInputView addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(popupMenu:)]];
    [self.view addSubview:boxInputView];
    
    [boxInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(50);
    }];
}
- (void)popupMenu:(UILongPressGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:self.view];
    UIMenuController *menuController = [[UIMenuController alloc]init];
    menuController.menuItems = @[
        [[UIMenuItem alloc]initWithTitle:@"粘贴" action:@selector(kPaste)],
    ];
    [menuController setTargetRect:CGRectMake(point.x,point.y, 50, 24) inView:self.view];
    // 显示
    [menuController setMenuVisible:YES animated:YES];
}
- (void)kPaste {
    NSString *string = [UIPasteboard generalPasteboard].string;
    NSLog(@"%@",string);
    [self.boxInputView reloadInputString:string];
}
@end


// MARK:MARK（标记）
// FIXME:FIXME（待修正）
// TODO:TODO（待编写）
// ???:???（此处代码有疑问）
// !!!:!!!（此处代码需要注意）
