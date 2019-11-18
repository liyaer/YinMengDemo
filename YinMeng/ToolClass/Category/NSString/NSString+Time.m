//
//  NSString+Time.m
//  BookReader
//
//  Created by 杜文亮 on 2018/4/2.
//  Copyright © 2018年 心动文学. All rights reserved.
//

#import "NSString+Time.h"

/*
     yy: 年的后2位
     yyyy: 完整年
 
     MM: 月，显示为01-12
     MMM: 月，显示为英文月份简写,如 Jan
     MMMM: 月，显示为英文月份全称，如 Janualy
 
     dd: 日，2位数表示，如02
     d: 日，1-2位显示，如 2
 
     EEE: 简写星期几，如Sun
     EEEE: 全写星期几，如Sunday
 
     aa: 上下午，AM/PM
 
     H: 时，24小时制，0-23
     h：时，12小时制，0-11
 
     m: 分，1-2位
     mm: 分，2位
 
     s: 秒，1-2位
     ss: 秒，2位
     S: 毫秒
 */

@implementation NSString (Time)

+(NSString *)getStrTimeWithDateFormat:(NSString *)dateFormat date:(NSDate *)date
{
    // 实例化NSDateFormatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置日期格式
    [formatter setDateFormat:dateFormat];
    // 转换成字符串
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

+(NSString *)getStrTimeWithDateFormat:(NSString *)dateFormat seconds:(NSTimeInterval)seconds
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    return [self getStrTimeWithDateFormat:dateFormat date:date];
}

+(NSDate *)getDateWithStrTime:(NSString *)strTime
{
    // 实例化NSDateFormatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置日期格式
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 转成date
    NSDate *date = [formatter dateFromString:strTime];
    // 消除和实际时间之间的8小时的误差
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date dateByAddingTimeInterval:interval];
    return date;
}

+(NSString *)getStrTimeAgoWithSinceDate:(NSDate *)sinceDate
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:sinceDate];//单位为秒
    NSString *timeAgo;
    if (interval < 60) {
        timeAgo = @"刚刚";
    }else if(interval < 60 * 60){
        timeAgo = [NSString stringWithFormat:@"%ld分钟前",(NSInteger)interval / 60];
    }else if (interval < 60 * 60 *24){
        timeAgo = [NSString stringWithFormat:@"%ld小时前", (NSInteger)interval/ (60 *60)];
    }else if (interval < 60 * 60 * 24 * 30){
        timeAgo = [NSString stringWithFormat:@"%ld天前", (NSInteger)interval/(60 *60 *24)];
    }else{
        timeAgo = [NSDateFormatter localizedStringFromDate:sinceDate dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
    }
    return timeAgo;
}

+(NSString *)getStrTimeAgoWithSeconds:(NSTimeInterval)seconds
{
    NSDate *sinceDate = [NSDate dateWithTimeIntervalSince1970:seconds];
    return [self getStrTimeAgoWithSinceDate:sinceDate];
}


@end
