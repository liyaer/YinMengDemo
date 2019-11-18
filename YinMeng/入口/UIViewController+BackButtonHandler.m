//
//  UIViewController+BackButtonHandler.m
//  YinMeng
//
//  Created by Mac on 2019/11/1.
//  Copyright © 2019 ZZCN77. All rights reserved.
//

#import "UIViewController+BackButtonHandler.h"

@implementation UIViewController (BackButtonHandler)

@end


@implementation UINavigationController (ShouldPopOnBackButton)

// 分类重写该系统方法，利用优先级高的原理屏蔽系统方法的调用（设置了backBarButtonItem使用这里，设置了leftBarButtonItem这里不用考虑）
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    // 只要调用了popViewControllerAnimated、popToViewController、popToRootViewControllerAnimated这里条件就会成立
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    
    BOOL shouldPop = YES;
    UIViewController *vc = [self topViewController];
    if([vc respondsToSelector:@selector(backBarButtonItemHandler)]) {
        shouldPop = [vc backBarButtonItemHandler];
    }
    
    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES]; //2 异步调用，会先执行1；popViewControllerAnimated会重新触发 shouldPop 的调用
        });
    } else { // 取消 pop 后，复原返回按钮的状态
        for(UIView *subview in [navigationBar subviews]) {
            if(0. < subview.alpha && subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
    }
    return NO; //1 NO表示不会pop成功
}

@end
