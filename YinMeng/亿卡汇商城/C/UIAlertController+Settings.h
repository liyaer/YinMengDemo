//
//  UIAlertController+Settings.h
//  YinMeng
//
//  Created by Mac on 2019/11/13.
//  Copyright © 2019 ZZCN77. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (Settings)

+ (UIAlertController *)alertSettingsWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle actionTitles:(NSArray <NSString *> *)actionTitles actionStyles:(NSArray <NSNumber *> *)actionStyles actionHandlers:(NSArray <void(^)(void)> *)actionHandlers;

@end

NS_ASSUME_NONNULL_END
