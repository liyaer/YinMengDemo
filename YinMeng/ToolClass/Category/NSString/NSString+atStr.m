//
//  NSString+atStr.m
//  BookReader
//
//  Created by 杜文亮 on 2018/4/8.
//  Copyright © 2018年 心动文学. All rights reserved.
//

#import "NSString+atStr.h"

@implementation NSString (atStr)

+(NSMutableAttributedString *)atStrWithString:(NSString *)string Attributes:(NSDictionary *)dict Range:(NSRange)range
{
    NSMutableAttributedString *atStr = [[NSMutableAttributedString alloc] initWithString:string];
    [atStr addAttributes:dict range:range];
    return atStr;
}

@end
