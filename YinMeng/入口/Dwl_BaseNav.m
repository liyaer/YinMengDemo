//
//  Dwl_BaseNav.m
//  YinMeng
//
//  Created by ZZCN77 on 2018/6/8.
//  Copyright © 2018年 ZZCN77. All rights reserved.
//

#import "Dwl_BaseNav.h"


@interface Dwl_BaseNav ()<UIGestureRecognizerDelegate>

@end


@implementation Dwl_BaseNav

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.translucent = YES;
    self.navigationBar.barTintColor = ThemeColor(1.0);
    //设置字体
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20], NSForegroundColorAttributeName:[UIColor brownColor]}];

    //侧滑返回
#if BackGestureType == 1
    [self systemGestureWithNavgationTransition];
#elif BackGestureType == 2
    [self customGestureWithSystemNavgationTransition];
#else
    [self customGestureWithNavgationTransition];
#endif
}

#pragma mark - 侧滑返回

#if BackGestureType == 1
//方式一：系统自带的侧滑返回手势 + 系统动画效果（只能在左侧边缘触发）
- (void)systemGestureWithNavgationTransition {
//系统默认只有设置backBarButtonItem才有侧滑返回；一旦设置了leftBarButtonItem，侧滑返回就失效了，需要额外明确进行此设置
#if BackActionInterceptType == 2
    self.interactivePopGestureRecognizer.delegate = (id)self;
#endif
}
#elif BackGestureType == 2
//方式二：自定义侧滑返回手势代替系统的侧滑返回手势 + 系统动画效果（可以随意控制触发的范围）
- (void)customGestureWithSystemNavgationTransition {
    [self.view addGestureRecognizer:self.customPanGesture];
}

// 是否允许触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.childViewControllers.count > 1) { //如果是根视图控制器则不需要
        CGPoint touchPoint = [gestureRecognizer locationInView:self.view];
        if (touchPoint.x < DScreenWidth / 3) { //控制触发范围
            CGPoint speed = [(UIPanGestureRecognizer *)gestureRecognizer velocityInView:self.view];
            if (speed.x > 0 && speed.x > speed.y) {
                return YES;
            }
        }
    }
    return NO;
}
#elif BackGestureType == 3
//方式三：自定义侧滑返回手势 + 自定义转场动画（可以随意控制触发的范围、动画效果）
- (void)customGestureWithNavgationTransition {
    
}
#endif

#pragma mark - 统一设置返回按钮

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSInteger count = self.childViewControllers.count;
#if BackActionInterceptType == 1
    if (count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    //设置backBarButtonItem的话，只能通过initWithTitle；initWithImage会看到<和设置的image同时存在；initWithCustom无效果
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    back.tintColor = [UIColor whiteColor];
    //作为backBarButtonItem，点击时会触发shouldPopItem方法（系统内部自动实现了pop操作）
    viewController.navigationItem.backBarButtonItem = back;
#elif BackActionInterceptType == 2
    if (count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *btn = [UIButton createBtnFrame:CGRectMake(0, 0, 44, 44) bgColor:nil tag:0 titleImage:^(UIButton *btn) {
            [btn setImage:[UIImage imageNamed:@"nav_left"] forState:UIControlStateNormal];
            [btn sizeToFit];
        } clickAction:^(UIButton *btn) {
            if ([viewController respondsToSelector:@selector(leftBarButtonItemHandler)]) {
                [viewController leftBarButtonItemHandler];
            } else {
                [self popViewControllerAnimated:YES];
            }
        }];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        //作为leftBarButtonItem，点击时不会触发shouldPopItem方法（该方法只有pop操作才会调用）
        viewController.navigationItem.leftBarButtonItem = leftItem;
    }
#endif
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 懒加载

#if BackGestureType == 2
- (UIPanGestureRecognizer *)customPanGesture {
    if (!_customPanGesture) {
        //获取系统默认滑动返回手势(只能在屏幕的边缘才能触发该手势，不能在屏幕的任意一点触发该手势)
        UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer = (UIScreenEdgePanGestureRecognizer *)self.interactivePopGestureRecognizer;
        // 禁用系统的屏幕边缘滑动手势
        edgePanGestureRecognizer.enabled = NO;
        
        //自定义的滑动手势代替系统滑动返回手势
        _customPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:edgePanGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
        _customPanGesture.delegate = self;
    }
    return _customPanGesture;
}
#endif

@end


2，backBar自定义
分类git更新
