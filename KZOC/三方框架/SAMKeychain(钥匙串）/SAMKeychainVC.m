//
//  SAMKeychainVC.m
//  KZOC
//
//  Created by KZ on 2021/10/27.
//

#import "SAMKeychainVC.h"
#import "SAMKeychain.h"

static NSString *KEYCHAINSERVICE = @"com.kz.keychain";
static NSString *USERNAME = @"com.kz.userName";
static NSString *PASSWORD = @"com.kz.passsword";

@interface SAMKeychainVC ()

@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *pwTF;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, copy) NSString *message;

@end

@implementation SAMKeychainVC

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"message"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self doViewUI];
    
    NSArray *arr = [SAMKeychain allAccounts];
    NSLog(@"%@",arr);
    
    [self addObserver:self forKeyPath:@"message" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - custom method
/**save button pressed*/
- (void)saveButtonPressed {
    if ([KTools tools_isBlankString:self.nameTF.text] || [KTools tools_isBlankString:self.pwTF.text]) {
        [MBProgressHUD showText:@"用户名或密码不能为空"];
        return;
    }
    [SAMKeychain setPassword:self.nameTF.text forService:KEYCHAINSERVICE account:USERNAME];
    [SAMKeychain setPassword:self.pwTF.text forService:KEYCHAINSERVICE account:PASSWORD];
    [self readKeychainInfo];
    
}

/**read button pressed*/
- (void)readButtonPressed {
    [self readKeychainInfo];
}

/**clear button pressed*/
- (void)clearButtonPressed {
    self.message = @"";
}

- (void)readKeychainInfo {
    if (!self.message) {
        self.message = @"";
    }
    NSString *userName = [SAMKeychain passwordForService:KEYCHAINSERVICE account:USERNAME];
    NSString *password = [SAMKeychain passwordForService:KEYCHAINSERVICE account:PASSWORD];
    NSString *uuid = [self UUID];
    self.message = [self.message stringByAppendingFormat:@"用户名：%@\n密\u3000码：%@\nUUID：%@\n",userName,password,uuid];
}

- (NSString *)UUID {
    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
    NSMutableString *tmpResult = result.mutableCopy;
    // 去除“-”
    NSRange range = [tmpResult rangeOfString:@"-"];
    while (range.location != NSNotFound) {
        [tmpResult deleteCharactersInRange:range];
        range = [tmpResult rangeOfString:@"-"];
    }
    NSLog(@"UUID:%@",tmpResult);
    return tmpResult;
}

#pragma mark - override method

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    self.textView.text = self.message;
}

#pragma mark - UI布局

- (void)doViewUI {
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.view.backgroundColor = Color_RGB_Same(245.0);
    
    /**用户名*/
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"用户名";
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
    
    self.nameTF = [[UITextField alloc]init];
    self.nameTF.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.nameTF];
    [self.nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(nameLabel);
        make.left.equalTo(nameLabel.mas_right).offset(10);
        make.right.mas_equalTo(-30);
    }];
    
    /**密码*/
    UILabel *pwLabel = [[UILabel alloc]init];
    pwLabel.text = @"密码";
    pwLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:pwLabel];
    [pwLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(nameLabel);
        make.top.equalTo(nameLabel.mas_bottom).offset(20);
    }];
    
    self.pwTF = [[UITextField alloc]init];
    self.pwTF.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.pwTF];
    [self.pwTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.width.equalTo(self.nameTF);
        make.top.equalTo(pwLabel);
    }];
    
    /**save button*/
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [saveBtn setTitle:@"save" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(80);
        make.top.equalTo(pwLabel.mas_bottom).offset(30);
        make.centerX.mas_equalTo(0).multipliedBy(0.5);
    }];
    
    /**read button*/
    UIButton *readBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [readBtn setTitle:@"read" forState:UIControlStateNormal];
    [readBtn setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    [readBtn addTarget:self action:@selector(readButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:readBtn];
    [readBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.equalTo(saveBtn);
        make.centerX.mas_equalTo(0).multipliedBy(1.5);
    }];
    
    /**text view*/
    self.textView = [[UITextView alloc]init];
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(saveBtn.mas_bottom).offset(30);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-100);
    }];
    [self.textView view_setCornerRadius:5.0f borderColor:nil borderWidth:0];
    
    /**clear button*/
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [clearBtn setTitle:@"清空展示信息" forState:UIControlStateNormal];
    [clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    clearBtn.backgroundColor = [UIColor systemBlueColor];
    [clearBtn addTarget:self action:@selector(clearButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearBtn];
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom).offset(20);
        make.left.right.equalTo(self.textView);
        make.height.mas_equalTo(44);
    }];
    [clearBtn view_setCornerRadius:5 borderColor:nil borderWidth:0];
}

@end
