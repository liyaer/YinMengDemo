//
//  Dwl_Common.m
//  YinMeng
//
//  Created by ZZCN77 on 2018/6/11.
//  Copyright © 2018年 ZZCN77. All rights reserved.
//

#import "Dwl_Common.h"


static Dwl_Common *_instance;


@implementation Dwl_Common
{
    MBProgressHUD *_progress;
}

#pragma mark - 单利初始化

+(instancetype)instance
{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    
    // 由于alloc方法内部会调用allocWithZone: 所以我们只需要保证在该方法只创建一个对象即可
    dispatch_once(&onceToken,^{
        
        // 只执行1次的代码(这里面默认是线程安全的)
        _instance = [super allocWithZone:zone];
        _instance.isEndCountDown = YES;//初始化，默认倒计时结束
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}




#pragma mark - 提示框

-(void)setProgressWithTitle:(NSString *)title isNetWorkType:(BOOL)isNetWork
{
    //默认效果
//    _progress = [MBProgressHUD showHUDAddedTo:DWindow animated:YES];
//    _progress.label.text = NSLocalizedString(title, @"HUD message title");

    //修改默认效果
    _progress= [[MBProgressHUD alloc] initWithView:DWindow];
    _progress.label.text = NSLocalizedString(title, @"HUD message title");
    _progress.label.textColor = [UIColor whiteColor];
    //修改样式，否则等待框背景色将为半透明
    _progress.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    //设置等待框背景色为黑色
    _progress.bezelView.backgroundColor = [UIColor blackColor];
    _progress.removeFromSuperViewOnHide = YES;
    //设置菊花框为白色
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
//    //修改默认遮罩效果
//    _progress.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
//    _progress.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.4f];
    [DWindow addSubview:_progress];
    [_progress showAnimated:YES];
    
    if (!isNetWork)
    {
        //显示类型
        _progress.mode = MBProgressHUDModeText;
        
        //取消按钮
        [_progress.button setTitle:NSLocalizedString(@"Cancel", @"HUD cancel button title") forState:UIControlStateNormal];
        [_progress.button addTarget:self action:@selector(cancelWork:) forControlEvents:UIControlEventTouchUpInside];
        
        [_progress hideAnimated:YES afterDelay:3.f];
    }
}

- (void)cancelWork:(UIButton *)sender
{
    [_progress hideAnimated:YES];
}

-(void)hiddenProgress
{
    [_progress hideAnimated:YES afterDelay:0.0];
}




#pragma mark - 倒计时

//倒计时
- (void)timeCountDownWithSeconds:(NSInteger)seconds EndBlock:(void(^)(void)) endBlock StartBlock:(void(^)(NSInteger second)) startBlock
{
    //倒计时时间 - 60S
    __block NSInteger timeOut = seconds - 1;
    //执行队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //计时器 -》 dispatch_source_set_timer自动生成
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^
      {
          if (timeOut <= 0) // 倒计时结束
          {
              dispatch_source_cancel(timer);
              //主线程设置按钮样式
              dispatch_async(dispatch_get_main_queue(), ^
                 {
                     self.isEndCountDown = YES;
                     if (endBlock)
                     {
                         endBlock();
                     }
                 });
          }
          else//开始计时
          {
              //剩余秒数 needSecond
              NSInteger needSecond = timeOut % seconds;
              self.toNextCommit = needSecond;
              //主线程设置按钮样式
              dispatch_async(dispatch_get_main_queue(), ^
                 {
                     self.isEndCountDown = NO;
                     if (startBlock)
                     {
                         startBlock(needSecond);
                     }
                 });
              timeOut--;
          }
      });
    dispatch_resume(timer);
}


@end
