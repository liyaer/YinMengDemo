//
//  Dwl_AnimationTabBar.h
//  YinMeng
//
//  Created by ZZCN77 on 2018/6/8.
//  Copyright © 2018年 ZZCN77. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger
{
    NoAnimation,//0，无动画
    ImageAnimation,//1，图片动画
    ImageTitleAnimation,//2，图片+文字动画
}
TabBarItemAnimationType;


@interface Dwl_AnimationTabBar : UITabBarController

-(instancetype)initWithVCNames:(NSArray *)names titles:(NSArray *)titles images:(NSArray *)images selectedImages:(NSArray *)selectedImages selectedTitleColor:(UIColor *)selectedColor unSelectedTitleColor:(UIColor *)unSelectedColor;

//设置点击tabBarItem带何种动画效果
@property (nonatomic,assign) TabBarItemAnimationType animationType;

@end
