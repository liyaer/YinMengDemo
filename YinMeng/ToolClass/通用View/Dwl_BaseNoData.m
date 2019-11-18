//
//  NoDataView.m
//  BookReader
//
//  Created by 杜文亮 on 2018/3/20.
//  Copyright © 2018年 心动文学. All rights reserved.
//

#import "Dwl_BaseNoData.h"


@interface Dwl_BaseNoData()

@property (nonatomic,strong) UIImageView *imgView;

@end


@implementation Dwl_BaseNoData

+(instancetype)showWithFrame:(CGRect)frame
{
    return [[self alloc] initWithFrame:frame];
}

-(UIImageView *)imgView
{
    if (!_imgView)
    {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 146, 78)];
        _imgView.image = [UIImage imageNamed:@"noData"];
    }
    return _imgView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.imgView];
        self.imgView.center = self.center;
    }
    return self;
}

@end
