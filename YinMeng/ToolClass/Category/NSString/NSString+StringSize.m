//
//  NSString+StringSize.m
//  LHNewReader
//
//  Created by pro on 17/4/11.
//  Copyright © 2017年 Su Lei Han. All rights reserved.
//

#import "NSString+StringSize.h"

@implementation NSString (StringSize)

/*
    终于明白为什么每次用这个方法计算控件（Label，textView）的高度时，依然会出现文字显示不全的情况。
 
    原因：这个方法计算出来的是“文字”在固定宽度下的高度
            1,控件中的文字并不是从控件的（0，0）处显示的（这样会造成本来文字，假设是6个字，经过该方法计算刚好一行即可显示完毕，但是放在控件中，由于内间距的原因，导致一行只能显示5个字，就不得不分两行显示。但是该方法给出的高度是一行的高度），
            2,控件中文字换行规则可能和该方法的计算规则不同，会造成微小误差（经常看到距离右边还有一段距离，文字就换行了，但是该计算方法可能内部并不是这样的）
        因此会随着行数的增加逐渐增大误差
 
    解决办法：
        首先，外界调用该方法时，传入的size中的宽度应适当的小于控件的宽度，比如控件宽是20，那么应传入（20 -2*估算的X方向内间距）
        其次，外界获得计算结果后，将size中的高度 + 合适的一个高度作为控件最终的高度。通常+2*估算的Y方向内间距即可；若不行，可再适当再加大
 */
+(CGSize)boundingRectWithSize:(CGSize)size Font:(UIFont *)font text:(NSString *)text
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGSize retSize = [text boundingRectWithSize:size
                                        options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    
    return retSize;
}

@end
