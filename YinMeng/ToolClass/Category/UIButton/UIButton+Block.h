//
//  UIButton+Block.h
//  LHNewReader
//
//  Created by 杜文亮 on 2017/12/23.
//  Copyright © 2017年 Su Lei Han. All rights reserved.
//


/*
 *  利用 runTime 实现对系统btn的简单封装
 */
#import <UIKit/UIKit.h>

//title和Image设置根据状态不同会有多个设置，所以对外暴露block，在外界完成
typedef void(^SetTitileImage)(UIButton *btn);
typedef void(^ClickedAction)(UIButton *btn);


@interface UIButton (Block)

+ (UIButton *)createBtnFrame:(CGRect)frame bgColor:(UIColor *)color tag:(NSInteger)tag titleImage:(SetTitileImage)titleImage clickAction:(ClickedAction)clickAction;

@end
