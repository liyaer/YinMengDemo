//
//  NSString+JsonObject.m
//  赋值操作
//
//  Created by 杜文亮 on 2017/12/25.
//  Copyright © 2017年 CompanyName（公司名）. All rights reserved.
//

#import "NSString+JsonObject.h"

@implementation NSString (JsonObject)

//Json序列化
+(NSString *)jsonStringWithObject:(id)object
{
    NSString *jsonString = nil;
    if (object)
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
        if (!jsonData)
        {
            DLog(@"序列化 Get an error: %@", error);
        }
        else
        {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }
    else
    {
        DLog(@"传入的OC对象为空！");
    }
    return jsonString;
}

//Json反序列化
+(NSArray *)arrayWithJsonString:(NSString *)JSONString
{
    NSArray *responseJSON = nil;
    if (JSONString)
    {
        NSError *error;
        NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
        responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:&error];
        if (!responseJSON)
        {
            DLog(@"反序列化 Get an error: %@", error);
        }
    }
    else
    {
        DLog(@"传入的JsonString为空！");
    }
    return responseJSON;
}
+(NSDictionary *)dictionaryWithJsonString:(NSString *)JSONString;
{
    NSDictionary *responseJSON = nil;
    if (JSONString)
    {
        NSError *error;
        NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
        responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:&error];
        if (!responseJSON)
        {
            DLog(@"反序列化 Get an error: %@", error);
        }
    }
    else
    {
        DLog(@"传入的JsonString为空！");
    }
    return responseJSON;
}


@end
