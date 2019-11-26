//
//  Dwl_BaseVC.m
//  YinMeng
//
//  Created by ZZCN77 on 2018/6/8.
//  Copyright © 2018年 ZZCN77. All rights reserved.
//

#import "Dwl_BaseVC.h"
#import "Dwl_BaseNoData.h"


@interface Dwl_BaseVC ()

@end


@implementation Dwl_BaseVC

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)addLoadingWithFrame:(CGRect)frame
{
    _loading = [[Dwl_BaseLoading alloc] initWithFrame:frame];
    [_loading addLoadRemoveReload];
    [self.view addSubview:_loading];
}

-(void)addNoDataWithFrame:(CGRect)frame
{
    [self.view addSubview:[Dwl_BaseNoData showWithFrame:frame]];
}

#pragma mark - 是否禁用侧滑返回手势

- (void)gesturePopEnable:(BOOL)enable {
#if BackGestureType == 1
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = enable;
    }
#elif BackGestureType == 2
    if ([self.navigationController isKindOfClass:[Dwl_BaseNav class]]) {
        Dwl_BaseNav *nav = (Dwl_BaseNav *)self.navigationController;
        if([nav respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            nav.customPanGesture.enabled = enable;
        }
    }
#endif
}

@end
