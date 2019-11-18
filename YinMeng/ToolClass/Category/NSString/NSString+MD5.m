//
//  NSString+MD5.m
//  BookReader
//
//  Created by 杜文亮 on 2018/4/4.
//  Copyright © 2018年 心动文学. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>

static NSString *Salt = @"nha735n197nxn(N′568GGS%d~~9naei';45vhhafdjkv]32rpks;lg,];:vjo(&**&^)";

@implementation NSString (MD5)

+(NSString *)md5StrWithString:(NSString *)string EncryptionLevel:(Dmd5EncryptionLevel)level
{
    switch (level)
    {
        case Dmd5: return [self MD5ForUpper16Bate:string]; break;
        case Dmd5Salt: return [self MD5AddSaltWithString:string]; break;
        case Dmd5ManyTimes: return [self MD5ManyTimesWithString:string]; break;
        default: return [self MD5DisorderWithString:string]; break;
    }
}

#pragma mark - Dmd5（MD5的基本加密）

// 32位 小写
+(NSString *)MD5ForLower32Bate:(NSString *)str
{
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}
// 32位 大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str
{
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}
// 16位 小写
+(NSString *)MD5ForLower16Bate:(NSString *)str
{
    NSString *md5Str = [self MD5ForLower32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++)
    {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}
// 16位 大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str
{
    NSString *md5Str = [self MD5ForUpper32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++)
    {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}

#pragma mark - Dmd5Salt（加盐）

+(NSString *)MD5AddSaltWithString:(NSString *)string
{
    return [self MD5ForUpper16Bate:[string stringByAppendingString:Salt]];
}

#pragma mark - Dmd5ManyTime（多次加密）

+(NSString *)MD5ManyTimesWithString:(NSString *)string
{
    for (int i = 0; i < 3; i++)
    {
        string = [self MD5ForUpper16Bate:string];
    }
    return string;
}

#pragma mark - Dmd5Disorder（一次加密后乱序）

+(NSString *)MD5DisorderWithString:(NSString *)string
{
    string = [self MD5ForUpper16Bate:string];
    //这里写个简单的乱序，可以自己设计复杂的乱序算法，增加解密难度
    NSString *header = [string substringToIndex:3];
    NSString *footer = [string substringFromIndex:3];
    string = [footer stringByAppendingString:header];
    return string;
}


@end
