//
//  Dwl_Common.h
//  YinMeng
//
//  Created by ZZCN77 on 2018/6/11.
//  Copyright © 2018年 ZZCN77. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"


@interface Dwl_Common : NSObject<NSCopying,NSMutableCopying>

//单例初始化方法
+(instancetype)instance;




/*
 *   登录标识
 */
@property (nonatomic,assign) BOOL isLogin;

/*
 *   提示框
 */
-(void)setProgressWithTitle:(NSString *)title isNetWorkType:(BOOL)isNetWork;
-(void)hiddenProgress;

/*
 * 倒计时
 */
@property (nonatomic,assign) BOOL isEndCountDown;//倒计时是否结束
@property (nonatomic,assign) NSInteger toNextCommit;//剩余秒数
- (void)timeCountDownWithSeconds:(NSInteger)seconds EndBlock:(void(^)(void)) endBlock StartBlock:(void(^)(NSInteger second)) startBlock;


@end
