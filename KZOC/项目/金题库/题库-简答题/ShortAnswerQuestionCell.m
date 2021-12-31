//
//  ShortAnswerQuestionCell.m
//  KZOC
//
//  Created by Zzz... on 2021/12/4.
//

#import "ShortAnswerQuestionCell.h"

NSString * const CellIdShortAnswerQuestion = @"CellIdShortAnswerQuestion";

static const CGFloat kVerSpace = 5;//垂直方向之间的间距
static const CGFloat kHorSpace = 10;//水平方向之间的间距

@interface ShortAnswerQuestionCell ()
/**题目*/
@property (nonatomic, strong) UITextView *questionTextView;
/**写答案view*/
@property (nonatomic, strong) UIView *bottomWriteView;
/**看答案view*/
@property (nonatomic, strong) UIView *bottomReadView;

@end

@implementation ShortAnswerQuestionCell

#pragma mark - override method

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self doViewUI];
    }
    return self;
}

#pragma mark - private method
- (void)doViewUI {
    self.backgroundColor = UIColor.whiteColor;
    /**题目textView*/
    CGFloat questionTextViewH = (self.contentView.height - 3 * kVerSpace)/2;
    [self.contentView addSubview:self.questionTextView];
    [self.questionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kVerSpace));
        make.left.equalTo(@(kHorSpace));
        make.right.equalTo(@(-kHorSpace));
        make.height.equalTo(@(questionTextViewH));
    }];
    [self.questionTextView view_setCornerRadius:5 borderColor:nil borderWidth:0];
    /**底部写答案view*/
    [self.contentView addSubview:self.bottomWriteView];
    [self.bottomWriteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.questionTextView.mas_bottom).offset(kVerSpace);
        make.left.bottom.right.equalTo(@0);
    }];
    /**底部看答案解析view*/
    [self.contentView addSubview:self.bottomReadView];
    [self.bottomReadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomWriteView);
    }];
    
//    self.bottomWriteView.hidden = true;
    self.bottomReadView.hidden = true;
}

#pragma mark - public method
- (void)changeBottomContentWithShowAnswer:(BOOL)showAnswer {
    if (showAnswer) {
        //展示答案解析view
        NSLog(@"come in 1");
        self.bottomWriteView.hidden = true;
        self.bottomReadView.hidden = false;
    } else {
        //展示填写答案view
        NSLog(@"come in 2");
        self.bottomWriteView.hidden = false;
        self.bottomReadView.hidden = true;
    }
}

#pragma mark - lazy loading
- (UITextView *)questionTextView {
    if (!_questionTextView) {
        _questionTextView = [[UITextView alloc]init];
        _questionTextView.backgroundColor = Color_Hex(@"#F5F5F5");
    }
    return _questionTextView;
}
- (UIView *)bottomWriteView {
    if (!_bottomWriteView) {
        _bottomWriteView = [[UIView alloc]init];
        _bottomWriteView.backgroundColor = [UIColor.blueColor colorWithAlphaComponent:.4];
    }
    return _bottomWriteView;
}
- (UIView *)bottomReadView {
    if (!_bottomReadView) {
        _bottomReadView = [[UIView alloc]init];
        _bottomReadView.backgroundColor = [UIColor.orangeColor colorWithAlphaComponent:.4];
    }
    return _bottomReadView;
}
@end
