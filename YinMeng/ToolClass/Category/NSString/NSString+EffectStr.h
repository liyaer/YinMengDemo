//
//  NSString+EffectStr.h
//  BookReader
//
//  Created by 杜文亮 on 2018/3/23.
//  Copyright © 2018年 心动文学. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSString (EffectStr)

//判断字符串是否为nil或@“”
+(BOOL)isEffectStr:(NSString *)string;

//手机号有效监测
+(BOOL)isMobileNumber:(NSString *)mobileNum;

//邮箱号有效监测
+(BOOL)isValidateEmail:(NSString *)email;

//去除字符串“开头”和“结尾”的空格（@“ ”）和换行符（\n）。注意只是开头和结尾，中间的不管
+(NSString *)deleteSpace:(NSString *)string;

//是否包含中文
+(BOOL)isChinese:(NSString *)string;


@end
