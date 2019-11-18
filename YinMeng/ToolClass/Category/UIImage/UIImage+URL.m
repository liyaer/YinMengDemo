//
//  UIImage+URL.m
//  Novel reading
//
//  Created by Hanley on 16/1/12.
//  Copyright © 2016年 SLH. All rights reserved.
//


#import "UIImage+URL.h"

@implementation UIImage (URL)

+(void)setImageFromURL:(NSString *)fileURL Path:(NSString*)path
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
        //保存本地
        [data writeToFile:[path stringByAppendingString:@"/bookCover.png"] atomically:YES];
    });
}


@end
