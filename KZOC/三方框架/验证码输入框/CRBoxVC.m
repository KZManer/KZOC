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
    [self.view addSubview:boxInputView];
    
    [boxInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(50);
    }];
    
    
    
}

@end
