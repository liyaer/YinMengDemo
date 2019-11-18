//
//  TipView.m
//  WeChatMaker
//
//  Created by 杜文亮 on 17/8/8.
//  Copyright © 2017年 CompanyName（公司名）. All rights reserved.
//

#import "Dwl_TipView.h"
#import "NSString+StringSize.h"


#define scale 1.2
#define spaceToTop 10
#define spaceToLeft 8
#define defaultFont [UIFont boldSystemFontOfSize:14.0]


@implementation Dwl_TipView

#pragma mark - 便利初始化
//如果需要改时间，不想外面一个一个改，直接将这里的time改了就好
+(void)showHUD:(NSString *)content showTime:(CGFloat)time
{
    Dwl_TipView *view = [[self alloc] initWithContent:content];
    
    view.transform = CGAffineTransformIdentity;
    //damp越小，弹簧效果越明显；Velocity越大，速度越快
    [UIView animateWithDuration:0.5 delay:0.25 usingSpringWithDamping:0.1 initialSpringVelocity:0.9 options:UIViewAnimationOptionLayoutSubviews animations:^
     {
         view.transform = CGAffineTransformMakeScale(scale, scale);
         view.alpha = 1;
     }
    completion:^(BOOL finished)
    {        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
        {
            [UIView animateWithDuration:0.5 animations:^
            {
                view.transform = CGAffineTransformMakeScale(0.2, 0.2);
                view.alpha = 0;
            }
            completion:^(BOOL finished)
            {
                [view removeFromSuperview];
            }];
        });
     }];
}

#pragma mark - 指定初始化方法

-(instancetype)initWithContent:(NSString *)content
{
    if (self = [super init])
    {
        //根据文字内容，计算文字的size,限定动画后的self宽最大为300
        CGSize textSize = [NSString boundingRectWithSize:CGSizeMake(300 /scale -2*spaceToLeft, MAXFLOAT) Font:defaultFont text:content];
        
        //对self的设置
        self.frame = CGRectMake(0, 0, textSize.width +1 +2*spaceToLeft, textSize.height +1 +2*spaceToTop);
        self.center = CGPointMake(DScreenWidth /2, DScreenHeight *5/6);
        self.backgroundColor = DColor(56,58,57,1.0);
        self.layer.cornerRadius = 5.0;
        self.alpha = 0;
        
        //文字的size就是Label的size，+1为了避免计算出小数舍去造成的内容显示不完整
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(spaceToLeft, spaceToTop, textSize.width +1, textSize.height +1)];
        label.text = content;
        label.numberOfLines = 0;
        label.font = defaultFont;
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        
        //add
        [DWindow addSubview:self];
    }
    return self;
}


@end
