//
//  S_Btn.h
//  LHNewReader
//
//  Created by 杜文亮 on 2017/12/22.
//  Copyright © 2017年 Su Lei Han. All rights reserved.
//

/*
 *   通过自定义子类实现对系统btn做简单的封装（实现这个最好的是做个UIButton的分类）
 */

#import <UIKit/UIKit.h>


typedef void(^SetTitileImage)(UIButton *btn);
typedef void(^ClickedAction)(UIButton *btn);


@interface S_Btn : UIButton

@property (nonatomic,copy) ClickedAction clickedAction;


-(instancetype)initWithFrame:(CGRect)frame bgColor:(UIColor *)color tag:(NSInteger)tag titleImage:(SetTitileImage)titleImage clickAction:(ClickedAction)clickAction;

@end
