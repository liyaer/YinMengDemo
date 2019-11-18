//
//  Dwl_AnimationTabBar.m
//  YinMeng
//
//  Created by ZZCN77 on 2018/6/8.
//  Copyright © 2018年 ZZCN77. All rights reserved.
//

#import "Dwl_AnimationTabBar.h"
#import "Dwl_BaseNav.h"


@interface Dwl_AnimationTabBar ()

@property (nonatomic,assign) NSInteger indexFlag;//记录上一次点击tabbar

@end


@implementation Dwl_AnimationTabBar

-(instancetype)initWithVCNames:(NSArray *)names titles:(NSArray *)titles images:(NSArray *)images selectedImages:(NSArray *)selectedImages selectedTitleColor:(UIColor *)selectedColor unSelectedTitleColor:(UIColor *)unSelectedColor
{
    if (self = [super init])
    {
        for (int i = 0; i < names.count; i++)
        {
            UIViewController *vc = [[NSClassFromString(names[i]) alloc] init];
            vc.title = titles[i];
            vc.tabBarItem.title = titles[i];
            vc.tabBarItem.image = [[UIImage imageNamed:images[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            Dwl_BaseNav *nav = [[Dwl_BaseNav alloc] initWithRootViewController:vc];
            [self addChildViewController:nav];
        }
        self.tabBar.tintColor = selectedColor;//设置选中Item的title颜色
        self.tabBar.translucent = NO;
    }
    return self;
}

//为初始化时默认选中的tabBarItem添加动画效果
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.indexFlag = -1;
    [self tabBar:self.tabBar didSelectItem:self.tabBar.selectedItem];
}




#pragma mark - UITabBarDelegate

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger index = [self.tabBar.items indexOfObject:item];
    
    //动画的设置
    if (self.animationType == NoAnimation) return;
    if (index != self.indexFlag)
    {
        //根据动画类型确定进行动画的view
        UIView *view;
        UIControl *tabBarButton = [item valueForKey:@"view"];
        UIImageView *tabBarSwappableImageView = [tabBarButton valueForKey:@"info"];
        view = self.animationType == ImageAnimation ? tabBarSwappableImageView : tabBarButton;
        
        [self scaleMode:view];
        self.indexFlag = index;//更新标识符
    }
}

//放大效果，并回到原位
-(void)scaleMode:(UIView *)view
{
    //创建动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;
    animation.repeatCount = 1;
    //完成动画后会回到执行动画之前的状态，默认值NO（实际上，因为layer动画并未真正对layer做出相关改变，只是一种视觉效果，所以即便设置为NO，动画结束后还是会回到动画前的状态，只不过是瞬间返回动画前的状态，不带有动画效果，而设置为YES，会带有动画效果）
    animation.autoreverses = YES;
    //    animation.removedOnCompletion = YES;//动画完成移除动画，默认YES，不写也可以
    //动画开始值（不设置的话，默认从当前值开始，当前值用1.0表示）
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    //动画结束值
    animation.toValue = [NSNumber numberWithFloat:1.3];
    //添加动画
    [view.layer addAnimation:animation forKey:nil];
}


@end
