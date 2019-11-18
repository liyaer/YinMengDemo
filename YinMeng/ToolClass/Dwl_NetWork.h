//
//  Dwl_NetWork.h
//  YinMeng
//
//  Created by ZZCN77 on 2018/6/8.
//  Copyright © 2018年 ZZCN77. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Dwl_TipView.h"




//网络监测
typedef void (^getLaunchNetResult)(BOOL hasNet);
//接口
typedef void (^SuccessBlock)(id requestEncode);
typedef void (^ErrorBlock)(NSError *error);




@interface Dwl_NetWork : NSObject<NSCopying,NSMutableCopying>

//单利初始化
+(instancetype)instance;

//==============================网络监测================================

@property (nonatomic,strong) AFNetworkReachabilityManager *manger;
/*
 *   判断当前是否有网络链接
 */
@property (nonatomic,assign) BOOL hasNet;
/*
 *   每次启动时，在AppDelegate中先开启了网络监测，然后执行了检查是否有新版的代码。但是由于网络监测的block回调慢于检查更新代码的执行，导致在执行检查更新的时候，hasNet还未被赋值，此时是默认值NO(导致即使是联网状态下hasNet为NO)
 *   为了解决上述问题，设置一个block，在网络监测完成时（hasNet已经被赋值），再执行检查新版本这部分代码
 */
@property (nonatomic,copy) getLaunchNetResult getLaunchNetResult;

//==============================接口=================================

//检查是否有新版本
-(void)PostGetAppInfo:(NSString *)url sucess:(SuccessBlock) sucess Error:(ErrorBlock) error;



@end
