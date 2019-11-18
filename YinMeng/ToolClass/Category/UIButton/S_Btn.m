//
//  S_Btn.m
//  LHNewReader
//
//  Created by 杜文亮 on 2017/12/22.
//  Copyright © 2017年 Su Lei Han. All rights reserved.
//

#import "S_Btn.h"

@implementation S_Btn

-(instancetype)initWithFrame:(CGRect)frame bgColor:(UIColor *)color tag:(NSInteger)tag titleImage:(SetTitileImage)titleImage clickAction:(ClickedAction)clickAction
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = color;
        self.tag = tag;
        [self addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        if (titleImage)
        {
            titleImage(self);
        }
        self.clickedAction = clickAction;
    }
    return self;
}

-(void)clickAction:(UIButton *)sender
{
    if (self.clickedAction)
    {
        self.clickedAction(sender);
    }
}

@end
