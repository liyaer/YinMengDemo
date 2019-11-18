//
//  Dwl_MineColHeader.m
//  YinMeng
//
//  Created by ZZCN77 on 2018/6/11.
//  Copyright © 2018年 ZZCN77. All rights reserved.
//

#import "Dwl_MineColHeader.h"

@implementation Dwl_MineColHeader

-(UILabel *)titleLab
{
    if (!_titleLab)
    {
        _titleLab = [[UILabel alloc] initWithFrame:self.bounds];
    }
    return _titleLab;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.titleLab];
    }
    return self;
}

@end
