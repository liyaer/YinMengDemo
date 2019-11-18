//
//  UIImage+StretchableImage.m
//  3DTouchDemo
//
//  Created by 杜文亮 on 2017/10/20.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "UIImage+StretchableImage.h"

@implementation UIImage (StretchableImage)

//方法一（默认对centerPoint进行拉伸，如有特殊需要，可自行改变）
+ (instancetype)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
}

//方法二
+ (instancetype)imageWithResizableName:(NSString *)imageName operateArea:(UIEdgeInsets)edge
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image resizableImageWithCapInsets:edge];
}

//方法三
+ (instancetype)imageWithResizableName:(NSString *)imageName operateArea:(UIEdgeInsets)edge resizableMode:(UIImageResizingMode)mode
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image resizableImageWithCapInsets:edge resizingMode:mode];
}


@end
