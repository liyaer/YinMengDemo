//
//  NSString+StringSize.h
//  LHNewReader
//
//  Created by pro on 17/4/11.
//  Copyright © 2017年 Su Lei Han. All rights reserved.
//


/*
 *   类别：根据文字内容和字体计算size
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (StringSize)

+ (CGSize)boundingRectWithSize:(CGSize)size Font:(UIFont *)font text:(NSString *)text;

@end
