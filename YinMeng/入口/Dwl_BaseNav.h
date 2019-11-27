//
//  Dwl_BaseNav.h
//  YinMeng
//
//  Created by ZZCN77 on 2018/6/8.
//  Copyright © 2018年 ZZCN77. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIViewController+BackButtonHandler.h"


//侧滑返回的三种实现方式
#define BackGestureType 2
/*
 *  拦截“点击”导航栏返回按钮事件的两种方式:（注意侧滑返回不受影响，仍然可侧滑返回，因此某些页面为了执行拦截逻辑，该页面需要禁止侧滑返回）
 *      1，返回按钮是backBarButtonItem（自带默认的侧滑返回，配合 UIViewController+BackButtonHandler 使用）
 *      2，。。。。。leftBarButtonItem（没有。。。。。。。，。。。。。。。。。。。。。。。。。。。。。。。。。。）
 */
#define BackActionInterceptType 1


@interface Dwl_BaseNav : UINavigationController

#if BackGestureType == 2
@property (nonatomic, strong) UIPanGestureRecognizer *customPanGesture;
#endif

@end
