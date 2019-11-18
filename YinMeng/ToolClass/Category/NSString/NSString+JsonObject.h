//
//  NSString+JsonObject.h
//  赋值操作
//
//  Created by 杜文亮 on 2017/12/25.
//  Copyright © 2017年 CompanyName（公司名）. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSString (JsonObject)
/**
 *  将OC对象(字典或者数组)   转化为   Json格式的字符串（也叫Json序列化）
 **/
+(NSString *)jsonStringWithObject:(id)object;
/**
 *  将Json格式的字符串转化为OC对象（字典或数组）(也叫Json反序列化)
 **/
+(NSArray *)arrayWithJsonString:(NSString *)JSONString;
+(NSDictionary *)dictionaryWithJsonString:(NSString *)JSONString;

@end
