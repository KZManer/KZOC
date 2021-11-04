//
//  SNSCodeCountdownButton.m
//  SNSCodeTimerDemo
//
//  Created by CHENYI LONG on 14-11-24.
//  Copyright (c) 2014年 CHENYI LONG. All rights reserved.
//

#import "SNSCodeCountdownButton.h"

@interface SNSCodeCountdownButton () {
    int _countdown;
    NSTimer * _countdownTimer;
}
@end
@implementation SNSCodeCountdownButton
@synthesize normalStateImageName = _normalStateImageName;
@synthesize highlightedStateImageName;
@synthesize selectedStateImageName;
@synthesize normalStateBgImageName;
@synthesize highlightedStateBgImageName;
@synthesize selectedStateBgImageName;


- (void)pretreat {
    self.countdownBeginNumber = 60;
    self.normalStateBgImageName = @"userinfo_relationship_button_background";
    self.highlightedStateBgImageName = @"userinfo_relationship_button_background";
    self.selectedStateBgImageName = @"userinfo_relationship_button_highlighted";
    self.normalStateImageName = @"timerBtn_imageView_normal";
    self.highlightedStateImageName = @"timerBtn_imageView_highlighted";
    self.selectedStateImageName = @"timerBtn_imageView_selected";
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self = [self sharedInit];
    }
    return self;
}

- (id)sharedInit {
    [self setupBackgroundNotification];
    [self pretreat];
    return self;
}


- (id)initWithCoder: (NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}

- (void)setupBackgroundNotification {
    //页面将要进入前台，开启定时器
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(distantPastTimer)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    //页面消失，进入后台不显示该页面，关闭定时器
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(distantFutureTimer)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
}

- (void)drawRect:(CGRect)rect
{
    _countdown = self.countdownBeginNumber - 1;
    [self setupSendSNSCodeButton];
}

- (void)setupSendSNSCodeButton {
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self addTarget:self action:@selector(receiveCode) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)receiveCode{
    
    if ([self.delegate respondsToSelector:@selector(snsCodeCountdownButtonClicked:)]) {
        [self.delegate snsCodeCountdownButtonClicked:self];
    }
 //   [self initWithCountdownBeginNumber];
}

- (void)initWithCountdownBeginNumber  {
    self.userInteractionEnabled = NO;
    [self setTitle:[NSString stringWithFormat:@"还剩%ld秒",self.countdownBeginNumber - 1] forState:UIControlStateNormal];
    self.backgroundColor = [UIColor colorWithRed:152/155.0 green:154/255.0 blue:156/255.0 alpha:1.0];

    _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closeGetVerifyButtonUser) userInfo:nil repeats:YES];
}

-(void)closeGetVerifyButtonUser
{

    _countdown = _countdown-1;
    self.userInteractionEnabled = NO;
    [self setTitle:[NSString stringWithFormat:@"还剩%d秒",_countdown] forState:UIControlStateNormal];

    
    if(_countdown == 0){
        self.backgroundColor = [UIColor colorWithRed:152/155.0 green:154/255.0 blue:156/255.0 alpha:1.0];
        self.userInteractionEnabled = YES;
        [self setTitle:@"重新获取" forState:UIControlStateNormal];
       //  [self setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.backgroundColor = [UIColor redColor];
        _countdown = (int)self.countdownBeginNumber - 1;
        //注意此处不是暂停计时器,而是彻底注销,使_countdownTimer.valid == NO;
        [_countdownTimer invalidate];
    }
}


//页面将要进入前台，开启定时器
-(void)distantPastTimer
{
    //    if([_countdownTimer isValid]&&(_countdown >0))
    //    //开启定时器
    //    [_countdownTimer setFireDate:[NSDate distantPast]];
}

//页面消失，进入后台不显示该页面，关闭定时器
-(void)distantFutureTimer
{
    //    if([_countdownTimer isValid]&&(_countdown >0))
    //    //关闭定时器
    //    [_countdownTimer setFireDate:[NSDate distantFuture]];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:Nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:Nil];
}
@end
