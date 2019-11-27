//
//  Dwl_DetailVC.m
//  YinMeng
//
//  Created by Mac on 2019/10/25.
//  Copyright © 2019 ZZCN77. All rights reserved.
//

#import "Dwl_DetailVC.h"
#import "Dwl_TestVC.h"


@interface Dwl_DetailVC ()

@end


@implementation Dwl_DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"详情页";
    
    [self addScrollView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint touch = [[touches anyObject] locationInView:self.view];
    if (touch.x > 250 && touch.y > 400) {
        Dwl_TestVC *vc = [[Dwl_TestVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 测试：Nav侧滑返回 和 UIScrollView 并存

//测试发现：
//  1，BackActionInterceptType = 1（系统自带返回按钮backBarButtonItem）, BackGestureType = 1（系统自带侧滑手势）， 侧滑手势不受UIScrollView影响，二者可并存；
//  2，BackActionInterceptType = 2（自定义返回按钮leftBarButtonItem）, BackGestureType = 1（系统自带侧滑手势），侧滑手势失效；
//  3，BackActionInterceptType = 1（系统自带返回按钮backBarButtonItem）, BackGestureType = 2（自定义侧滑手势），侧滑手势失效；
//  4，BackActionInterceptType = 2（自定义返回按钮leftBarButtonItem）, BackGestureType = 2（自定义侧滑手势），侧滑手势失效；
//其中3、4可通过对自定义手势的设置达到并存效果，但是2目前暂无解决方案

- (void)addScrollView {
    UIScrollView *testScoller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavHeight + 20, DScreenWidth, 200)];
    testScoller.backgroundColor = [UIColor purpleColor];
    testScoller.contentSize = CGSizeMake(DScreenWidth * 2, 200 * 2);
    [self.view addSubview:testScoller];
}

@end
