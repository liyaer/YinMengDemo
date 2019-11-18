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

@end
