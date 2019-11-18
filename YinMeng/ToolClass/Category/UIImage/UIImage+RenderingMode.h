//
//  UIImage+RenderingMode.h
//  3DTouchDemo
//
//  Created by 杜文亮 on 2017/10/20.
//  Copyright © 2017年 杜文亮. All rights reserved.
//


/*
 *   一般用于给nav、tabbar的Item设置图片，github上有Demo
 */

#import <UIKit/UIKit.h>

@interface UIImage (RenderingMode)

// 指定渲染模式，加载最原始的图片
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

@end
