//
//  UIButton+Block.m
//  LHNewReader
//
//  Created by 杜文亮 on 2017/12/23.
//  Copyright © 2017年 Su Lei Han. All rights reserved.
//

#import "UIButton+Block.h"
#import <objc/runtime.h>

static NSString *keyOfClickAction;

@implementation UIButton (Block)

+ (UIButton *)createBtnFrame:(CGRect)frame bgColor:(UIColor *)color tag:(NSInteger)tag titleImage:(SetTitileImage)titleImage clickAction:(ClickedAction)clickAction
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.backgroundColor = color;
    button.tag = tag;
    if (titleImage)
    {
        titleImage(button);
        
        //取消点击时的高亮效果
        button.adjustsImageWhenHighlighted = NO;
    }
    [button addTarget:button action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    
    /**
     *用runtime中的函数通过key关联对象
     *
     *objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
     *id object                     表示关联者，是一个对象，变量名理所当然也是object
     *const void *key               获取被关联者的索引key
     *id value                      被关联者，这里是一个block
     *objc_AssociationPolicy policy 关联时采用的协议，有assign，retain，copy等协议，一般使用OBJC_ASSOCIATION_RETAIN_NONATOMIC
     */
    objc_setAssociatedObject (button , &keyOfClickAction , clickAction, OBJC_ASSOCIATION_COPY_NONATOMIC );
    
    return button;
}

- (void)tapAction:(UIButton*)sender
{
    /**
     * 通过key获取被关联对象
     *objc_getAssociatedObject(id object, const void *key)
     *
     */
    ClickedAction block = ( ClickedAction )objc_getAssociatedObject (sender , &keyOfClickAction );
    
    if (block)
    {
        block(sender);
    }
}


@end
