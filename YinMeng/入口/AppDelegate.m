//
//  AppDelegate.m
//  YinMeng
//
//  Created by ZZCN77 on 2018/6/8.
//  Copyright © 2018年 ZZCN77. All rights reserved.
//

#import "AppDelegate.h"
#import "Dwl_AnimationTabBar.h"


@interface AppDelegate ()

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //开启网络的实时监测
    [[Dwl_NetWork instance].manger startMonitoring];
    
    [self setRootVC];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



#pragma mark - 封装调用集合

-(void)setRootVC
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    Dwl_AnimationTabBar *tabBar = [[Dwl_AnimationTabBar alloc] initWithVCNames:@[@"Dwl_YKHShopVC",@"Dwl_LMShopVC",@"Dwl_JFShopVC",@"Dwl_ZXVC",@"Dwl_MineVC"] titles:@[@"亿卡汇商城",@"联盟商城",@"积分商城",@"资讯",@"个人中心"] images:@[@"",@"",@"",@"",@""] selectedImages:@[@"",@"",@"",@"",@""] selectedTitleColor:ThemeColor(1.0) unSelectedTitleColor:nil];
    self.window.rootViewController = tabBar;
    [self.window makeKeyAndVisible];
}


@end
