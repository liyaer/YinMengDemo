//
//  NSString+MD5.h
//  BookReader
//
//  Created by 杜文亮 on 2018/4/4.
//  Copyright © 2018年 心动文学. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger
{
    Dmd5,
    Dmd5Salt,
    Dmd5ManyTimes,
    Dmd5Disorder
} Dmd5EncryptionLevel;//加密级别，也可以几种混合调用，大幅增加解密难度


@interface NSString (MD5)

+(NSString *)md5StrWithString:(NSString *)string EncryptionLevel:(Dmd5EncryptionLevel)level;

@end
