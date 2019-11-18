//
//  NSString+Time.h
//  BookReader
//
//  Created by 杜文亮 on 2018/4/2.
//  Copyright © 2018年 心动文学. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Time)

//1，将NSDate、seconds转换成类似yyyy-MM-dd HH:mm:ss的格式，调用时自己指定格式
+(NSString *)getStrTimeWithDateFormat:(NSString *)dateFormat date:(NSDate *)date;
+(NSString *)getStrTimeWithDateFormat:(NSString *)dateFormat seconds:(NSTimeInterval)seconds;

//2,将类似yyyy-MM-dd HH:mm:ss的格式(strTime中用- . 空格都能成功转换)转换成NSDate
+(NSDate *)getDateWithStrTime:(NSString *)strTime;

//3,显示为几分钟前的格式
+(NSString *)getStrTimeAgoWithSinceDate:(NSDate *)sinceDate;
+(NSString *)getStrTimeAgoWithSeconds:(NSTimeInterval)seconds;

@end
