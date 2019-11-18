//
//  UIImage+RenderingMode.m
//  3DTouchDemo
//
//  Created by 杜文亮 on 2017/10/20.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "UIImage+RenderingMode.h"

@implementation UIImage (RenderingMode)

+ (instancetype)imageWithOriginalName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
