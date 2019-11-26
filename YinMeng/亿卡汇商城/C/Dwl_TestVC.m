//
//  Dwl_TestVC.m
//  YinMeng
//
//  Created by Mac on 2019/11/5.
//  Copyright © 2019 ZZCN77. All rights reserved.
//

#import "Dwl_TestVC.h"
#import "UIAlertController+Settings.h"


@interface Dwl_TestVC ()

@end


@implementation Dwl_TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"测试backBarItem";
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 该页面禁用侧滑返回手势

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self gesturePopEnable:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self gesturePopEnable:YES];
}

#pragma mark - 拦截返回按钮点击事件

//若有侧滑返回，请注意：
//测试发现popToRootViewControllerAnimated和popToViewController(若返回rootVC)，在viewWillDisappear发现存在self，但是不存在self.navVC，因此在这里设置nav是无效的；逐级返回（哪怕上级就是rootVC）或者跳级返回（只要不是返回rootVC），不会出现上述问题（也就是说存在self.navVC）。
//因此，禁用该页面的侧滑（即在viewWillDisappear中的设置）受上述影响，某些情况下会失效。目前的解决办法是，在受影响的操作前手动调用 gesturePopEnable
- (void)alertShow {
    void(^actionHandler_1)(void) = ^() {
        NSArray *VCs = self.navigationController.viewControllers;
        NSInteger currentIndex = [VCs indexOfObject:self.navigationController.topViewController];
        if (currentIndex >= 1) {
            [self.navigationController popToViewController:VCs[currentIndex-1] animated:YES];
        }
    };
    void(^actionHandler_2)(void) = ^() {
        [self gesturePopEnable:YES];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    };

    UIAlertController *alertVC = [UIAlertController alertSettingsWithTitle:@"nihao" message:@"返回上一级" preferredStyle:UIAlertControllerStyleAlert actionTitles:@[@"yes", @"no"] actionStyles:@[@(UIAlertActionStyleDefault), @(UIAlertActionStyleCancel)] actionHandlers:@[actionHandler_1, actionHandler_2]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#if BackActionInterceptType == 1
- (BOOL)backBarButtonItemHandler {
    [self alertShow];
    
    return NO;
}
#elif BackActionInterceptType == 2
- (void)leftBarButtonItemHandler {
    [self alertShow];
}
#endif

@end
