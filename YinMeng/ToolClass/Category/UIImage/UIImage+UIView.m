//
//  UIImage+UIView.m
//  Novel reading
//
//  Created by 辛喵喵 on 15/12/18.
//  Copyright © 2015年 SLH. All rights reserved.
//


#import "UIImage+UIView.h"

@implementation UIImage (UIView)

+(UIImage *)ImageWithView:(UIView *)View
{
    //UIGraphicsBeginImageContext(theView.bounds.size);
    UIGraphicsBeginImageContextWithOptions(View.bounds.size, NO, 0.0);
    [View.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
