//
//  NSMutableArray+AddNil.m
//  test
//
//  Created by 杜文亮 on 2017/11/28.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "NSMutableArray+AddNil.h"
#import <objc/runtime.h>

@implementation NSMutableArray (AddNil)

+ (void)load//在将文件加载入内存时自动调用一次，该调用发生在Main函数调用之前
{
    Method orginalMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(addObject:));
    Method newMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(chj_addObject:));
    //交换系统方法
    method_exchangeImplementations(orginalMethod, newMethod);
}

//自己的方法
- (void)chj_addObject:(id)object
{
    if (object != nil)
    {
        [self chj_addObject:object];//注意写成新方法
    }
}

@end
