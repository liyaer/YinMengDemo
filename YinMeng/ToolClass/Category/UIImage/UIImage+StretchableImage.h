//
//  UIImage+StretchableImage.h
//  3DTouchDemo
//
//  Created by 杜文亮 on 2017/10/20.
//  Copyright © 2017年 杜文亮. All rights reserved.
//


/*
 *   拉伸图片
     根据图片本身和需要达到的效果不同，拉伸点和拉伸区域也不固定。但是有一点经验之谈，那就是拉伸区域越小，效果越好
 */
#import <UIKit/UIKit.h>

@interface UIImage (StretchableImage)

//方法一(iOS5之前使用的方法)
+ (instancetype)imageWithStretchableName:(NSString *)imageName;

//方法二（iOS5新增）
+ (instancetype)imageWithResizableName:(NSString *)imageName operateArea:(UIEdgeInsets)edge;

//方法三（iOS6新增）对方法二的扩展
+ (instancetype)imageWithResizableName:(NSString *)imageName operateArea:(UIEdgeInsets)edge resizableMode:(UIImageResizingMode)mode;//（UIImageResizingModeTile：平铺     UIImageResizingModeStretch：拉伸）

@end


/*
 *                      iOS5之前 -- stretchableImageWithLeftCapWidth
 
 这个函数是UIImage的一个实例函数，它的功能是创建一个内容可拉伸，而边角不拉伸的图片，需要两个参数，第一个是左边不拉伸区域的宽度，第二个参数是上面不拉伸的高度。
 
 根据设置的宽度和高度，将接下来的一个像素进行左右扩展和上下拉伸。
 
 注意：可拉伸的范围都是距离leftCapWidth后的1竖排像素，和距离topCapHeight后的1横排像素。
 
 参数的意义是，如果参数指定10，5。那么，图片左边10个像素，上边5个像素。不会被拉伸，x坐标为11和一个像素会被横向复制，y坐标为6的一个像素会被纵向复制。
 
 注意：只是对一个像素（11，6）进行复制到一定宽度。而图像后面的剩余像素也不会被拉伸。
 
 */


/*
 *                  iOS5新增 -- resizableImageWithCapInsets
 
 resizableImageWithCapInsets只对指定的UIEdgeInset区域进行拉伸或者压缩
 */
