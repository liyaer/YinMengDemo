//
//  UIAlertController+Settings.m
//  YinMeng
//
//  Created by Mac on 2019/11/13.
//  Copyright © 2019 ZZCN77. All rights reserved.
//

#import "UIAlertController+Settings.h"

@implementation UIAlertController (Settings)

+ (UIAlertController *)alertSettingsWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle actionTitles:(NSArray <NSString *> *)actionTitles actionStyles:(NSArray <NSNumber *> *)actionStyles actionHandlers:(NSArray <void(^)(void)> *)actionHandlers {
    if (actionTitles.count == actionStyles.count && actionStyles.count == actionHandlers.count) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
        for (int i = 0; i < actionTitles.count; i++) {
            [alertController addAction:[UIAlertAction actionWithTitle:actionTitles[i] style:actionStyles[i].integerValue handler:^(UIAlertAction * _Nonnull action) {
                if (actionHandlers[i]) {
                    actionHandlers[i]();
                }
            }]];
        }
        return alertController;
    } else {
        @throw [NSException exceptionWithName:NSStringFromSelector(_cmd) reason:@"传入的三个数组参数count不一致,会产生数据越界！" userInfo:nil];
    }
}

@end
