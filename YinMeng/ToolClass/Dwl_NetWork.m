//
//  Dwl_NetWork.m
//  YinMeng
//
//  Created by ZZCN77 on 2018/6/8.
//  Copyright © 2018年 ZZCN77. All rights reserved.
//

#import "Dwl_NetWork.h"


static Dwl_NetWork *_instance;


@implementation Dwl_NetWork

#pragma mark - 单利初始化

+(instancetype)instance
{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    
    // 由于alloc方法内部会调用allocWithZone: 所以我们只需要保证在该方法只创建一个对象即可
    dispatch_once(&onceToken,^
    {
        // 只执行1次的代码(这里面默认是线程安全的)
        _instance = [super allocWithZone:zone];
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




#pragma mark - AFNetworkReachabilityManager 网络监测

- (AFNetworkReachabilityManager *)manger
{
    if (!_manger)
    {
        // 1.获得网络监控的管理者
        _manger = [AFNetworkReachabilityManager sharedManager];
        // 2.设置网络状态改变后的处理
        __weak typeof(self) weakSelf = self;
        // 当网络状态改变了, 就会调用这个block
        [_manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
         {
             switch (status)
             {
                 case AFNetworkReachabilityStatusUnknown: // 未知网络
                     break;
                 case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                 {
                     NSLog(@"DLog会警告block循环引用------ meiwang");
                     NoNetTip;
                     weakSelf.hasNet = NO;
                 }
                     break;
                 case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                 {
                     weakSelf.hasNet = YES;
                 }
                     break;
                 case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                 {
                     NSLog(@"DLog会警告block循环引用------ WIFI");
                     weakSelf.hasNet = YES;
                 }
                     break;
             }
             
             //在网络监测完成时（hasNet已经被赋值），再执行检查新版本这部分代码
             if (weakSelf.getLaunchNetResult)
             {
                 weakSelf.getLaunchNetResult(weakSelf.hasNet);
             }
         }];
    }
    return _manger;
}




#pragma mark - 接口

//AFNetWorking 3.x版本  适配HTTPS请求 （根据需要确定是否开启HTTPS）
-(AFSecurityPolicy *)setSecurityPolicy
{
    //获取本地证书
    NSString * cerPath = [[NSBundle mainBundle] pathForResource:@"zz.oricg.com" ofType:@"cer"];
    NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
    //设置证书模式(AFSSLPinningModeCertificate证书认证模式，抓包无法抓取到；需要抓包测试的话，更改认证模式即可)
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:[[NSSet alloc] initWithObjects:cerData, nil]];
    //客户端是否信任非法证书
    securityPolicy.allowInvalidCertificates = YES;
    //是否在证书域字段中验证域名
    [securityPolicy setValidatesDomainName:NO];
    
    return securityPolicy;
}

//对Post方式请求的接口提供一个便利调用的封装
-(void)PostRequestWithPath:(NSString *)url Params:(id)dict Success:(SuccessBlock)DSuccess Error:(ErrorBlock)DError
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
//    session.securityPolicy = [self setSecurityPolicy];（根据需要确定是否开启HTTPS）
    [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    session.requestSerializer.timeoutInterval = 20.0;
    [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"text/xml",@"image/gif", nil];
    
    [session POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     }
    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         DLog(@"net sucess!-------------%@",responseObject);
         DSuccess(responseObject);
     }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         DLog(@"net error!-------------%@",error);
         DError(error);
     }];
}

//对Get方式请求的接口提供一个便利调用的封装
-(void)GetRequestWithPath:(NSString *)url Params:(id)dict Success:(SuccessBlock)DSuccess Error:(ErrorBlock)DError
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//    session.securityPolicy = [self setSecurityPolicy];（根据需要确定是否开启HTTPS）
    
    [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    session.requestSerializer.timeoutInterval = 20.0;
    [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"text/xml",@"image/gif", nil];
    
    [session GET:url parameters:dict progress:^(NSProgress * _Nonnull downloadProgress)
     {
         
     }
    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         DLog(@"net sucess!-------------%@",responseObject);
         DSuccess(responseObject);
     }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         DLog(@"net error!-------------%@",error);
         DError(error);
     }];
}

//检查是否有新版本
-(void)PostGetAppInfo:(NSString *)url sucess:(SuccessBlock) sucess Error:(ErrorBlock) error
{
#warning 这里不能用hasNet判断，原因是因为AF的网络监测结果还未回调。类似于这种需要在程序启动时进行判断网络的，不能用hasNet属性判断，需要通过getLaunchNetResult调用，使用block中的参数判断
    /*
     1，可以将判断写在上面封装的Post、Get方法中，调用更加简洁；但是灵活性不高
     2，写在这里或者写在外层调用时的好处，可以对不同的接口做不同的处理，虽然显得麻烦，但是灵活性高（本项目我选择写在外层调用的时候）
     3，不管是方式1还是2，都要注意接口类型，如果是在程序启动时的接口，为了准确性，统一使用getLaunchNetResult中的参数判断网络情况，其他接口可使用hasNet属性判断
     */
    //    if (self.hasNet)
    //    {
    [self PostRequestWithPath:url Params:nil Success:sucess Error:error];
    //    }
    //    else
    //    {
    //        DLog(@"没网的时候,本地存的是啥就按啥显示就可以！");
    //    }
}



@end
