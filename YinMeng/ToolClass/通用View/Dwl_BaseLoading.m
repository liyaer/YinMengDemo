//
//  LoadingView.m
//  BookReader
//
//  Created by 杜文亮 on 2018/3/13.
//  Copyright © 2018年 心动文学. All rights reserved.
//

#import "Dwl_BaseLoading.h"


@interface Dwl_BaseLoading()

@property (nonatomic,strong) UIImageView *load;
@property (nonatomic,strong) UIImageView *reload;

@end


@implementation Dwl_BaseLoading

-(UIImageView *)load
{
    if (!_load)
    {
        _load = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 98, 25)];
        _load.center = self.center;
        
        NSMutableArray *images = [NSMutableArray arrayWithCapacity:4];
        for (int i = 0; i < 4; i++)
        {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_0%d",i+1]];
            [images addObject:image];
        }
        
        _load.animationImages = images;
        _load.animationDuration = 2.0;
        _load.animationRepeatCount = 0;//为默认的无限循环
        [_load startAnimating];//开始播放动画
    }
    return _load;
}

-(UIImageView *)reload
{
    if (!_reload)
    {
        _reload = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 146, 78)];
        _reload.center = self.center;
        _reload.image = [UIImage imageNamed:@"reload"];
        //通过响应者链响应tap事件
        _reload.userInteractionEnabled = YES;
    }
    return _reload;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadAction)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)reloadAction
{
    [self addLoadRemoveReload];
    
    if (self.reloadBlock)
    {
        self.reloadBlock();
    }
}




#pragma mark - 控制属性和方法

-(void)setNewFrame:(CGRect)newFrame
{
    _newFrame = newFrame;
    
    self.frame = newFrame;
}

-(void)addLoadRemoveReload
{
    self.userInteractionEnabled = NO;
    
    [self addSubview:self.load];
    
    [_reload removeFromSuperview];
    _reload = nil;
}

-(void)removeLoadAddReload
{
    self.userInteractionEnabled = YES;
    
    [_load removeFromSuperview];
    _load = nil;
    
    [self addSubview:self.reload];
}


@end
