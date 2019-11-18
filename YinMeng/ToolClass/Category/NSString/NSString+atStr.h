//
//  NSString+atStr.h
//  BookReader
//
//  Created by 杜文亮 on 2018/4/8.
//  Copyright © 2018年 心动文学. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (atStr)

//将string转成富文本
+(NSMutableAttributedString *)atStrWithString:(NSString *)string Attributes:(NSDictionary *)dict Range:(NSRange)range;

@end
