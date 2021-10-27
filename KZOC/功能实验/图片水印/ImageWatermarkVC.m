//
//  ImageWatermarkVC.m
//  KZOC
//
//  Created by KZ on 2021/10/27.
//

#import "ImageWatermarkVC.h"
#import "TZImagePickerController.h"

@interface ImageWatermarkVC ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ImageWatermarkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"choose photo" style:UIBarButtonItemStylePlain target:self action:@selector(choosePhotoAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.imageView.center = self.view.center;
    [self.view addSubview:self.imageView];
    
}

- (void)choosePhotoAction {
    
//    UIGraphicsBeginImageContext(CGSizeMake(300, 300));
//    NSString *dd = @"警方立刻结束";
//    [dd drawInRect:CGRectMake(0, 270, 300, 30) withAttributes:@{
//        NSForegroundColorAttributeName:[UIColor redColor],
//        NSFontAttributeName:[UIFont systemFontOfSize:40],
//    }];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    self.imageView.image = image;
//    self.imageView.backgroundColor = [UIColor whiteColor];
//    return;
    
    
    
    
    TZImagePickerController *imagePicker = [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:nil];
    [imagePicker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (photos.count > 0) {
            
            UIImage *image = [self tools_addWatermark:[photos firstObject] showText:nil];
            
            CGFloat imageW = image.size.width > self.view.frame.size.width ? self.view.frame.size.width : image.size.width;
            CGFloat imageH = image.size.height / image.size.width * imageW;

            [self.imageView setFrame:CGRectMake(0, 0, imageW, imageH)];
            self.imageView.center = self.view.center;
            self.imageView.image = image;
        }
    }];
    [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
}
#pragma mark - 添加水印
- (UIImage *)tools_addWatermark:(UIImage *)image showText:(NSString *)showText {
    
    if(showText == nil || [showText isEqualToString: @""]) {
        showText = @" 请设置水印内容 ";
    }
    
    int imageW = image.size.width;
    int imageH = image.size.height;
    //开始上下文
    UIGraphicsBeginImageContext(image.size);
    
    [image drawInRect:CGRectMake(0, 0, imageW, imageH)];
    
    //设置段落属性
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentRight;
    
    //设置文字属性
    NSDictionary *attribute = @{
        NSFontAttributeName: [UIFont systemFontOfSize:22],
        NSParagraphStyleAttributeName: paragraphStyle,
        NSForegroundColorAttributeName : [UIColor whiteColor],
        NSBackgroundColorAttributeName:[[UIColor blackColor]colorWithAlphaComponent:.4],
//        NSTextEffectAttributeName: NSTextEffectLetterpressStyle
    };
    
    [showText drawInRect:CGRectMake(0, imageH - 30,imageW , 30) withAttributes:attribute];
    //获取到新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
