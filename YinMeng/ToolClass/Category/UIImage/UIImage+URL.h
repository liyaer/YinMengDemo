//
//  UIImage+URL.h
//  Novel reading
//
//  Created by Hanley on 16/1/12.
//  Copyright © 2016年 SLH. All rights reserved.


/*
 *   下载图片并保存
 */
#import <UIKit/UIKit.h>

@interface UIImage (URL)

+(void)setImageFromURL:(NSString *)fileURL Path:(NSString*)path;

@end
