//
//  LabelWithTagVC.m
//  KZOC
//
//  Created by Zzz... on 2021/12/31.
//

#import "LabelWithTagVC.h"
#import "KILabel.h"

@interface LabelWithTagVC ()

@property (nonatomic, copy) NSString *textString;
@property (nonatomic, strong) KILabel *imageLabel;
@property (nonatomic, strong) KILabel *textImageLabel;

@end

@implementation LabelWithTagVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    //不必说碧绿的菜畦，光滑的石井栏，高大的皂荚树，紫红的桑椹；也不必说鸣蝉在树叶里长吟，肥胖的黄蜂伏在菜花上，轻捷的叫天子（云雀）忽然从草间直窜向云霄里去了。单是周围的短短的泥墙根一带，就有无限趣味。
    self.textString = @"不必说碧绿的菜畦，光滑的石井栏，高大的皂荚树，紫红的桑椹；也不必说鸣蝉在树叶里长吟，肥胖的黄蜂伏在菜花上，轻捷的叫天子（云雀）忽然从草间直窜向云霄里去了。单是周围的短短的泥墙根一带，就有无限趣味。";
    //图片标签+文字
    [self imageTagWithText];
    //文字转图片 + 文字
    [self textConvertImageWithText];
    
}

//图片标签 + 文字
- (void)imageTagWithText {
    [self.view addSubview:self.imageLabel];
    [self.imageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(Height_Status_Navigation));
        make.left.equalTo(@30);
        make.right.equalTo(@-30);
        make.centerX.equalTo(@0);
    }];
    
    NSMutableAttributedString *textString = [[NSMutableAttributedString alloc]initWithString:self.textString attributes:@{
        NSFontAttributeName:[UIFont font_fontPingFangSC:22],
    }];
    NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
    UIImage *tagImage = [UIImage imageNamed:@"my_gold_gain"];
    attachment.image = tagImage;
   
    CGSize textSize = [@"不必" sizeWithAttributes:@{
        NSFontAttributeName:[UIFont font_fontPingFangSC:22],
    }];
    
    CGFloat attachmentHeight = textSize.height * 0.7;
    
    attachment.bounds = CGRectMake(0, 0, tagImage.size.width/tagImage.size.height * attachmentHeight, attachmentHeight);
    NSAttributedString *imageString = [NSAttributedString attributedStringWithAttachment:attachment];
    
    [textString insertAttributedString:imageString atIndex:0];
    self.imageLabel.attributedText = textString;
}
//文字转图片 + 文字
- (void)textConvertImageWithText {
    [self.view addSubview:self.textImageLabel];
    [self.textImageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imageLabel);
        make.top.equalTo(self.imageLabel.mas_bottom).offset(30);
        make.centerX.equalTo(@0);
    }];
    
    UIFont *textFont = [UIFont font_fontPingFangSC:18];
    
    //标签1
    NSString *tagText1 = @"百草园";
    UILabel *tagLabel1 = [[UILabel alloc]init];
    tagLabel1.backgroundColor = UIColor.redColor;
    tagLabel1.text = tagText1;
    tagLabel1.font = textFont;
    tagLabel1.textColor = UIColor.whiteColor;
    tagLabel1.textAlignment = NSTextAlignmentCenter;
    CGSize textSize1 = [tagText1 sizeWithAttributes:@{
        NSFontAttributeName:tagLabel1.font,
    }];
    tagLabel1.frame = CGRectMake(0, 0, textSize1.width + 10, textSize1.height + 5);
    tagLabel1.layer.cornerRadius = textSize1.height/2;
    tagLabel1.clipsToBounds = true;
    
    //标签2
    NSString *tagText2 = @"三味书屋";
    UILabel *tagLabel2 = [[UILabel alloc]init];
    tagLabel2.backgroundColor = UIColor.purpleColor;
    tagLabel2.text = tagText2;
    tagLabel2.font = textFont;
    tagLabel2.textColor = UIColor.whiteColor;
    tagLabel2.textAlignment = NSTextAlignmentCenter;
    CGSize textSize2 = [tagText2 sizeWithAttributes:@{
        NSFontAttributeName:tagLabel2.font,
    }];
    tagLabel2.frame = CGRectMake(0, 0, textSize2.width + 10, textSize2.height + 5);
    tagLabel2.layer.cornerRadius = textSize2.height/2;
    tagLabel2.clipsToBounds = true;
    
    //标签1=>图片
    UIImage *tagImage1 = [self imageWithUIView:tagLabel1];
    //标签2=>图片
    UIImage *tagImage2 = [self imageWithUIView:tagLabel2];
    
    //标签1图片富文本
    NSTextAttachment *attachment1 = [[NSTextAttachment alloc]init];
    attachment1.image = tagImage1;
    CGFloat attachmentHeight1 = textSize1.height * 0.7;
    attachment1.bounds = CGRectMake(0, -2.5, tagImage1.size.width/tagImage1.size.height * attachmentHeight1, attachmentHeight1);
    NSAttributedString *tagAttr1 = [NSAttributedString attributedStringWithAttachment:attachment1];
    
    //标签2图片富文本
    NSTextAttachment *attachment2 = [[NSTextAttachment alloc]init];
    attachment2.image = tagImage2;
    CGFloat attachmentheight2 = textSize2.height * 0.7;
    attachment2.bounds = CGRectMake(0, -2.5, tagImage2.size.width/tagImage2.size.height * attachmentheight2, attachmentheight2);
    NSAttributedString *tagAttr2 = [NSAttributedString attributedStringWithAttachment:attachment2];
    
    //正文富文本
    NSMutableAttributedString *textAttr = [[NSMutableAttributedString alloc]initWithString:self.textString attributes:@{
        NSFontAttributeName:textFont,
    }];
    //空格富文本
    NSAttributedString *spaceAttr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"\u3000"] attributes:@{}];
    
    //插入图片富文本
    //尾部
    [textAttr appendAttributedString:tagAttr1];
    [textAttr appendAttributedString:spaceAttr];
    [textAttr appendAttributedString:tagAttr2];
    //头部
    [textAttr insertAttributedString:tagAttr2 atIndex:0];
    [textAttr insertAttributedString:spaceAttr atIndex:0];
    [textAttr insertAttributedString:tagAttr1 atIndex:0];
    
    //赋值给label
    self.textImageLabel.attributedText = textAttr;
}

//view转成image
- (UIImage*)imageWithUIView:(UIView*) view{
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
}

#pragma mark - lazy loading
- (KILabel *)imageLabel {
    if (!_imageLabel) {
        _imageLabel = [[KILabel alloc]init];
        _imageLabel.numberOfLines = 0;
        _imageLabel.textColor = UIColor.blackColor;
        _imageLabel.backgroundColor = UIColor.lightGrayColor;
    }
    return _imageLabel;
}
- (KILabel *)textImageLabel {
    if (!_textImageLabel) {
        _textImageLabel = [[KILabel alloc]init];
        _textImageLabel.numberOfLines = 0;
        _textImageLabel.textColor = UIColor.blackColor;
        _textImageLabel.backgroundColor = [UIColor.orangeColor colorWithAlphaComponent:.4];
    }
    return _textImageLabel;
}
@end
